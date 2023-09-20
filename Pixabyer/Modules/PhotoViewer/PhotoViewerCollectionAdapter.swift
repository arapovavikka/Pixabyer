//
// PhotoViewerCollectionAdapter.swift
//

import Combine
import Foundation
import UIKit

final class PhotoViewerCollectionAdapter: BaseCollectionAdapter<PhotoViewModel> {
	var changedIndexPosition: AnyPublisher<Int, Never> { changedIndexPositionPassthrough.eraseToAnyPublisher() }

	var zoomedImage: AnyPublisher<Bool, Never> {
		zoomedImagePassthrough.eraseToAnyPublisher()
	}

	private var zoomedImagePassthrough = PassthroughSubject<Bool, Never>()
	private var changedIndexPositionPassthrough = PassthroughSubject<Int, Never>()

	override func connect(collectionView: UICollectionView) {
		super.connect(collectionView: collectionView)
		collectionView.register(PhotoCollectionCell.self, forCellWithReuseIdentifier: PhotoCollectionCell.reuseIdentifier)
		collectionView.register(PhotoErrorCollectionCell.self, forCellWithReuseIdentifier: PhotoErrorCollectionCell.reuseIdentifier)
	}

	override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
		super.collectionView(collectionView, willDisplay: cell, forItemAt: indexPath)

		if let cell = cell as? PhotoCollectionCell {
			cell.clearScale()
		}
	}

	override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		guard let viewModel = viewModel[safe: indexPath.row] else {
			return UICollectionViewCell()
		}

		if let cell = dequeueCell(for: PhotoCollectionCell.self, index: indexPath) {
			cell.update(with: viewModel.url)

			cell.zoomedImage.sink { isZoomed in
				self.zoomedImagePassthrough.send(isZoomed)
			}.store(in: cell)

			cell.showBlockingError.receive(on: DispatchQueue.main)
				.sink { error in
				self.viewModel[indexPath.row].error = error
				collectionView.reloadItems(at: [indexPath])
			}.store(in: cell)

			return cell
		}
		else {
			return UICollectionViewCell()
		}
	}

	override func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
		performHorizontalPaging(scrollView)
	}

	override func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
		performHorizontalPaging(scrollView)
	}
	
	func configureInitialState(with index: Int) {
		collectionView?.scrollToItem(at: IndexPath(row: index, section: 0), at: .centeredHorizontally, animated: false)
	}

	private func performHorizontalPaging(_ scrollView: UIScrollView) {
		guard let collectionView = collectionView else { return }
		let visibleRect = CGRect(origin: collectionView.contentOffset, size: collectionView.bounds.size)
		let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)

		if let visibleIndexPath = collectionView.indexPathForItem(at: visiblePoint) {
			collectionView.scrollToItem(at: visibleIndexPath, at: .centeredHorizontally, animated: true)
			changedIndexPositionPassthrough.send(visibleIndexPath.row)
		}
	}
}


class UICombineButton: UIButton {
	var touchUpInsidePublisher: AnyPublisher<Void, Never> {
		touchUpInsidePassthrough.eraseToAnyPublisher()
	}
	
	private let touchUpInsidePassthrough = PassthroughSubject<Void, Never>()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		addTarget(self, action: #selector(touchUpInsidePressed), for: .touchUpInside)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	@objc private func touchUpInsidePressed() {
		touchUpInsidePassthrough.send()
	}
}

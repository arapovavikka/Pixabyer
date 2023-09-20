//
// PhotoViewerView.swift
//

import Combine
import Foundation
import UIKit
import SnapKit

private extension Appearance {
	var flowLayout: UICollectionViewFlowLayout {
		let flow = UICollectionViewFlowLayout()
		flow.scrollDirection = .horizontal
		flow.minimumLineSpacing = 0
		flow.minimumInteritemSpacing = 0
		flow.sectionInset = UIEdgeInsets.zero
		return flow
	}
}

final class PhotoViewerView: BaseView {
	var verticalSwipe: AnyPublisher<Void, Never> { verticalSwipePassthrough.eraseToAnyPublisher() }
	lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: appearance.flowLayout)

	private var verticalSwipePassthrough = PassthroughSubject<Void, Never>()
	private lazy var verticalSwipeGesture: UISwipeGestureRecognizer = {
		let gesture = UISwipeGestureRecognizer(target: self, action: #selector(swipeGestureHandler))
		gesture.direction = [.down, .up]
		return gesture
	}()

	override func addSubviews() {
		super.addSubviews()
		addSubview(collectionView)
	}

	override func configure() {
		super.configure()
		collectionView.contentInsetAdjustmentBehavior = .never
		collectionView.backgroundColor = UIColor.black
		configureVerticalGestures(willDismissView: true)
	}

	override func makeConstraints() {
		super.makeConstraints()
		collectionView.snp.makeConstraints {
			$0.edges.equalToSuperview()
		}
	}

	func configureVerticalGestures(willDismissView: Bool) {
		if willDismissView {
			collectionView.addGestureRecognizer(verticalSwipeGesture)
		}
		else {
			collectionView.removeGestureRecognizer(verticalSwipeGesture)
		}
	}

	@objc private func swipeGestureHandler() {
		verticalSwipePassthrough.send()
	}
}

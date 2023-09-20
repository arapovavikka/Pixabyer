//
// WAPortal
// PhotoCollectionCell.swift
//

import Combine
import UIKit
import Kingfisher

private extension Appearance {
	var initialScale: CGFloat { 1.0 }
	var maxScale: CGFloat { 5.0 }
	var insetScale: CGFloat { 0.5 }
}


final class PhotoCollectionCell: BaseCombineCollectionViewCell {
	var zoomedImage: AnyPublisher<Bool, Never> { zoomedImagePassthrough.eraseToAnyPublisher() }
	var showBlockingError: AnyPublisher<Error, Never> { showBlockingErrorSubject.eraseToAnyPublisher() }

	private let scrollView = UIScrollView()
	private let innerScrollView = UIView()
	private let imageView = UIImageView()
	
	private var zoomedImagePassthrough = PassthroughSubject<Bool, Never>()
	private var showBlockingErrorSubject = PassthroughSubject<Error, Never>()

	override func addSubviews() {
		super.addSubviews()
		contentView.addSubview(scrollView)
		scrollView.addSubview(imageView)
	}

	override func configure() {
		super.configure()
		imageView.contentMode = .scaleAspectFit
		imageView.clipsToBounds = false
		imageView.isUserInteractionEnabled = true

		scrollView.delegate = self
		scrollView.minimumZoomScale = appearance.initialScale
		scrollView.maximumZoomScale = appearance.maxScale
		scrollView.isScrollEnabled = true
		scrollView.clipsToBounds = true
		scrollView.bouncesZoom = true
		scrollView.showsHorizontalScrollIndicator = false
		scrollView.showsVerticalScrollIndicator = false
	}

	override func makeConstraints() {
		super.makeConstraints()

		scrollView.snp.makeConstraints { make in
			make.bottom.leading
				.trailing.equalToSuperview()
			make.top.equalTo(safeAreaLayoutGuide.snp.topMargin)
		}

		imageView.snp.makeConstraints { make in
			make.edges.equalToSuperview()
			make.width.height.equalToSuperview()
		}
	}

	func update(with url: URL) {
		imageView.kf.setImage(with: url)
	}

	func clearScale() {
		scrollView.zoomScale = appearance.initialScale
	}
}

extension PhotoCollectionCell: UIScrollViewDelegate {
	func viewForZooming(in scrollView: UIScrollView) -> UIView? {
		return imageView
	}

	func scrollViewDidZoom(_ scrollView: UIScrollView) {
		guard scrollView.zoomScale > 1 else {
			scrollView.contentInset = .zero
			return
		}

		guard let image = imageView.image else { return }
		let ratioW = imageView.frame.width / image.size.width
		let ratioH = imageView.frame.height / image.size.height

		let minRatio = ratioW < ratioH ? ratioW : ratioH
		let newWidth = image.size.width * minRatio
		let newHeight = image.size.height * minRatio

		let conditionLeft = newWidth * scrollView.zoomScale > imageView.frame.width
		let horizontalInset = appearance.insetScale * (conditionLeft ? newWidth - imageView.frame.width : (scrollView.frame.width - scrollView.contentSize.width))
		let conditionTop = newHeight * scrollView.zoomScale > imageView.frame.height

		let verticalInset = appearance.insetScale * (conditionTop ? newHeight - imageView.frame.height : (scrollView.frame.height - scrollView.contentSize.height))
		scrollView.contentInset = UIEdgeInsets(top: verticalInset, left: horizontalInset, bottom: verticalInset, right: horizontalInset)
	}

	func scrollViewDidEndZooming(_ scrollView: UIScrollView, with view: UIView?, atScale scale: CGFloat) {
		zoomedImagePassthrough.send(scale != appearance.initialScale)
	}
}

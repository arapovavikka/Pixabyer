//
//  PhotoViewerViewController.swift
//  Pixabyer
//

import Foundation
import UIKit
import Combine

final class PhotoViewerViewController: UIViewController {
	private let customView = PhotoViewerView()
	private let baseAdapter = PhotoViewerCollectionAdapter()

	private let viewModel: PhotoViewerViewModel
	private var currentIndex: Int
	
	private var bag: Set<AnyCancellable> = []

	init(viewModel: PhotoViewerViewModel, currentIndex: Int) {
		self.viewModel = viewModel
		self.currentIndex = currentIndex
		super.init(nibName: nil, bundle: nil)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func loadView() {
		view = customView
		baseAdapter.connect(collectionView: customView.collectionView)
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		baseAdapter.update(viewModel: viewModel.photos)
		bind()
	}

	override func viewDidLayoutSubviews() {
		super.viewDidLayoutSubviews()
		baseAdapter.configureInitialState(with: currentIndex)
	}

	private func bind() {
		customView.verticalSwipe.sink { [weak self] _ in
			guard let self = self else { return }
			self.viewModel.closeModule()
		}.store(in: &bag)
		
		baseAdapter.changedIndexPosition.sink { [weak self] index in
			guard let self = self else { return }
			self.currentIndex = index
			self.customView.configureVerticalGestures(willDismissView: true)
		}.store(in: &bag)

		baseAdapter.zoomedImage.sink { [weak self] isZoomed in
			guard let self = self else { return }
			self.customView.configureVerticalGestures(willDismissView: !isZoomed)
		}.store(in: &bag)
	}
}


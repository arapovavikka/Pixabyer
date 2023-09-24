//
//  PhotoViewerModuleRouter.swift
//  Pixabyer
//

import Foundation
import UIKit

class PhotoViewerModuleRouter: Router {
	private let items: [PhotoViewModel]
	private let currentIndex: Int
	
	init(items: [PhotoViewModel], currentIndex: Int = 0) {
		self.items = items
		self.currentIndex = currentIndex
	}
	
	func createModule() -> UIViewController {
		let router = PhotoViewerRouter()
		let viewModel = PhotoViewerViewModel(photos: items, router: router)
		let viewController = PhotoViewerViewController(viewModel: viewModel, currentIndex: currentIndex)
		router.navigator = viewController
		return viewController
	}
}

protocol PhotoViewerRouterProtocol {
	func closeModule()
}

final class PhotoViewerRouter: PhotoViewerRouterProtocol {
	weak var navigator: UIViewController?
	
	func closeModule() {
		navigator?.navigationController?.popViewController(animated: true)
	}
}

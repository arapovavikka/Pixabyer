//
//  SearchModuleRouter.swift
//  Pixabyer
//


import Foundation
import UIKit

class SearchModuleRouter: Router {
	func createModule() -> UIViewController {
		let router = SearchRouter()
		let viewModel = SearchViewModel(router: router)
		let viewController = SearchViewController(viewModel: viewModel)
		router.navigator = viewController
		return viewController
	}
}

protocol SearchRouterProtocol: AnyObject {
	func routeToPhotoViewerScreen(for imageDetails: [PhotoViewModel])
}

class SearchRouter: SearchRouterProtocol {
	weak var navigator: UIViewController?
	
	func routeToPhotoViewerScreen(for imageDetails: [PhotoViewModel]) {
		let details = PhotoViewerModuleRouter(items: imageDetails)
		self.navigator?.navigationController?.pushViewController(details.createModule(), animated: true)
	}
}



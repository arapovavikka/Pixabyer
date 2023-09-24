//
//  PhotoViewerViewModel.swift
//  Pixabyer
//

import Foundation

final class PhotoViewerViewModel {
	let photos: [PhotoViewModel]
	private let router: PhotoViewerRouterProtocol
	
	init(photos: [PhotoViewModel], router: PhotoViewerRouterProtocol) {
		self.photos = photos
		self.router = router
	}
	
	func closeModule() {
		router.closeModule()
	}
}

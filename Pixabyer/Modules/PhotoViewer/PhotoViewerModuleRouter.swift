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
		return PhotoViewerViewController(viewModels: items, currentIndex: currentIndex)
	}
}

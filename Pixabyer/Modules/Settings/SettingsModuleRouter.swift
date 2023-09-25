//
//  SettingsModuleRouter.swift
//  Pixabyer
//

import Foundation
import UIKit

final class SettingsModuleRouter: Router {
	func createModule() -> UIViewController {
		return SettingsViewController(viewModel: SettingsViewModel())
	}
}

protocol SettingsRouterProtocol {
	func close()
}

final class SettingsRouter: SettingsRouterProtocol {
	weak var navigator: UIViewController?
	
	func close() {
		self.navigator?.navigationController?.dismiss(animated: true)
	}
}

//
//  SettingsViewController.swift
//  Pixabyer
//

import Foundation

final class SettingsViewController: BaseViewController {
	private let customView: SettingsView = SettingsView()
	private let viewModel: SettingsViewModel
	private let adapter: SettingsTableAdapter = SettingsTableAdapter()
	
	init(viewModel: SettingsViewModel) {
		self.viewModel = viewModel
		super.init(nibName: nil, bundle: nil)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func loadView() {
		adapter.connect(tableView: customView.tableView)
		adapter.update(with: viewModel.settings)
		self.view = customView
	}
}

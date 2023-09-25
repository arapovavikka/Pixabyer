//
//  SettingsTableAdapter.swift
//  Pixabyer
//

import Foundation
import UIKit

final class SettingsTableAdapter: NSObject, UITableViewDelegate, UITableViewDataSource {
	private var viewModels: [SettingItemModel] = []
	private var tableView: UITableView?
	
	func connect(tableView: UITableView) {
		self.tableView = tableView
		tableView.dataSource = self
		tableView.delegate = self
		register()
	}
	
	func disconnect() {
		tableView = nil
		viewModels = []
	}
	
	func update(with viewModels: [SettingItemModel]) {
		self.viewModels = viewModels
		tableView?.reloadData()
	}
	
	private func register() {
		guard let tableView else { return }
		tableView.register(SettingItemCell.self, forCellReuseIdentifier: SettingItemCell.identifier)
	}
	
	// MARK: UITableViewDataSource implementation
	
	func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return viewModels.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard
			indexPath.row < viewModels.count,
			let cell = tableView.dequeueReusableCell(withIdentifier: SettingItemCell.identifier) as? SettingItemCell else { return UITableViewCell() }
		cell.update(with: viewModels[indexPath.row])
		return cell
	}
	
	// MARK: UITableViewDelegate implementation
	
	func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
		guard indexPath.row < viewModels.count else { return }
		if let cell = cell as? SettingItemCell {
			cell.update(with: viewModels[indexPath.row])
		}
	}
}

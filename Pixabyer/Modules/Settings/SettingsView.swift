//
//  SettingsView.swift
//  Pixabyer
//

import Foundation
import SnapKit
import UIKit
import Combine

fileprivate extension Appearance { }

final class SettingsView: BaseView {
	let tableView: UITableView = UITableView(frame: .zero)
	
	override func addSubviews() {
		super.addSubviews()
		
		addSubview(tableView)
	}
	
	override func makeConstraints() {
		super.makeConstraints()
		tableView.snp.makeConstraints { make in
			make.edges.equalToSuperview()
		}
	}
	
	override func configure() {
		super.configure()
	}
}

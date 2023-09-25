//
//  BaseTableViewCell.swift
//  Pixabyer
//

import UIKit

class BaseTableViewCell: UITableViewCell {
	let appearance = Appearance()
	
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		addSubviews()
		makeConstraints()
		configure()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	open func addSubviews() { }
	open func makeConstraints() { }
	open func configure() { }
}

//
//  SettingItemCell.swift
//  Pixabyer
//

import UIKit

fileprivate extension Appearance {
	var verticalInset: CGFloat { 5 }
	var widthMultiplier: CGFloat { 0.5 }
}

class SettingItemCell: BaseTableViewCell {
	private let titleLabel = UILabel()
	private let textField = UITextField()
	
	override func addSubviews() {
		super.addSubviews()
		addSubview(titleLabel)
		addSubview(textField)
	}
	
	override func makeConstraints() {
		super.makeConstraints()
		titleLabel.snp.makeConstraints { make in
			make.left.equalToSuperview().offset(appearance.sidesInset)
			make.top.bottom.equalToSuperview().inset(appearance.verticalInset)
		}
		textField.snp.makeConstraints { make in
			make.right.equalToSuperview().inset(appearance.sidesInset)
			make.top.bottom.equalToSuperview().inset(appearance.verticalInset)
			make.width.equalToSuperview().multipliedBy(appearance.widthMultiplier)
		}
	}
	
	override func configure() {
		super.configure()
		textField.delegate = self
		textField.isUserInteractionEnabled = true
	}
	
	func update(with model: SettingItemModel) {
		titleLabel.text = model.title
		textField.text = model.value
	}
}

extension SettingItemCell: UITextFieldDelegate { }

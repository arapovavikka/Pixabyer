//
//  SettingItemCell.swift
//  Pixabyer
//

import UIKit
import Combine

fileprivate extension Appearance {
	var verticalInset: CGFloat { 5 }
	var widthMultiplier: CGFloat { 0.5 }
}

class SettingItemCell: BaseCombineTableViewCell {
	var textPublisher: AnyPublisher<String, Never> {
		textField
			.publisher(event: .editingDidEnd)
			.map { textField -> String in
				return textField.text ?? ""
			}
			.eraseToAnyPublisher()
	}
	
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
		titleLabel.text = model.type.rawValue
		textField.text = model.value
	}
}

// MARK: - UITextFieldDelegate

extension SettingItemCell: UITextFieldDelegate { }

// MARK: - UIResponder

extension SettingItemCell {
	override var isFirstResponder: Bool {
		textField.isFirstResponder
	}
	
	override var canBecomeFirstResponder: Bool {
		true
	}
	
	override func becomeFirstResponder() -> Bool {
		textField.becomeFirstResponder()
	}
	
	override func resignFirstResponder() -> Bool {
		textField.resignFirstResponder()
	}
}

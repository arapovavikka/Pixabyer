//
// PhotoErrorCollectionCell.swift
//

import Combine
import UIKit

fileprivate extension Appearance {
	var defaultText: String { "Попробуйте еще раз" }
}

final class PhotoErrorCollectionCell: BaseCombineCollectionViewCell {
	private lazy var errorLabel: UILabel = {
		let label = UILabel()
		label.text = appearance.defaultText
		return label
	}()

	override func addSubviews() {
		super.addSubviews()
		contentView.addSubview(errorLabel)
	}

	override func makeConstraints() {
		super.makeConstraints()
		errorLabel.snp.makeConstraints { make in
			make.leading.trailing.equalToSuperview()
			make.centerY.equalToSuperview()
		}
	}
}

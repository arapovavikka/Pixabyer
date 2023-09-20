//
//  BaseCollectionViewCell.swift
//  Pixabyer
//
//  Created by Vika on 07.09.2023.
//

import Foundation
import UIKit

class BaseCollectionViewCell: UICollectionViewCell {
	public let appearance = Appearance()

	public override init(frame: CGRect) {
		super.init(frame: frame)
		prepare()
	}

	public required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		prepare()
	}
	
	func addSubviews() { }
	
	func makeConstraints() { }
	
	func configure() { }
	
	func prepare() {
		addSubviews()
		makeConstraints()
		configure()
	}
}

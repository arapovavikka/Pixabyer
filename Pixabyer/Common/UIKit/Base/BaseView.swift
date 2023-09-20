//
//  BaseView.swift
//  Pixabyer
//
//  Created by Vika on 07.09.2023.
//

import Foundation
import UIKit

class BaseView: UIView {
	var appearance: Appearance { Appearance() }
	
	public override init(frame: CGRect) {
		super.init(frame: frame)
		prepare()
	}

	public required init?(coder: NSCoder) {
		super.init(coder: coder)
		prepare()
	}

	public init() {
		super.init(frame: .zero)
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

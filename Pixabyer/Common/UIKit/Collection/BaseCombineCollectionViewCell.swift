//
//  BaseCombineCollectionViewCell.swift
//  Pixabyer
//
//  Created by Vika on 07.09.2023.
//

import Foundation
import Combine

class BaseCombineCollectionViewCell: BaseCollectionViewCell {
	var bag: Set<AnyCancellable> = Set<AnyCancellable>()
	
	override func prepareForReuse() {
		super.prepareForReuse()
		bag.forEach{ $0.cancel() }
		bag.removeAll()
	}
}

extension AnyCancellable {
	func store(in cell: BaseCombineCollectionViewCell) {
		store(in: &cell.bag)
	}
}

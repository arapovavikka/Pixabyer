//
//  BaseCombineTableViewCell.swift
//  Pixabyer
//

import Combine

class BaseCombineTableViewCell: BaseTableViewCell {
	var bag: Set<AnyCancellable> = Set<AnyCancellable>()
	
	override func prepareForReuse() {
		super.prepareForReuse()
		bag.forEach { $0.cancel() }
		bag.removeAll()
	}
}

extension AnyCancellable {
	func store(in cell: BaseCombineTableViewCell) {
		self.store(in: &cell.bag)
	}
}

//
//  Operators.swift
//  Pixabyer
//

import Foundation

extension Collection {
	subscript(safe index: Index) -> Element? {
		((self.startIndex...self.endIndex) ~= index) ? self[index] : nil
	}
}

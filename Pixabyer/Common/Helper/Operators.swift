//
//  Operators.swift
//  Pixabyer
//
//  Created by Vika on 07.09.2023.
//

import Foundation

extension Collection {
	subscript(safe index: Index) -> Element? {
		((self.startIndex...self.endIndex) ~= index) ? self[index] : nil
	}
}

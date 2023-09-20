//
// WAPortal
// PhotoViewModel.swift
//

import Foundation

struct PhotoViewModel {
	let id: Int
	let url: URL
	var error: Error?

	init(id: Int, url: URL) {
		self.id = id
		self.url = url
		self.error = nil
	}
}

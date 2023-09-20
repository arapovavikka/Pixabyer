//
//  NetworkError+Error.swift
//  Pixabyer
//

import Foundation

enum NetworkError: Error, Equatable {
	case apiKeyLimit
	case notFound
	case unexpected(message: String)
}

//
//  PhotoProvider.swift
//  Pixabyer
//
//  Created by Vika on 09.09.2023.
//

import Foundation
import Combine

protocol PhotoProviderProtocol: AnyObject {
	func getSearchResults(with keyWords: String) async throws -> PixabySearchResponse
}

final class PhotoProvider: NSObject, PhotoProviderProtocol {
	private let networkProvider: NetworkProtocol
	private let apiKey: String = "39343343-a893a4b0a5b2681ccf6be4ceb"
	
	private lazy var searchURL: ((String) -> URL?) = { [weak self] keyWords in
		guard let self else { return nil }
		
		var components = URLComponents()
		components.scheme = "https"
		components.host = "pixabay.com"
		components.path = "/api"
		components.queryItems = [
			URLQueryItem(name: "key", value: self.apiKey),
			URLQueryItem(name: "q", value: keyWords)
		]
		return components.url
	}
	
	init(networkProvider: NetworkProtocol = DIContainer.shared.resolve(NetworkProtocol.self)!) {
		self.networkProvider = networkProvider
	}
	
	func getSearchResults(with keyWords: String) async throws -> PixabySearchResponse {
		let request = URLRequest(url: searchURL(keyWords)!)
		return try await networkProvider.throwableRequest(request, type: PixabySearchResponse.self)
	}
}

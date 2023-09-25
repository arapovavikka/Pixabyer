//
//  PhotoProvider.swift
//  Pixabyer
//

import Foundation
import Combine

protocol PhotoProviderProtocol: AnyObject {
	func getSearchResults(with keyWords: String) async throws -> PixabySearchResponse
}

final class PhotoProvider: NSObject, PhotoProviderProtocol {
	private let networkProvider: NetworkProtocol
	private let settingsProvider: SettingsProviderProtocol
	
	private lazy var searchURL: ((String) -> URL?) = { [weak self] keyWords in
		guard let self else { return nil }
		
		var components = URLComponents()
		components.scheme = "https"
		components.host = "pixabay.com"
		components.path = "/api"
		components.queryItems = [
			URLQueryItem(name: "key", value: self.settingsProvider.apiKey),
			URLQueryItem(name: "q", value: keyWords)
		]
		return components.url
	}
	
	init(
		networkProvider: NetworkProtocol = DIContainer.shared.resolve(NetworkProtocol.self)!,
		settingsProvider: SettingsProviderProtocol = DIContainer.shared.resolve(SettingsProviderProtocol.self)!
	) {
		self.networkProvider = networkProvider
		self.settingsProvider = settingsProvider
	}
	
	func getSearchResults(with keyWords: String) async throws -> PixabySearchResponse {
		let request = URLRequest(url: searchURL(keyWords)!)
		return try await networkProvider.throwableRequest(request, type: PixabySearchResponse.self)
	}
}

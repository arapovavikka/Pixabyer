//
//  Network.swift
//  Pixabyer
//

import Foundation

protocol NetworkProtocol: AnyObject {
	func throwableRequest<Response: Codable>(_ request: URLRequest, type: Response.Type) async throws -> Response
	func request<Response: Codable>(_ request: URLRequest, type: Response.Type) async -> Result<Response, NetworkError>
}

final class Network: NetworkProtocol {
	func throwableRequest<Response: Codable>(_ request: URLRequest, type: Response.Type) async throws -> Response {
		let response = await self.request(request, type: type)
		switch response {
		case .success(let result):
			return result
		case .failure(let error):
			throw error
		}
	}
	
	func request<Response: Codable>(_ request: URLRequest, type: Response.Type) async -> Result<Response, NetworkError> {
		do {
			let (data, response) = try await URLSession.shared.data(for: request)
			guard let response = response as? HTTPURLResponse else {
				return .failure(NetworkError.unexpected(message: "Couldn't get HTTPURLResponse"))
			}
			try validateStatusCode(code: response.statusCode)
			
			let model = try JSONDecoder().decode(type, from: data)
			return .success(model)
		}
		catch let error as NetworkError {
			return .failure(error)
		}
		catch {
			return .failure(NetworkError.unexpected(message: error.localizedDescription))
		}
	}
	
	private func validateStatusCode(code: Int) throws {
		switch code {
		case 200...299:
			return
		case 429:
			throw NetworkError.apiKeyLimit
		case 404:
			throw NetworkError.notFound
		default:
			throw NetworkError.unexpected(message: String(code))
		}
	}
}

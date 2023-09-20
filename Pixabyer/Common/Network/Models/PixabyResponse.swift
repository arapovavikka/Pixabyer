//
//  PixabyResponse.swift
//  Pixabyer
//

struct PixabyImageResponse: Codable {
	let id: Int
	let previewURL: String
	let largeImageURL: String
}

struct PixabySearchResponse: Codable {
	let total: Int
	let images: [PixabyImageResponse]
	
	enum CodingKeys: String, CodingKey {
		case total
		case images = "hits"
	}
}


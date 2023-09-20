//
//  SearchViewModel.swift
//  Pixabyer
//

import Foundation
import Combine

final class SearchViewModel {
	var searchText: String = ""

	var error: AnyPublisher<Error, Never> { errorPassthrough.eraseToAnyPublisher() }
	var images: AnyPublisher<[PhotoViewModel], Never> { imagesPassthrough.eraseToAnyPublisher() }
	
	var router: SearchRouterProtocol?
	
	private var cancellable: Set<AnyCancellable> = []
	private let provider: PhotoProviderProtocol
	
	private var errorPassthrough = PassthroughSubject<Error, Never>()
	private var imagesPassthrough = PassthroughSubject<[PhotoViewModel], Never>()
	
	init(provider: PhotoProviderProtocol = DIContainer.shared.resolve(PhotoProviderProtocol.self)!) {
		self.provider = provider
	}
	
	func makeSearch(with text: String) {
		self.searchText = text
		Task {
			do {
				let result = try await provider.getSearchResults(with: searchText)
				
				imagesPassthrough.send(result.images.compactMap({ image in
					guard let url = URL(string: image.largeImageURL) else {
						return nil
					}
					return PhotoViewModel(id: image.id, url: url)
				}))
			}
			catch {
				errorPassthrough.send(error)
			}
		}
	}
	
	func routeToDetails(images: [PhotoViewModel]) {
		guard !images.isEmpty else {
			errorPassthrough.send(ImagesError.emptyResult)
			return
		}
		self.router?.routeToPhotoViewerScreen(for: images)
	}
}

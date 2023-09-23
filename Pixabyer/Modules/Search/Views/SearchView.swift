//
//  SearchView.swift
//  Pixabyer
//

import Foundation
import UIKit
import SnapKit
import Combine

fileprivate extension Appearance {
	var imageSidesInset: Int { 120 }
	var aspectRatio: Int { 1 }
	
	var searchHeight: Int { 50 }
	var searchSidesInset: Int { 10 }
	
	var searchPlaceholder: String { "Поиск изображений" }
	
	var searchEmptyError: String { "Не нашлось подходящих изображений, поменяйте запрос" }
	var searchDefaultError: String { "Что-то пошло не так, проверьте интернет соединение" }
	var searchApiLimitError: String { "Api key истек, обновите ключ" }
}

final class SearchView: BaseView {
	var searchPressed: AnyPublisher<String, Never> {
		searchPressedPassthrough
			.debounce(for: .milliseconds(500), scheduler: DispatchQueue.main)
			.eraseToAnyPublisher()
	}
	
	private let searchPressedPassthrough: PassthroughSubject<String, Never> = PassthroughSubject<String, Never>()
	
	private let logoImageView: UIImageView = UIImageView(image: UIImage(named: "pixaby"))
	private let searchBar: UISearchBar = UISearchBar()
	
	
	private let infoStackView: UIStackView = UIStackView()
	private let errorLabel: UILabel = UILabel()
	private let activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
	
	override init() {
		super.init()
		searchBar.delegate = self
	}
	
	public required init?(coder: NSCoder) {
		super.init(coder: coder)
	}
	
	override func addSubviews() {
		super.addSubviews()
		addSubview(searchBar)
		addSubview(logoImageView)
		addSubview(infoStackView)
		
		infoStackView.addArrangedSubview(activityIndicator)
		infoStackView.addArrangedSubview(errorLabel)
	}
	
	override func makeConstraints() {
		super.makeConstraints()
		logoImageView.snp.makeConstraints { make in
			make.top.equalTo(safeAreaLayoutGuide.snp.topMargin)
			make.left.right.equalToSuperview().inset(appearance.imageSidesInset)
			make.height.equalTo(logoImageView.snp.width).multipliedBy(appearance.aspectRatio)
		}
		
		searchBar.snp.makeConstraints { make in
			make.top.equalTo(logoImageView.snp.bottom)
			make.leading.trailing.equalToSuperview().inset(appearance.searchSidesInset)
			make.height.equalTo(appearance.searchHeight)
		}
		
		infoStackView.snp.makeConstraints { make in
			make.top.equalTo(searchBar.snp.bottom).offset(appearance.sidesInset)
			make.left.right.equalToSuperview().inset(appearance.searchSidesInset)
			make.centerX.equalToSuperview()
		}
	}
	
	override func configure() {
		super.configure()
		self.backgroundColor = UIColor.white
		searchBar.searchBarStyle = .minimal
		searchBar.placeholder = appearance.searchPlaceholder
		
		infoStackView.axis = .vertical
		infoStackView.spacing = 0
		errorLabel.numberOfLines = 0
		errorLabel.textAlignment = .center
		errorLabel.setContentCompressionResistancePriority(.required, for: .vertical)
	}
	
	func processing(isActive: Bool) {
		if isActive {
			errorLabel.isHidden = true
			self.activityIndicator.startAnimating()
		}
		else {
			self.activityIndicator.stopAnimating()
		}
	}
	
	func update(with error: Error) {
		errorLabel.isHidden = false
		
		let text: String
		switch error {
		case is ImagesError:
			text = appearance.searchEmptyError
		case let network as NetworkError where network == NetworkError.apiKeyLimit:
			text = appearance.searchApiLimitError
		default:
			text = appearance.searchDefaultError
		}
		errorLabel.text = text
	}
}

extension SearchView: UISearchBarDelegate {
	func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
		guard let searchText = searchBar.text else { return }
		searchPressedPassthrough.send(searchText)
	}
	
	func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
		if searchText.isEmpty {
			errorLabel.isHidden = true
		}
	}
}

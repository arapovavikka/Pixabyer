//
//  SearchViewController.swift
//  Pixabyer
//


import Foundation
import UIKit
import Combine

final class SearchViewController: BaseViewController {
	private let viewModel: SearchViewModel
	private let customView: SearchView = SearchView()
	
	init(viewModel: SearchViewModel) {
		self.viewModel = viewModel
		super.init(nibName: nil, bundle: nil)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func loadView() {
		super.loadView()
		self.view = customView
		bind()
	}
	
	private func bind() {
		bindingView()
		bindingViewModel()
	}
	
	private func bindingView() {
		customView.searchPressed.sink { [weak self] text in
			guard let self else { return }
			self.customView.processing(isActive: true)
			self.viewModel.makeSearch(with: text)
		}
		.store(in: &bag)
	}
	
	private func bindingViewModel() {
		viewModel.images.receive(on: DispatchQueue.main).sink { [weak self] images in
			guard let self else { return }
			
			self.customView.processing(isActive: false)
			self.viewModel.routeToDetails(images: images)
		}
		.store(in: &bag)
		
		viewModel.error.receive(on: DispatchQueue.main).sink { [weak self] error in
			guard let self else { return }
			
			self.customView.processing(isActive: false)
			self.customView.update(with: error)
		}.store(in: &bag)
	}
}

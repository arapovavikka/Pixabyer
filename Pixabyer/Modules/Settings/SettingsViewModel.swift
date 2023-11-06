//
//  SettingsViewModel.swift
//  Pixabyer
//

import Foundation

enum SettingsMode: String, CaseIterable {
	case apiKey
	
	var array: [SettingsMode] { SettingsMode.allCases }
	
	var index: Int? { array.firstIndex(of: self) ?? .none }
}

final class SettingsViewModel {
	private let settingsProvider: SettingsProviderProtocol
	
	lazy var settings: [SettingItemModel] = [
		SettingItemModel(type: SettingsMode.apiKey, value: settingsProvider.apiKey, isEditable: true)
	]
	
	init(settingsProvider: SettingsProviderProtocol = DIContainer.shared.resolve(SettingsProviderProtocol.self)!) {
		self.settingsProvider = settingsProvider
	}
}

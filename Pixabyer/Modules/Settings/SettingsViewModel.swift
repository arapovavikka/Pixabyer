//
//  SettingsViewModel.swift
//  Pixabyer
//

import Foundation

final class SettingsViewModel {
	private let settingsProvider: SettingsProviderProtocol
	
	lazy var settings: [SettingItemModel] = [
		SettingItemModel(title: "API key", value: settingsProvider.apiKey, isEditable: true)
	]
	
	
	init(settingsProvider: SettingsProviderProtocol = DIContainer.shared.resolve(SettingsProviderProtocol.self)!) {
		self.settingsProvider = settingsProvider
	}
}

//
//  SettingsProvider.swift
//  Pixabyer
//


import Foundation

protocol SettingsProviderProtocol {
	var apiKey: String { get }
}

final class SettingsProvider: SettingsProviderProtocol {
	var apiKey: String {
		return Bundle.main.infoDictionary?["API_KEY"] as? String ?? "" 
	}
}

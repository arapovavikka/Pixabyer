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
		"39343343-a893a4b0a5b2681ccf6be4ceb"
	}
}

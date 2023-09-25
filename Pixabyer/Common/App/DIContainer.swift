//
//  DIContainer.swift
//  Pixabyer
//

import Swinject

public class DIContainer {
	public static var shared = Container()
}

extension Container {
	func registerAll() {
		DIContainer.shared.register(NetworkProtocol.self) { _ in
			Network()
		}.inObjectScope(.container)
		
		DIContainer.shared.register(PhotoProviderProtocol.self, factory: { _ in
			PhotoProvider()
		}).inObjectScope(.container)
		
		DIContainer.shared.register(SettingsProviderProtocol.self) { _ in
			SettingsProvider()
		}.inObjectScope(.container)
	}
}

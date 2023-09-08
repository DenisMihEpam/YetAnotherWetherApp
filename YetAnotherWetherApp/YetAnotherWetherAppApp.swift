//
//  YetAnotherWetherAppApp.swift
//  YetAnotherWetherApp
//
//  Created by denis mikhaylovsky on 06.09.2023.
//

import SwiftUI

@main
struct YetAnotherWetherAppApp: App {
   
    let appCoordinator = AppCoordinator(
        persistenceManager: PersistenceManager(),
        wetherCoordinator: WetherCoordinator(networkManager: NetworkManager()),
        locationCoordinator: LocationCoordinator()
    )
    var body: some Scene {
        WindowGroup {
            appCoordinator.makeInitialScreen()
        }
    }
}

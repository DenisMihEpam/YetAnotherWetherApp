
import Foundation

final class DependencyContainer {
    let persistenceManager: Persistence
    let wetherCoordinator: WetherCoordinating
    let locationCoordinator: LocationCoordinating
    let searchCoordinator: SearchCoordinating
    let networkManager: Networking
    
    init(
        persistenceManager: Persistence,
        wetherCoordinator: WetherCoordinating,
        locationCoordinator: LocationCoordinating,
        searchCoordinator: SearchCoordinating,
        networkManager: Networking
    ) {
        self.persistenceManager = persistenceManager
        self.wetherCoordinator = wetherCoordinator
        self.locationCoordinator = locationCoordinator
        self.searchCoordinator = searchCoordinator
        self.networkManager = networkManager
    }
}

extension DependencyContainer {
    static var shared: DependencyContainer {
        let networkManager = NetworkManager()
        return DependencyContainer(
            persistenceManager: PersistenceManager(),
            wetherCoordinator: WetherCoordinator(networkManager: networkManager),
            locationCoordinator: LocationCoordinator(),
            searchCoordinator: SearchCoordinator(networkManager: networkManager),
            networkManager: networkManager
        )
    }
}

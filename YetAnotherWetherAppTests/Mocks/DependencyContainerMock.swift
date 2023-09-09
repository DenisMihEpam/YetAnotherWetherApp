import Foundation
@testable import YetAnotherWetherApp

extension DependencyContainer {
   static var mock: DependencyContainer {
        DependencyContainer(
            persistenceManager: PersistenceManagerMock(),
            wetherCoordinator: WetherCoordinatorMock(),
            locationCoordinator: LocationCoordinatorMock(),
            searchCoordinator: SearchCoordinatorMock(),
            networkManager: NetworkManagerMock()
        )
    }
}

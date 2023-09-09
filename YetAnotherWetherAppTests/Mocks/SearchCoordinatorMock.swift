import Foundation
@testable import YetAnotherWetherApp

final class SearchCoordinatorMock: SearchCoordinating {
    func searchCiti(searchText: String) async throws -> [YetAnotherWetherApp.Place] {
        [Place.mock]
    }
    
    
}

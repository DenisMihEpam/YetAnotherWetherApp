import Foundation
@testable import YetAnotherWetherApp

final class NetworkManagerMock: Networking {
    func getCurrentWeather(latitude: Double, longitude: Double) async throws -> YetAnotherWetherApp.WetherResponse {
        return WetherResponse.mock
    }
    
    func searchCity(searchText: String) async throws -> [YetAnotherWetherApp.Place] {
        return [.mock]
    }
    
}

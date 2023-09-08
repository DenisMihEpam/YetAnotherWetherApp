import Foundation
import CoreLocation

final class WetherCoordinator {
    let networkManager: Networking
    
    init(networkManager: Networking) {
        self.networkManager = networkManager
    }
    
    func getCurrentWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees) async throws -> WetherResponse {
        return try await networkManager.getCurrentWeather(latitude: latitude, longitude: longitude)
    }
}


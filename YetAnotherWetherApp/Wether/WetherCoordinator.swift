import Foundation
import CoreLocation

protocol WetherCoordinating {
    func getCurrentWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees) async throws -> WetherResponse
}

final class WetherCoordinator: WetherCoordinating {
    let networkManager: Networking
    
    init(networkManager: Networking) {
        self.networkManager = networkManager
    }
    
    func getCurrentWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees) async throws -> WetherResponse {
        guard let url = Endpoints.wether(lat: latitude, lon: longitude).url else { fatalError() }
        do {
            let response: WetherResponse = try await networkManager.performRequest(url: url)
            return response
        } catch {
            throw error
        }
    }
}



import Foundation
import CoreLocation
@testable import YetAnotherWetherApp

final class WetherCoordinatorMock: WetherCoordinating {
    var isWetherRequested = false
    
    func getCurrentWeather(
        latitude: CLLocationDegrees,
        longitude: CLLocationDegrees
    ) async throws -> YetAnotherWetherApp.WetherResponse {
        isWetherRequested = true
        return WetherResponse.mock
    }
}

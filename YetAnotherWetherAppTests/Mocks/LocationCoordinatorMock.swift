import Foundation
import CoreLocation
@testable import YetAnotherWetherApp


final class LocationCoordinatorMock: LocationCoordinating {
    var autorizationRequested = false
    var stopped = false
    
    func requestAutorization() async throws {
        autorizationRequested = true
    }
    
    func getCurrentLocation() async throws -> AsyncStream<CLLocation> {
        let stream = AsyncStream(unfolding: {
            return CLLocation.mock
        })
        return stream
    }
    
    func stop() {
        stopped = true
    }
    
}

extension CLLocation {
    static var mock: CLLocation {
        CLLocation(latitude: 100, longitude: 100)
    }
}

import Foundation
import CoreLocation
import Locations

protocol LocationCoordinating {
    func requestAutorization() async throws
    func getCurrentLocation() async throws -> AsyncStream<CLLocation>
    func stop()
}

final class LocationCoordinator: LocationCoordinating {
    let locater: Locater
    
    init() {
        locater = Locater(accuracy: .oneKilometre)
    }
    
    func requestAutorization() async throws {
        do {
            guard !locater.isAuthorizedToLocate else { return }
            try await locater.requestWhenInUseAuthorization()
            if !locater.isAuthorizedToLocate {
                throw AppError.locationManagerUnauthorized
            }
        } catch {
            throw AppError.locationManagerUnauthorized
        }
    }
    
    func getCurrentLocation() async throws -> AsyncStream<CLLocation> {
        do {
            return try locater.subscribe()
        } catch {
            throw AppError.locationError
        }
    }
    
    func stop() {
        locater.unsubscribe()
    }
}

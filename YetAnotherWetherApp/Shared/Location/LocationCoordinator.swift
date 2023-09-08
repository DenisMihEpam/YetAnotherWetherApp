import Foundation
import CoreLocation
import Locations

final class LocationCoordinator {
    let locater: Locater
    var status: AuthorizationStatus
    var currentLocationStream: AsyncStream<CLLocation>?
    
    init() {
        locater = Locater(accuracy: .oneKilometre)
        status = .undetermined
        
    }
    func requestAutorization() async throws -> AuthorizationStatus {
        do {
            let status: AuthorizationStatus = try await locater.requestAlwaysAuthorization()
            switch status {
                case .authorized(_):
                    self.status = status
                    return status
                default:
                    throw AppError.locationManagerUnauthorized
            }
        } catch {
            throw AppError.locationManagerUnauthorized
        }
    }
    
    func getCurrentLocation() async throws -> AsyncStream<CLLocation> {
        do {
            let stream: AsyncStream<CLLocation> = try locater.subscribe()
            currentLocationStream = stream
            return stream
        } catch {
            throw AppError.locationError
        }
    }
    
}

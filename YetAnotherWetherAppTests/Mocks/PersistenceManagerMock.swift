import Foundation
import CoreLocation
@testable import YetAnotherWetherApp

final class PersistenceManagerMock: Persistence {
    var isSaved = false
    var isCoordinateRequested = false
    
    func save(coordinate: CLLocationCoordinate2D) {
        isSaved = true
    }
    
    func getCoordinate() -> CLLocationCoordinate2D? {
        isCoordinateRequested = true
       return  CLLocationCoordinate2D(latitude: 100, longitude: 100)
    }    
}

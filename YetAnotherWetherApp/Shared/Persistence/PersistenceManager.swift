import Foundation
import CoreLocation

protocol Persistence {
    func save(coordinate: CLLocationCoordinate2D)
    func getCoordinate() -> CLLocationCoordinate2D?
}

final class PersistenceManager: Persistence {
    
    func save(coordinate: CLLocationCoordinate2D) {
        UserDefaults.standard.setValue(coordinate.latitude, forKey: Constants.storedLocationLatKey)
        UserDefaults.standard.setValue(coordinate.longitude, forKey: Constants.storedLocationLonKey)
    }
    
    func getCoordinate() -> CLLocationCoordinate2D? {
        let lat = UserDefaults.standard.double(forKey: Constants.storedLocationLatKey)
        let lon = UserDefaults.standard.double(forKey: Constants.storedLocationLonKey)
        if lat != 0, lon != 0 {
            return CLLocationCoordinate2D(latitude: lat, longitude: lon)
        }
        return nil
    }
}

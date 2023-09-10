import Foundation

final class Constants {
    static let storedLocationLatKey = "storedLocationLat"
    static let storedLocationLonKey = "storedLocationLon"
    static let apiKey = "Your API KEY Here"
}

enum Endpoints {
    case wether(lat: Double, lon: Double)
    case search(String)
    
    var url: URL? {
        switch self {
            case .wether(lat: let lat, lon: let lon):
                return URL(string: "https://api.openweathermap.org/data/2.5/weather?lat=\(lat)&lon=\(lon)&appid=\(Constants.apiKey)&units=metric")
            case .search(let searchText):
               return URL(string: "https://api.openweathermap.org/geo/1.0/direct?q=\(searchText)&limit=5&appid=\(Constants.apiKey)")
        }
    }
}

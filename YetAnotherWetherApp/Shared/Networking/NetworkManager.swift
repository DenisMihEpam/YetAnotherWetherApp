import Foundation

protocol Networking {
    func getCurrentWeather(latitude: Double, longitude: Double) async throws -> WetherResponse
    func searchCity(searchText: String) async throws -> [Place]
}

final class NetworkManager: Networking {
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
    
    func getCurrentWeather(latitude: Double, longitude: Double) async throws -> WetherResponse {
        guard let url = Endpoints.wether(lat: latitude, lon: longitude).url else {
            throw AppError.invalidResponse
        }
        
        let urlRequest = URLRequest(url: url)
        
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            throw AppError.invalidResponse
        }
        do {
            return try JSONDecoder().decode(WetherResponse.self, from: data)
        } catch {
            throw AppError.invalidData
        }
    }
    
    func searchCity(searchText: String) async throws -> [Place] {
        guard let url = Endpoints.search(searchText).url else {
            throw AppError.invalidResponse
        }
        
        let urlRequest = URLRequest(url: url)
        
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            throw AppError.invalidResponse
        }
        do {
            return try JSONDecoder().decode([Place].self, from: data)
        } catch {
            throw AppError.invalidData
        }
    }
    
}

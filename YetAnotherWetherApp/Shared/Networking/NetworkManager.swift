import Foundation

protocol Networking {
    func performRequest<T: Decodable>(url: URL) async throws -> T
}

final class NetworkManager: Networking {
    
    func performRequest<T: Decodable>(url: URL) async throws -> T {
        let urlRequest = URLRequest(url: url)
        
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            throw AppError.invalidResponse
        }
        do {
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            throw AppError.invalidData
        }
    }
}

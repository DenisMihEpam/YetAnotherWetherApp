import Foundation
import SwiftUI

protocol SearchCoordinating {
    func searchCiti(searchText: String) async throws -> [Place]
}

final class SearchCoordinator: SearchCoordinating {
    let networkManager: Networking
    
    init(networkManager: Networking) {
        self.networkManager = networkManager
    }
    
    func searchCiti(searchText: String) async throws -> [Place] {
        guard let url = Endpoints.search(searchText).url else { return [] }
        do {
            let places: [Place] = try await networkManager.performRequest(url: url)
            return places
        } catch {
            throw error
        }
    }
    
}

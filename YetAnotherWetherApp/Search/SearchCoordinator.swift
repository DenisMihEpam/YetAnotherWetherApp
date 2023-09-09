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
        return try await networkManager.searchCity(searchText: searchText.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? "")
    }
    
}

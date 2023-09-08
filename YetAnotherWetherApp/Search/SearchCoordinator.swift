import Foundation
import SwiftUI

final class SearchCoordinator: ObservableObject {
let networkManager: Networking
    
    init(networkManager: Networking) {
        self.networkManager = networkManager
    }
    
    func searchCiti(searchText: String) async throws -> [Place] {
        return try await networkManager.searchCity(searchText: searchText.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? "")
    }
    
}

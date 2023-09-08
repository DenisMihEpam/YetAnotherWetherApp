import Foundation
import SwiftUI
import Combine

final class SearchViewModel: ObservableObject {
    @Published var searchText: String = ""
    var selectedPlace: Place?
    @Published var places: [Place] = []
    let searchHandler: (Place) -> Void
    private var cancellable = Set<AnyCancellable>()
    let coordinator: SearchCoordinator
    var errorMessage: String?
    
    init( searchHandler: @escaping (Place) -> Void) {
        self.searchHandler = searchHandler
        coordinator = SearchCoordinator(networkManager: NetworkManager())
        self.$searchText
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .sink { text in

                Task {@MainActor [weak self] in
                    guard let self else { return }
                    do {
                        let places = try  await self.coordinator.searchCiti(searchText: self.searchText)
                        self.places = places
                    } catch {
                        if let appError = error as? AppError {
                            errorMessage = appError.errorMessage
                        }
                    }
                }
            }
            .store(in: &cancellable)
    }
}

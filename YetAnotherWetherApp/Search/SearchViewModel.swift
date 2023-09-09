import Foundation
import SwiftUI
import Combine

final class SearchViewModel: ObservableObject {
    @Published var searchText: String = ""
    @Published var selectedPlace: Place?
    @Published var places: [Place] = []
    let searchHandler: (Place) -> Void
    private var cancellable = Set<AnyCancellable>()
    let coordinator: SearchCoordinating
    var errorMessage: String?
    
    init(coordinator: SearchCoordinating, searchHandler: @escaping (Place) -> Void) {
        self.coordinator = coordinator
        self.searchHandler = searchHandler
        self.$searchText
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .sink { text in
                Task {@MainActor [weak self] in
                    guard let self else { return }
                    do {
                        let places = try  await self.coordinator.searchCiti(searchText: self.searchText)
                        self.places = [Place.currentLocation] + places
                    } catch {
                        if let appError = error as? AppError {
                            errorMessage = appError.errorMessage
                        }
                    }
                }
            }
            .store(in: &cancellable)
        
        self.$selectedPlace
            .sink { place in
                if let place {
                    searchHandler(place)
                }
            }
            .store(in: &cancellable)
    }
}

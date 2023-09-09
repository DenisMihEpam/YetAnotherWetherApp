import Foundation

extension SearchViewModel {
    static var mock: SearchViewModel {
        SearchViewModel(coordinator: SearchCoordinator(networkManager: NetworkManager()), searchHandler: {_ in })
    }
}

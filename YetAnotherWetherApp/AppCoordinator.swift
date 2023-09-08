import Foundation
import SwiftUI
import CoreLocation

enum AppError: Error {
    case invalidResponse
    case invalidData
    case locationManagerUnauthorized
    case locationError
    
    var errorMessage: String {
        switch self {
            case .invalidResponse:
                return "Network error. Please check your connection"
            case .invalidData:
                return "Network error. Looks like API has been updated"
            case .locationManagerUnauthorized:
                return "Location error. Please give app permission to receive your current location"
            case .locationError:
                return "Location error. Something goes wrong"
        }
    }
}


final class AppCoordinator {
    var wetherViewModel: WetherViewModel?
    let persistenceManager: PersistenceManager
    let wetherCoordinator: WetherCoordinator
    let locationCoordinator: LocationCoordinator
    var specificLocationSelected: Bool = false
    
    init(
        wetherViewModel: WetherViewModel? = nil,
        persistenceManager: PersistenceManager,
        wetherCoordinator: WetherCoordinator,
        locationCoordinator: LocationCoordinator
    ) {
        self.wetherViewModel = wetherViewModel
        self.persistenceManager = persistenceManager
        self.wetherCoordinator = wetherCoordinator
        self.locationCoordinator = locationCoordinator
    }
    
    @MainActor func makeInitialScreen() -> some View{
        
        let viewModel = WetherViewModel(state: .loading, searchViewHandler: searchViewHandler)
        wetherViewModel = viewModel
        Task {
            await checkInitialState()
        }
        return ContentView(viewModel: viewModel)
    }
    
    func checkInitialState() async {
        if let storedLocation = persistenceManager.getCoordinate() {
            Task{ @MainActor in
                wetherViewModel?.state = await requestWether(for: storedLocation)
            }
        } else {
            await startUpdatingLocations()
        }
    }
    
    func requestWether(for coordinates: CLLocationCoordinate2D) async -> WetherViewState{
        do {
            let wetherResponse = try await wetherCoordinator.getCurrentWeather(latitude: coordinates.latitude, longitude: coordinates.longitude)
            return .results(wetherResponse)
        } catch {
            if let networkError = error as? AppError {
                return .error(networkError)
            }
        }
        return .loading
    }
    
    func startUpdatingLocations() async {
        do {
            let _ = try await locationCoordinator.requestAutorization()
            let stream = try await locationCoordinator.getCurrentLocation()
            for await data in stream {
                if !specificLocationSelected {
                    Task{ @MainActor in
                        wetherViewModel?.state = await requestWether(for: data.coordinate)
                    }
                    persistenceManager.save(coordinate: data.coordinate)
                }
            }
        } catch {
            if let locationError = error as? AppError {
                handleLocationError(locationError)
            }
        }
    }
    
    func handleLocationError(_ error: AppError) {
        if !specificLocationSelected {
            Task{ @MainActor in
                wetherViewModel?.state = .error(error)
            }
        }
    }
    
    func searchViewHandler(_ place: Place) {
        print("handler")
    }
}

import Foundation
import SwiftUI
import CoreLocation

final class AppCoordinator {
    var wetherViewModel: WetherViewModel?
    var persistenceManager: Persistence
    var wetherCoordinator: WetherCoordinating
    var locationCoordinator: LocationCoordinating
    var searchCoordinator: SearchCoordinating
    var networkManager: Networking
    var lastLocation = CLLocation(latitude: 0, longitude: 0)
    let minDistance = 500.0
    
    init(dependencyContainer: DependencyContainer) {
        self.networkManager = dependencyContainer.networkManager
        self.persistenceManager = dependencyContainer.persistenceManager
        self.wetherCoordinator = dependencyContainer.wetherCoordinator
        self.locationCoordinator = dependencyContainer.locationCoordinator
        self.searchCoordinator = dependencyContainer.searchCoordinator
    }
    
    @MainActor func makeInitialScreen() -> some View{
        
        let wetherViewModel = WetherViewModel(state: .loading)
        self.wetherViewModel = wetherViewModel
        let searchViewModel = SearchViewModel(coordinator: searchCoordinator, searchHandler: searchViewHandler(_:))
        Task {
            await checkInitialState()
        }
        let contentView =  ContentView(viewModel: wetherViewModel)
                            .environmentObject(searchViewModel)
        return contentView
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
            try await locationCoordinator.requestAutorization()
            let stream = try await locationCoordinator.getCurrentLocation()
            
            for await location in stream {
                if lastLocation.distance(from: location) > minDistance {
                    lastLocation = location
                    Task{ @MainActor in
                        wetherViewModel?.state = await requestWether(for: location.coordinate)
                    }
                    persistenceManager.save(coordinate: location.coordinate)
                }
            }
        } catch {
            if let locationError = error as? AppError {
                Task{ @MainActor in
                    wetherViewModel?.state = .error(locationError)
                }
            }
        }
    }
  
    func searchViewHandler(_ place: Place) {
        Task { @MainActor in
            if place.id == Place.currentLocation.id {
                await startUpdatingLocations()
            } else {
                locationCoordinator.stop()
                wetherViewModel?.state = await requestWether(for: CLLocationCoordinate2D(latitude: place.lat, longitude: place.lon))
            }
        }
    }
}

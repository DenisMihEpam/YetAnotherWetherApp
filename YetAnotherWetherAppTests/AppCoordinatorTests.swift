import XCTest
import CoreLocation
@testable import YetAnotherWetherApp

final class YetAnotherWetherAppTests: XCTestCase {

    var sut: AppCoordinator?
    
    override func setUpWithError() throws {
        sut = AppCoordinator(dependencyContainer: DependencyContainer.mock)
    }

    override func tearDownWithError() throws {
        sut = nil
    }

    func testMakeInitialScreen() throws {
        Task { @MainActor in
            let view = sut?.makeInitialScreen()
            XCTAssertNotNil(view)
            XCTAssertNotNil(sut?.wetherViewModel)
            XCTAssertTrue((sut?.persistenceManager as? PersistenceManagerMock)?.isCoordinateRequested == true)
            XCTAssertTrue((sut?.wetherCoordinator as? WetherCoordinatorMock)?.isWetherRequested == true)
        }
    }
    
    func testCheckInitialState() throws {
        Task {
            await sut?.checkInitialState()
            XCTAssertTrue((sut?.persistenceManager as? PersistenceManagerMock)?.isCoordinateRequested == true)
            XCTAssertTrue((sut?.wetherCoordinator as? WetherCoordinatorMock)?.isWetherRequested == true)
        }
    }
    
    func testRequestWether() throws {
        Task {
            let state = await sut?.requestWether(for: CLLocationCoordinate2D(latitude: 100, longitude: 100))
            guard case let .results(response) = state else {
                XCTFail("Expected state .results")
                return
            }
            XCTAssertEqual(response.name, WetherResponse.mock.name)
            XCTAssertTrue((sut?.wetherCoordinator as? WetherCoordinatorMock)?.isWetherRequested == true)
        }
    }
    
    func testStartUpdatingLocations() throws {
        Task {
            await sut?.startUpdatingLocations()
            guard case let .results(response) = await sut?.wetherViewModel?.state else {
                XCTFail("Expected state .results")
                return
            }
            XCTAssertEqual(response.name, WetherResponse.mock.name)
            XCTAssertEqual(sut?.lastLocation.coordinate.latitude, CLLocation.mock.coordinate.latitude)
            XCTAssertTrue((sut?.persistenceManager as? PersistenceManagerMock)?.isSaved == true)
            XCTAssertTrue((sut?.wetherCoordinator as? WetherCoordinatorMock)?.isWetherRequested == true)
        }
    }

}

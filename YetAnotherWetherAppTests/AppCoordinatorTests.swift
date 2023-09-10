import XCTest
import CoreLocation
@testable import YetAnotherWetherApp

final class YetAnotherWetherAppTests: XCTestCase {
    
    var sut: AppCoordinator!
    var dependencyContainer: DependencyContainer!
    
    override func setUpWithError() throws {
        dependencyContainer = DependencyContainer.mock
        sut = AppCoordinator(dependencyContainer: dependencyContainer)
    }
    
    override func tearDownWithError() throws {
        sut = nil
        dependencyContainer = nil
    }
    
    func testMakeInitialScreen() async throws {
        
        let view = await sut?.makeInitialScreen()
        XCTAssertNotNil(view)
        XCTAssertNotNil(sut?.wetherViewModel)
        XCTAssertTrue((sut?.persistenceManager as? PersistenceManagerMock)?.isCoordinateRequested == true)
        XCTAssertTrue((sut?.wetherCoordinator as? WetherCoordinatorMock)?.isWetherRequested == true)
        
    }
    
    func testCheckInitialState() async throws {
        await sut?.checkInitialState()
        XCTAssertTrue((sut?.persistenceManager as? PersistenceManagerMock)?.isCoordinateRequested == true)
    }
    
    func testRequestWether() async throws {
        
        let state = await sut?.requestWether(for: CLLocationCoordinate2D(latitude: 100, longitude: 100))
        guard case let .results(response) = state else {
            XCTFail("Expected state .results")
            return
        }
        XCTAssertEqual(response.name, WetherResponse.mock.name)
        XCTAssertTrue((sut?.wetherCoordinator as? WetherCoordinatorMock)?.isWetherRequested == true)
        
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

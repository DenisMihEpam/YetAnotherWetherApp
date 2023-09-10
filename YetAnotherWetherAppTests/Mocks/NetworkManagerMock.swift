import Foundation
@testable import YetAnotherWetherApp

final class NetworkManagerMock: Networking {
    var requestPerformed = false
    
    func performRequest<T: Decodable>(url: URL) async throws -> T {
        requestPerformed = true
        throw AppError.invalidData
    }
    
}

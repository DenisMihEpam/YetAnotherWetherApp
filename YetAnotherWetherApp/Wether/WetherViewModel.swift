import Foundation
import SwiftUI

enum WetherViewState{
    case loading
    case results(WetherResponse)
    case error(AppError)
}

@MainActor final class WetherViewModel: ObservableObject {
    
    @Published var state: WetherViewState
    var searchViewHandler: (Place) -> Void = { _ in }
    
    init(
        state: WetherViewState,
        searchViewHandler: @escaping (Place) -> Void
    ) {
        self.state = state
        self.searchViewHandler = searchViewHandler
    }
}

import Foundation
import SwiftUI

enum WetherViewState{
    case loading
    case results(WetherResponse)
    case error(AppError)
}

@MainActor final class WetherViewModel: ObservableObject {
    
    @Published var state: WetherViewState
    
    init(
        state: WetherViewState
    ) {
        self.state = state
    }
}

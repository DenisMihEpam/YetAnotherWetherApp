import Foundation

extension WetherViewModel {
    static var loading: WetherViewModel {
        WetherViewModel(state: .loading)
    }
    static var results: WetherViewModel {
        WetherViewModel(state: .results(.mock))
    }
    static var error: WetherViewModel {
        WetherViewModel(state: .error(.invalidData))
    }
}

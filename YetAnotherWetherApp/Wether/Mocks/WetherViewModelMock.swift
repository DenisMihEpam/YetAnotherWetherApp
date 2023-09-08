import Foundation

extension WetherViewModel {
    static var loading: WetherViewModel {
        WetherViewModel(state: .loading, searchViewHandler: {_ in })
    }
    static var results: WetherViewModel {
        WetherViewModel(state: .results(.mock), searchViewHandler: {_ in })
    }
    static var error: WetherViewModel {
        WetherViewModel(state: .error(.invalidData), searchViewHandler: {_ in })
    }
}

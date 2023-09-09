import SwiftUI

struct ContentView: View {
    @StateObject var viewModel: WetherViewModel
    var body: some View {
        switch viewModel.state {
            case .loading:
                LoadingView()
            case .results(let model):
                WetherView(model: model)
            case .error(let error):
                ErrorView(error: error)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: .results)
    }
}

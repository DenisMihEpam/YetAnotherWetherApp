import SwiftUI

struct ErrorView: View {
    let error: AppError
    
    var body: some View {
        Color("background")
            .edgesIgnoringSafeArea(.all)
            .overlay {
                Text(error.errorMessage)
                    .padding()
                    .foregroundColor(.red)
                    .font(.title3)
                    .fontWeight(.semibold)
                    .multilineTextAlignment(.center)
            }
    }
}

struct ErrorView_Previews: PreviewProvider {
    static var previews: some View {
        ErrorView(error: .invalidData)
    }
}

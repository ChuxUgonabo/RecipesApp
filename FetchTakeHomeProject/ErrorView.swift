import SwiftUI

struct ErrorView: View {
    let error: Error
    let retryAction: () -> Void
    
    var body: some View {
        VStack(spacing: 16) {
            Image(systemName: "exclamationmark.triangle")
                .font(.system(size: 50))
                .foregroundColor(.orange)
            Text(error.localizedDescription)
                .multilineTextAlignment(.center)
            Button("Retry", action: retryAction)
                .buttonStyle(.bordered)
        }
        .padding()
    }
} 
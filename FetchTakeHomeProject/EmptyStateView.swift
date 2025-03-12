import SwiftUI

struct EmptyStateView: View {
    let message: String
    
    var body: some View {
        VStack(spacing: 16) {
            Image(systemName: "fork.knife.circle")
                .font(.system(size: 50))
                .foregroundColor(.gray)
            Text(message)
                .foregroundColor(.gray)
        }
    }
} 
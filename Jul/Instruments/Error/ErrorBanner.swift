





import SwiftUI

struct ErrorBanner: View {
    let message: String
    @State private var isVisible = true
    @State private var offset: CGFloat = -100

    var body: some View {
        if isVisible {
            Text(message)
                .font(.caption)
                .foregroundColor(.white)
                .padding(10)
                .background(Color.red.cornerRadius(8))
                .shadow(radius: 4)
                .offset(y: offset)
                .transition(.move(edge: .top).combined(with: .opacity))
                .onAppear {
                    withAnimation(.spring(response: 0.4, dampingFraction: 0.6)) {
                        offset = 0
                    }

                    DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                        withAnimation(.easeOut) {
                            offset = -100
                        }
                    }
                }
        }
    }
}

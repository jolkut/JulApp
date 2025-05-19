





import SwiftUI

struct InfoPopupModifier: ViewModifier {
    let title: String
    @Binding var isPresented: Bool

    func body(content: Content) -> some View {
        ZStack {
            content

            if isPresented {
                VStack {
                    Text(title)
                        .font(.caption)
                        .foregroundColor(.black)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 6)
                        .background(Color.white)
                        .cornerRadius(10)
                        .shadow(color: .black.opacity(0.1), radius: 4, x: 0, y: 2)
                        .transition(.move(edge: .top).combined(with: .opacity))
                        .zIndex(100)
                    Spacer()
                }
                .padding(.top, 24)
                .animation(.easeInOut(duration: 0.3), value: isPresented)
            }
        }
    }
}

extension View {
    func infoPopup(title: String, isPresented: Binding<Bool>) -> some View {
        self.modifier(InfoPopupModifier(title: title, isPresented: isPresented))
    }
}







import SwiftUI

struct ReusableAlert: ViewModifier {
    let title: String
    let message: String
    @Binding var isPresented: Bool
    let destructiveButtonTitle: String
    let onDestructive: () -> Void

    func body(content: Content) -> some View {
        content
            .alert(title, isPresented: $isPresented) {
                Button(destructiveButtonTitle, role: .destructive) {
                    onDestructive()
                }
                Button("Cancel", role: .cancel) {}
            } message: {
                Text(message)
            }
    }
}

extension View {
    func reusableAlert(
        title: String,
        message: String,
        isPresented: Binding<Bool>,
        destructiveButtonTitle: String = "Delete",
        onDestructive: @escaping () -> Void
    ) -> some View {
        self.modifier(ReusableAlert(
            title: title,
            message: message,
            isPresented: isPresented,
            destructiveButtonTitle: destructiveButtonTitle,
            onDestructive: onDestructive
        ))
    }
}

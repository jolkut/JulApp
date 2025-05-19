





import SwiftUI

struct ErrorAlertModifier: ViewModifier {
    @Binding var error: AppError?

    func body(content: Content) -> some View {
        content
            .alert(isPresented: .constant(error != nil)) {
                Alert(
                    title: Text("Error"),
                    message: Text(error?.message ?? "Something went wrong"),
                    dismissButton: .default(Text("OK")) {
                        error = nil
                    }
                )
            }
    }
}

extension View {
    func errorAlert(_ error: Binding<AppError?>) -> some View {
        self.modifier(ErrorAlertModifier(error: error))
    }
}

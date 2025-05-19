





import SwiftUI

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder),
                   to: nil, from: nil, for: nil)
    }
}

private struct HideKeyboardOnTap: ViewModifier {
    func body(content: Content) -> some View {
        content
            .contentShape(Rectangle())
            .onTapGesture { UIApplication.shared.endEditing() }
    }
}

extension View {
    func hideKeyboardOnTap() -> some View {
        modifier(HideKeyboardOnTap())
    }
}

struct CustomTextField: View {
    let title: String
    let placeholder: String
    @Binding var text: String

    let keyboardType: UIKeyboardType
    let height: CGFloat
    let font: Font
    let onCommit: () -> Void

    var body: some View {
        VStack(spacing: 6) {
            if !title.isEmpty {
                Text(title)
                    .font(font.weight(.semibold))
            }

            TextField(placeholder, text: $text, onCommit: {
                UIApplication.shared.endEditing()
                onCommit()
            })
            .font(font)
            .frame(height: height)
            .padding(.horizontal, 8)
            .background(
                RoundedRectangle(cornerRadius: 6)
                    .stroke(Color.gray.opacity(0.5), lineWidth: 1)
            )
            .keyboardType(keyboardType)
            .submitLabel(.done)
            .autocapitalization(keyboardType == .default ? .sentences : .none)
            .disableAutocorrection(keyboardType != .default)
        }
        .hideKeyboardOnTap()
    }
}

extension CustomTextField {
    init(
        title: String = "",
        placeholder: String = "",
        text: Binding<String>,
        font: Font = .body,
        height: CGFloat = 44,
        onCommit: @escaping () -> Void = {}
    ) {
        self.title = title
        self.placeholder = placeholder
        self._text = text
        self.font = font
        self.height = height
        self.keyboardType = .default
        self.onCommit = onCommit
    }

    init(
        numericTitle title: String = "",
        placeholder: String = "",
        text: Binding<String>,
        font: Font = .body,
        height: CGFloat = 44,
        onCommit: @escaping () -> Void = {}
    ) {
        self.title = title
        self.placeholder = placeholder
        self._text = text
        self.font = font
        self.height = height
        self.keyboardType = .numbersAndPunctuation
        self.onCommit = onCommit
    }
}

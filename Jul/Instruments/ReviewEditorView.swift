





import SwiftUI

struct ReviewEditorView: View {
    @Binding var reviewText: String
    @Binding var isEditing: Bool
    var onSave: () -> Void

    var body: some View {
        VStack(spacing: 12) {
            if isEditing {
                TextEditor(text: $reviewText)
                    .frame(height: 120)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.gray.opacity(0.4), lineWidth: 1)
                    )
                    .padding(8)

                PrimaryActionButton(
                    action: {
                        onSave()
                        isEditing = false
                    },
                    title: "Save"
                )
            } else {
                Text(reviewText.isEmpty ? "No review yet" : reviewText)
                    .padding(.vertical, 6)

                PrimaryActionButton(
                    action: { isEditing = true },
                    title: reviewText.isEmpty ? "Add" : "Edit"
                )
            }
        }
        .padding(.horizontal, 10)
    }
}

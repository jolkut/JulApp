





import SwiftUI

struct LikedAndReviewSection: View {
    @Binding var isDone: Bool
    @Binding var likedStatus: String
    @Binding var reviewText: String
    @Binding var isEditing: Bool
    let onSave: () -> Void

    var body: some View {
        VStack(spacing: 24) {
            HStack(spacing: 16) {
                Text("Status:")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                
                Picker("Status", selection: $isDone) {
                    Text("☑️ no").tag(false)
                    Text("✅ yes").tag(true)
                }
                .pickerStyle(MenuPickerStyle())
            }
            .padding(.top, 6)

            if isDone {
                VStack(spacing: 16) {
                    Text("Do you like this?")
                        .font(.subheadline)
                        .fontWeight(.semibold)

                    Picker("Like status", selection: $likedStatus) {
                        Text("❤️‍🔥").tag("❤️‍🔥")
                        Text("〰️").tag("〰️")
                        Text("👎🏻").tag("👎🏻")
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .padding(16)

                    Text("Review:")
                        .font(.subheadline)
                        .fontWeight(.semibold)

                    ReviewEditorView(
                        reviewText: $reviewText,
                        isEditing: $isEditing,
                        onSave: onSave
                    )
                }
            }
        }
        .padding(16)
    }
}

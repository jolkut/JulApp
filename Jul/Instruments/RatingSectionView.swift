





import SwiftUI

struct RatingSectionView: View {
    @Binding var rating: String
    @Binding var newRating: String
    var onSave: () -> Void
    @Binding var showRatingUpdateAlert: Bool

    var body: some View {
        VStack(spacing: 16) {
            Text("Rating:")
                .font(.headline)
                .padding(.vertical, 8)

            HStack(spacing: 16) {
                Text("\(rating)⭐️")

                CustomTextField(
                    numericTitle: "",
                    placeholder: "New",
                    text: $newRating,
                    font: .body,
                    height: 30
                ) {
                    handleSave()
                }
                .frame(width: 60)

                PrimaryActionButton(action: {
                    handleSave()
                }, title: "Update")
            }
            .padding(16)
        }
        .padding(16)
        .infoPopup(title: "Rating updated!", isPresented: $showRatingUpdateAlert)
    }

    private func handleSave() {
        onSave()
        showRatingUpdateAlert = true

        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            showRatingUpdateAlert = false
        }
    }
}

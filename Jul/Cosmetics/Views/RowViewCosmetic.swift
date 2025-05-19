





import SwiftUI

struct RowViewCosmetic: View {
    let cosmetics: Cosmetic

    var body: some View {
        HStack(spacing: 16) {
            RowDoneStatusView(
                isDone: cosmetics.isBuying,
                likedStatus: cosmetics.likedCosmeticStatus,
                priority: cosmetics.priorityStatus
            )
            .frame(width: 40)

            RowImageView(
                imageData: cosmetics.image ?? cosmetics.configurations.first?.image
            )

            VStack(alignment: .leading, spacing: 6) {
                Text(cosmetics.title)
                    .font(.headline)

                Text(cosmetics.brand)
                    .font(.subheadline)
                    .foregroundColor(.gray)

                Text("Rating: \(cosmetics.rating) ⭐️")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }

            Spacer()
        }
        .padding(10)
        .contentShape(Rectangle())
    }
}

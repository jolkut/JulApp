





import SwiftUI

struct RowViewPlace: View {
    let place: Place

    var body: some View {
        HStack(spacing: 16) {
            RowDoneStatusView(
                isDone: place.isVisited,
                likedStatus: place.likedPlaceStatus,
                priority: place.priorityStatus
            )
            .frame(width: 40)

            RowImageView(
                imageData: place.images.first
            )

            VStack(alignment: .leading, spacing: 6) {
                Text(place.title)
                    .font(.headline)

                Text(place.country)
                    .font(.subheadline)
                    .foregroundColor(.gray)

                Text("Rating: \(place.rating) ⭐️")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }

            Spacer()
        }
        .padding(10)
        .contentShape(Rectangle())
    }
}

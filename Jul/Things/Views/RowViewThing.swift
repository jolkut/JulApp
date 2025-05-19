





import SwiftUI

struct RowViewThing: View {

    let things: Thing

        var body: some View {
            HStack(spacing: 16) {
                RowDoneStatusView(
                    isDone: things.isBuying,
                    likedStatus: things.likedThingStatus,
                    priority: things.priorityStatus
                )
                .frame(width: 40)

                RowImageView(
                    imageData: things.mainImage ?? things.configurations.first?.image
                )

                VStack(alignment: .leading, spacing: 6) {
                    Text(things.title)
                        .font(.headline)

                    Text(things.brand)
                        .font(.subheadline)
                        .foregroundColor(.gray)

                    Text("Rating: \(things.rating) ⭐️")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }

                Spacer()
            }
            .padding(10)
            .contentShape(Rectangle())
        }
    }

    

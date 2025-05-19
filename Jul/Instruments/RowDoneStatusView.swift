





import SwiftUI

struct RowDoneStatusView: View {
    let isDone: Bool
    let likedStatus: String?
    let priority: String?

    var body: some View {
        VStack(spacing: 4) {
            if let priority {
                Text(priority)
                    .font(.title2)
            }

            Text(isDone ? "✅" : "☑️")
                .font(.title3)

            if isDone, let liked = likedStatus {
                Text(liked)
                    .font(.caption)
            }
        }
        .frame(maxWidth: .infinity)
    }
}

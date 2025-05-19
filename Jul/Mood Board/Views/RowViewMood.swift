


import SwiftUI

struct RowViewMood: View {
    let item: Mood

    var body: some View {
        HStack(spacing: 16) {
            RowImageView(
                imageData: item.images.first
            )
        }
        .frame(maxWidth: .infinity)
        .padding()
    }
}

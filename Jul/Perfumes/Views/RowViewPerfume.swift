





import SwiftUI

struct RowViewPerfume: View {
    let perfume: Perfume
    
    var body: some View {
        HStack(spacing: 16) {
           RowDoneStatusView(
               isDone: perfume.isBuying,
               likedStatus: perfume.likedPerfumeStatus,
               priority: perfume.priorityStatus
           )
           .frame(width: 40)
            
            RowImageView(
                imageData: perfume.mainImage
            )
            
            VStack(alignment: .leading, spacing: 4) {
                Text(perfume.title)
                    .font(.headline)
                
                Text(perfume.brand)
                    .font(.subheadline)
                    .foregroundColor(.gray)
                
                Text("Rating: \(perfume.rating) ⭐️")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            Spacer()
        }
        .padding(10)
        .contentShape(Rectangle())
    }
}

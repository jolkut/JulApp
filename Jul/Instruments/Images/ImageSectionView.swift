





import SwiftUI

struct ImageSectionView: View {
    let title: String
    @Binding var imageData: Data?
    @Binding var isImagePickerPresented: Bool
    @Binding var isImageFullScreenPresented: Bool
    var onDelete: (() -> Void)?

    var body: some View {
        VStack() {
            Text(title)
                .font(.subheadline)
                .fontWeight(.semibold)
                .padding(10)

            ImagePickerView(
                imageData: $imageData,
                isImagePickerPresented: $isImagePickerPresented,
                isImageFullScreenPresented: $isImageFullScreenPresented,
                onDelete: onDelete
            )
            .padding(.bottom, 20)
        }
        .padding(.horizontal, 20)
    }
}







import SwiftUI

struct ImagePickerView: View {
    @Binding var imageData: Data?
    @Binding var isImagePickerPresented: Bool
    @Binding var isImageFullScreenPresented: Bool
    var onDelete: (() -> Void)?
    
    @State private var showDeleteAlert = false

    var body: some View {
        ZStack(alignment: .topTrailing) {
            if let data = imageData, let uiImage = UIImage(data: data) {
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 300, height: 300)
                    .clipped()
                    .onTapGesture {
                        isImageFullScreenPresented = true
                    }

                Button(action: {
                    showDeleteAlert = true
                }) {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.gray)
                        .background(Color.white.opacity(0.7), in: Circle())
                }
            } else {
                Button("Select Photo") {
                    isImagePickerPresented = true
                }
                .sheet(isPresented: $isImagePickerPresented) {
                    ImagePicker(imageData: $imageData)
                }
            }
        }
        .fullScreenCover(isPresented: $isImageFullScreenPresented) {
            if let imageData = imageData, let fullImage = UIImage(data: imageData) {
                ZoomableImageView(image: fullImage, onClose: {
                    isImageFullScreenPresented = false
                })
            }
        }
        .reusableAlert(
            title: "Delete this image?",
            message: "This will permanently remove the image.",
            isPresented: $showDeleteAlert,
            onDestructive: {
                onDelete?()
            }
        )
    }
}

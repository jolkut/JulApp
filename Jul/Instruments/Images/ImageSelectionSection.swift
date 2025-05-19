





import SwiftUI

struct ImageSelectionSection: View {
    @Binding var selectedImageData: Data?
    @Binding var addedImagesData: [Data]
    @Binding var isImagePickerPresented: Bool
    @Binding var isImageFullScreenPresented: Bool
    var onError: (String) -> Void

    var body: some View {
        VStack {
            Text("Images:")
                .font(.headline)
                .padding(10)

            ImagePickerView(
                imageData: $selectedImageData,
                isImagePickerPresented: $isImagePickerPresented,
                isImageFullScreenPresented: $isImageFullScreenPresented,
                onDelete: { selectedImageData = nil }
            )

            if selectedImageData != nil {
                PrimaryActionButton(action: addSelectedImage, title: "Add")
            }

            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(addedImagesData.indices, id: \.self) { index in
                        if let uiImage = UIImage(data: addedImagesData[index]) {
                            Image(uiImage: uiImage)
                                .resizable()
                                .frame(width: 80, height: 80)
                                .cornerRadius(8)
                        }
                    }
                }
            }
        }
    }

    private func addSelectedImage() {
        guard let imageData = selectedImageData else {
            onError("No image selected.")
            return
        }

        addedImagesData.append(imageData)
        selectedImageData = nil
        onError("") 
    }
}

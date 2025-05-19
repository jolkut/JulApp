





import SwiftUI

struct HorizontalImagesGallery: View {
    @Binding var images: [Data]
    @Binding var isImagePickerPresented: Bool
    @Binding var isImageFullScreenPresented: Bool

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(Array(images.enumerated()), id: \.element) { index, _ in
                    ImageSectionView(
                        title: "✨",
                        imageData: Binding<Data?>(
                            get: { images[index] },
                            set: { newData in
                                if let data = newData {
                                    images[index] = data
                                }
                            }
                        ),
                        isImagePickerPresented: $isImagePickerPresented,
                        isImageFullScreenPresented: $isImageFullScreenPresented,
                        onDelete: {
                            images.remove(at: index)
                        }
                    )
                }
            }
        }
    }
}

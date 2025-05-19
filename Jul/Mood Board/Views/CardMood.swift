





import SwiftUI
import SwiftData

struct CardMood: View {
    @Bindable var mood: Mood
    @Environment(\.modelContext) private var modelContext
    @EnvironmentObject var listViewModelMood: ListViewModelMood
    @Environment(\.dismiss) var dismiss

    @State private var showDeleteAlert: Bool = false
    @State private var isImagePickerPresented: Bool = false
    @State private var isImageFullScreenPresented: Bool = false

    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                Text(mood.title)
                    .font(.title2)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)

                Text("Category: \(mood.category)")
                    .font(.subheadline)
                    .foregroundColor(.secondary)

                HorizontalImagesGallery(
                    images: $mood.images,
                    isImagePickerPresented: $isImagePickerPresented,
                    isImageFullScreenPresented: $isImageFullScreenPresented
                )
                .padding()

                if let linkString = mood.link, let url = URL(string: linkString) {
                    Link("🔗 Open Link", destination: url)
                        .font(.body)
                        .foregroundColor(.blue)
                        .underline()
                } else if mood.link != nil {
                    Text("Invalid link")
                        .foregroundColor(.red)
                        .font(.caption)
                }

                Text("Description:")
                    .font(.subheadline)
                    .fontWeight(.semibold)

                Text(mood.descriptionT)
                    .font(.body)
            }
            .padding()
        }
        .navigationBarItems(
            trailing: Button(role: .destructive) {
                showDeleteAlert = true
            } label: {
                Image(systemName: "trash")
            }
        )
        .reusableAlert(
            title: "Delete this mood?",
            message: "This action cannot be undone.",
            isPresented: $showDeleteAlert,
            onDestructive: {
                modelContext.delete(mood)
                listViewModelMood.fetchMoods()
                dismiss()
            }
        )
    }
}

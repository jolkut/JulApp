





import SwiftUI
import SwiftData

struct AddConfigurationViewThing: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) private var modelContext

    var thing: Thing

    @State private var configurationName: String = ""
    @State private var isImagePickerPresented = false
    @State private var imageData: Data?
    @State private var isImageFullScreenPresented = false

    var body: some View {
        VStack(alignment: .center, spacing: 20) {
            Text("New Configuration and Photo:")
                .font(.title)

            CustomTextField(
                title: "Name:",
                placeholder: "Enter configuration name...",
                text: $configurationName
            )

            ImagePickerView(
                imageData: $imageData,
                isImagePickerPresented: $isImagePickerPresented,
                isImageFullScreenPresented: $isImageFullScreenPresented
            )

            PrimaryActionButton(action: saveConfiguration, title: "Save")
        }
        .padding()
    }

    private func saveConfiguration() {
        guard !configurationName.isEmpty, let data = imageData else { return }
        let newConfig = ThingConfiguration(configuration: configurationName, image: data)
        thing.configurations.append(newConfig)
        modelContext.insert(newConfig)
        dismiss()
    }
}

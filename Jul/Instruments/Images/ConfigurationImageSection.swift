





import SwiftUI

struct ConfigurationImage: Identifiable, Hashable {
    var id = UUID().uuidString
    var configuration: String
    var imageData: Data
}

struct ConfigurationImageSection: View {
    @Binding var textFieldConfiguration: String
    @Binding var selectedImageData: Data?
    @Binding var isImagePickerPresented: Bool
    @Binding var isImageFullScreenPresented: Bool
    @Binding var showDeleteConfigAlert: Bool
    @Binding var errorMessage: String?
    @Binding var addedConfigurations: [ConfigurationImage]
    @Binding var configurationToDelete: ConfigurationImage?
    
    @State private var localTextFieldConfiguration: String = ""
    
    var body: some View {
        VStack {
            Text("Configurations:")
                .font(.headline)
                .padding(.bottom, 5)
            
            ImagePickerView(
                imageData: $selectedImageData,
                isImagePickerPresented: $isImagePickerPresented,
                isImageFullScreenPresented: $isImageFullScreenPresented,
                onDelete: { selectedImageData = nil }
            )
            .padding(.bottom)
            
            VStack(alignment: .center) {
                CustomTextField(title: "", placeholder: "Enter configuration name...", text: $localTextFieldConfiguration)
                
                PrimaryActionButton(action: addNewConfiguration, title: "Add")
            }
            
            if !addedConfigurations.isEmpty {
                VStack(alignment: .leading, spacing: 10) {
                    ForEach(addedConfigurations) { configuration in
                        ZStack(alignment: .topTrailing) {
                            HStack {
                                Text("Configuration: \(configuration.configuration)")
                                    .font(.subheadline)
                                
                                if let image = UIImage(data: configuration.imageData) {
                                    Image(uiImage: image)
                                        .resizable()
                                        .frame(width: 50, height: 50)
                                        .cornerRadius(5)
                                } else {
                                    Rectangle()
                                        .fill(Color.gray)
                                        .frame(width: 50, height: 50)
                                        .cornerRadius(5)
                                }
                            }
                            .padding(.trailing, 25)
                            
                            Button(action: {
                                configurationToDelete = configuration
                                showDeleteConfigAlert = true
                            }) {
                                Image(systemName: "xmark.circle.fill")
                                    .foregroundColor(.gray)
                                    .background(Color.white.opacity(0.7), in: Circle())
                            }
                            .offset(x: 10, y: -10)
                        }
                    }
                }
                .padding(.top, 10)
            }
        }
        .padding(.vertical)
        .alert("Delete this configuration?", isPresented: $showDeleteConfigAlert) {
            Button("Delete", role: .destructive) {
                if let config = configurationToDelete,
                   let index = addedConfigurations.firstIndex(where: { $0.id == config.id }) {
                    addedConfigurations.remove(at: index)
                }
                configurationToDelete = nil
            }
            Button("Cancel", role: .cancel) {
                configurationToDelete = nil
            }
        } message: {
            Text("This will remove the configuration and its image.")
        }
    }
    
    private func addNewConfiguration() {
        guard !localTextFieldConfiguration.isEmpty else {
            errorMessage = "Configuration name cannot be empty."
            return
        }
        
        guard let selectedImage = selectedImageData else {
            errorMessage = "Please select an image for the configuration."
            return
        }
        
        let newConfig = ConfigurationImage(configuration: localTextFieldConfiguration, imageData: selectedImage)
        addedConfigurations.append(newConfig)
        
        localTextFieldConfiguration = ""
        selectedImageData = nil
        errorMessage = nil
        textFieldConfiguration = localTextFieldConfiguration
    }
}

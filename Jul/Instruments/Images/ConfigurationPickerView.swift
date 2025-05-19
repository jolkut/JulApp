





import SwiftUI
import SwiftData

protocol ConfigurableItem: AnyObject {
    associatedtype Configuration: Identifiable & Equatable & Hashable
    var configurations: [Configuration] { get set }
}

struct ConfigurationPickerView<Item: ConfigurableItem>: View {
    @Environment(\.modelContext) private var modelContext
    var item: Item

    let getTitle: (Item.Configuration) -> String
    let getImage: (Item.Configuration) -> Data?
    let setImage: (inout Item.Configuration, Data) -> Void

    @Binding var selectedConfiguration: Item.Configuration?
    @Binding var selectedImageData: Data?
    @Binding var isImagePickerPresented: Bool
    @Binding var isImageFullScreenPresented: Bool
    @Binding var showDeleteAlert: Bool
    @Binding var configurationToDelete: Item.Configuration?
    @Binding var errorMessage: String?

    @State private var showAddSheet = false

    var body: some View {
        VStack(spacing: 12) {

            HStack {
                Text("Configuration:")
                    .font(.subheadline)
                    .fontWeight(.semibold)

                Picker("Select a configuration", selection: $selectedConfiguration) {
                    ForEach(item.configurations, id: \.id) { config in
                        Text(getTitle(config)).tag(Optional(config))
                    }
                }
                .pickerStyle(MenuPickerStyle())

                PrimaryActionButton(action: {
                    showAddSheet = true
                    errorMessage = nil
                }, title: "Add")
            }
            .padding(.horizontal)

            if let data = selectedConfiguration.flatMap(getImage) {
                ImagePickerView(
                    imageData: Binding(
                        get: { selectedImageData ?? data },
                        set: {
                            selectedImageData = $0
                            if let d = $0 {
                                if var sel = selectedConfiguration {
                                    setImage(&sel, d)
                                    try? modelContext.save()
                                }
                            }
                        }
                    ),
                    isImagePickerPresented: $isImagePickerPresented,
                    isImageFullScreenPresented: $isImageFullScreenPresented
                ) {
                    configurationToDelete = selectedConfiguration
                    showDeleteAlert = true
                    errorMessage = nil
                }
            } else {
                Rectangle()
                    .fill(Color.gray.opacity(0.2))
                    .frame(width: 200, height: 200)
                    .overlay(Text("No Image Available").foregroundColor(.gray))
            }
        }
        .sheet(isPresented: $showAddSheet, onDismiss: {
            selectedConfiguration = item.configurations.last
        }) {
            EmptyView()
        }
        .alert("Delete this configuration?", isPresented: $showDeleteAlert) {
            Button("Delete", role: .destructive) {
                if let cfg = configurationToDelete,
                   let idx = item.configurations.firstIndex(of: cfg) {
                    item.configurations.remove(at: idx)
                    try? modelContext.save()
                    selectedConfiguration = item.configurations.first
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
}

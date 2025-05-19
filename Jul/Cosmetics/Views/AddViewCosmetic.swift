





import SwiftUI

struct AddViewCosmetic: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var listViewModelCosmetic: ListViewModelCosmetic
    @EnvironmentObject var cosmeticCardViewModel: CosmeticsCardViewModel

    @Binding var categorySelection: CosmeticCategory
    @State private var storeSelection: CurrencyCosmetic = .sephoraAmerica

    @State private var textFieldBrand: String = ""
    @State private var textFieldName: String = ""
    @State private var textFieldPrice: String = ""
    @State private var textFieldSize: String = ""
    @State private var textFieldRating: String = ""

    @State private var addedPrices: [CosmeticPrice] = []
    @State private var addedConfigurations: [ConfigurationImage] = []

    @State private var errorMessage: String? = nil
    @State private var selectedImageData: Data? = nil
    @State private var isImagePickerPresented: Bool = false
    @State private var isImageFullScreenPresented: Bool = false
    
    @State private var textFieldConfiguration: String = ""
    @State private var showDeleteConfigAlert = false
    @State private var configurationToDelete: ConfigurationImage? = nil
        
    var body: some View {
        ScrollView {
            VStack(alignment: .center, spacing: 20) {
                Text("Add New Cosmetic")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.bottom, 20)

                CustomTextField(
                    title: "Name:",
                    placeholder: "Enter cosmetic name...",
                    text: $textFieldName
                )

                CustomTextField(
                    title: "Brand:",
                    placeholder: "Enter brand name...",
                    text: $textFieldBrand
                )

                ConfigurationImageSection(
                    textFieldConfiguration: $textFieldConfiguration,
                    selectedImageData: $selectedImageData,
                    isImagePickerPresented: $isImagePickerPresented,
                    isImageFullScreenPresented: $isImageFullScreenPresented,
                    showDeleteConfigAlert: $showDeleteConfigAlert,
                    errorMessage: $errorMessage,
                    addedConfigurations: $addedConfigurations,
                    configurationToDelete: $configurationToDelete
                )

                PriceInputSection<CosmeticPrice, CurrencyCosmetic>(
                    selectedStore: $storeSelection,
                    priceInput: $textFieldPrice,
                    prices: $addedPrices,
                    errorMessage: $errorMessage
                ) { enteredPrice, store in
                    let calculated = store.calculatedPrice(enteredPrice)
                    return CosmeticPrice(price: calculated, store: store)
                }

                CategoryPickerView(
                    title: "Category:",
                    selection: $categorySelection,
                    allOptions: CosmeticCategory.allCases.filter { $0 != .allCategories }
                )
                
                CustomTextField(
                    numericTitle: "Size:",
                    placeholder: "Enter cosmetic size...",
                    text: $textFieldSize
                )
                
                CustomTextField(
                    numericTitle: "Rating:",
                    placeholder: "Enter cosmetic rating...",
                    text: $textFieldRating
                )

                PrimaryActionButton(action: saveButtonPressed, title: "Save")
                    .frame(maxWidth: .infinity)

            }
            .padding(16)
        }
        .hideKeyboardOnTap()
    }

    private func saveButtonPressed() {
        guard !textFieldName.isEmpty else {
            errorMessage = "No name added."
            return
        }

        let previewImageData = selectedImageData ?? addedConfigurations.first?.imageData

        let convertedConfigurations: [CosmeticConfiguration] = addedConfigurations.map {
            CosmeticConfiguration(configuration: $0.configuration, image: $0.imageData)
        }

        let newCosmetic = Cosmetic(
            brand: textFieldBrand,
            image: previewImageData,
            title: textFieldName,
            category: categorySelection.rawValue,
            shop: storeSelection,
            prices: addedPrices,
            configurations: convertedConfigurations,
            size: textFieldSize,
            rating: textFieldRating,
            isBuying: false
        )

        listViewModelCosmetic.addItem(newCosmetic)
        cosmeticCardViewModel.addItem(cosmetic: newCosmetic)

        resetFields()
        dismiss()
    }

    private func resetFields() {
        textFieldName = ""
        textFieldBrand = ""
        textFieldPrice = ""
        textFieldSize = ""
        textFieldRating = ""
        addedPrices.removeAll()
        addedConfigurations.removeAll()
        selectedImageData = nil
        errorMessage = nil
    }
}

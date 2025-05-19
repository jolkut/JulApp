





import SwiftUI

struct AddViewThing: View {

    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var listViewModelThing: ListViewModelThing
    @EnvironmentObject var thingCardViewModel: ThingCardViewModel

    @State private var categorySelection: ThingCategory = .allCategories
    @State private var storeSelection: CurrencyThing = .zalandoEngland

    @State private var textFieldBrand: String = ""
    @State private var textFieldName: String = ""
    @State private var textFieldPrice: String = ""
    @State private var textFieldSize: String = ""
    @State private var textFieldRating: String = ""
    
    @State private var addedPrices: [ThingPrice] = []
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
                Text("Add New Thing")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.bottom, 20)

                CustomTextField(
                    title: "Name:",
                    placeholder: "Enter thing name...",
                    text: $textFieldName)
                
                CustomTextField(
                    title: "Brand:",
                    placeholder: "Enter brand name...",
                    text: $textFieldBrand)

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

                PriceInputSection<ThingPrice, CurrencyThing>(
                    selectedStore: $storeSelection,
                    priceInput: $textFieldPrice,
                    prices: $addedPrices,
                    errorMessage: $errorMessage
                ) { enteredPrice, store in
                    let calculated = store.calculatedPrice(enteredPrice)
                    return ThingPrice(price: calculated, store: store)
                }

                CategoryPickerView(
                    title: "Category:",
                    selection: $categorySelection,
                    allOptions: ThingCategory.allCases.filter { $0 != .allCategories }
                )
                
                CustomTextField(
                    numericTitle: "Rating:",
                    placeholder: "Enter thing rating...",
                    text: $textFieldRating)

                PrimaryActionButton(action: saveButtonPressed, title: "Save")
                    .frame(maxWidth: .infinity)

            }
            .padding(16)
        }        
    }

    private func saveButtonPressed() {
        guard !textFieldName.isEmpty,
              !textFieldBrand.isEmpty else {
            errorMessage = "Name and brand are required."
            return
        }

        guard let mainImage = selectedImageData else {
            errorMessage = "Please select a main image."
            return
        }

        let convertedConfigurations: [ThingConfiguration] = addedConfigurations.map {
            ThingConfiguration(configuration: $0.configuration, image: $0.imageData)
        }

        let newThing = Thing(
            brand: textFieldBrand,
            mainImage: mainImage,
            title: textFieldName,
            rating: textFieldRating,
            category: categorySelection.rawValue,
            shop: nil,
            prices: addedPrices,
            configurations: convertedConfigurations
        )

        listViewModelThing.addThing(newThing)
        thingCardViewModel.addItem(thing: newThing)

        resetFields()
        dismiss()
    }

    private func resetFields() {
        textFieldName = ""
        textFieldPrice = ""
        textFieldConfiguration = ""
        textFieldBrand = ""
        textFieldRating = ""
        selectedImageData = nil
        addedPrices.removeAll()
        addedConfigurations.removeAll()
        errorMessage = nil
    }
}

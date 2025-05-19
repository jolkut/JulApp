





import SwiftUI

struct AddViewPerfume: View {
    
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var listViewModelPerfume: ListViewModelPerfume
    @EnvironmentObject var perfumeCardViewModel: PerfumeCardViewModel

    @State private var storeSelection: CurrencyPerfume = .enigmaMoldova

    @State private var linkStoreSelection: CurrencyPerfume = .enigmaMoldova
    @State private var textFieldBrand: String = ""
    @State private var textFieldName: String = ""
    @State private var textFieldPrice: String = ""
    @State private var textFieldSize: String = ""
    @State private var textFieldRating: String = ""
    @State private var addedPrices: [PerfumePrice] = []
    @State private var errorMessage: String? = nil

    @State private var mainImageData: Data? = nil
    @State private var accordsImageData: Data? = nil
    @State private var pyramidImageData: Data? = nil

    @State private var isMainImagePickerPresented = false
    @State private var isMainImageFullScreenPresented = false

    @State private var isAccordsImagePickerPresented = false
    @State private var isAccordsImageFullScreenPresented = false

    @State private var isPyramidImagePickerPresented = false
    @State private var isPyramidImageFullScreenPresented = false

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                Text("Add New Perfume")
                    .font(.largeTitle)
                    .fontWeight(.bold)

                CustomTextField(
                    title: "Name:",
                    placeholder: "Enter perfume name...",
                    text: $textFieldName)
                
                CustomTextField(
                    title: "Brand:",
                    placeholder: "Enter brand name...",
                    text: $textFieldBrand)

                Text("Image of perfume:")
                    .font(.headline)

                VStack(alignment: .center) {
                    Text("Main:")
                        .font(.headline)
                    ImagePickerView(
                        imageData: $mainImageData,
                        isImagePickerPresented: $isMainImagePickerPresented,
                        isImageFullScreenPresented: $isMainImageFullScreenPresented,
                        onDelete: {
                            mainImageData = nil
                        }
                    )
                }

                VStack(alignment: .center) {
                    Text("Main accords:")
                        .font(.headline)
                    ImagePickerView(
                        imageData: $accordsImageData,
                        isImagePickerPresented: $isAccordsImagePickerPresented,
                        isImageFullScreenPresented: $isAccordsImageFullScreenPresented,
                        onDelete: {
                            accordsImageData = nil
                        }
                    )
                }

                VStack(alignment: .center) {
                    Text("Pyramid:")
                        .font(.headline)
                    ImagePickerView(
                        imageData: $pyramidImageData,
                        isImagePickerPresented: $isPyramidImagePickerPresented,
                        isImageFullScreenPresented: $isPyramidImageFullScreenPresented,
                        onDelete: {
                            pyramidImageData = nil
                        }
                    )
                }

                PriceInputSection<PerfumePrice, CurrencyPerfume>(
                    selectedStore: $linkStoreSelection,
                    priceInput: $textFieldPrice,
                    prices: $addedPrices,
                    errorMessage: $errorMessage
                ) { enteredPrice, store in
                    let calculated = store.calculatedPrice(enteredPrice)
                    return PerfumePrice(price: calculated, store: store)
                }

                CustomTextField(
                    numericTitle: "Size:",
                    placeholder: "Enter perfume size...",
                    text: $textFieldSize)
                
                CustomTextField(
                    numericTitle: "Rating:",
                    placeholder: "Enter perfume rating...",
                    text: $textFieldRating)

                PrimaryActionButton(action: saveButtonPressed, title: "Save")
                    .frame(maxWidth: .infinity)
            }
            .padding(16)
        }
        .hideKeyboardOnTap()
    }

    private func saveButtonPressed() {
        guard !addedPrices.isEmpty else {
            errorMessage = "No prices added."
            return
        }

        guard let mainImage = mainImageData else {
            errorMessage = "Main image is required."
            return
        }

        let newPerfume = Perfume(
            brand: textFieldBrand,
            mainImage: mainImage,
            accordsImage: accordsImageData,
            pyramidImage: pyramidImageData,
            title: textFieldName,
            shop: storeSelection,
            prices: addedPrices,
            size: textFieldSize,
            rating: textFieldRating,
            isBuying: false
        )

        listViewModelPerfume.addItem(perfume: newPerfume)
        perfumeCardViewModel.addItem(perfume: newPerfume)

        resetFields()
        dismiss()
    }

    private func resetFields() {
        textFieldBrand = ""
        textFieldName = ""
        textFieldPrice = ""
        textFieldSize = ""
        textFieldRating = ""
        addedPrices.removeAll()
        errorMessage = nil
    }
}

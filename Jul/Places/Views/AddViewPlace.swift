




import SwiftUI

struct AddViewPlace: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext
    @EnvironmentObject var listViewModelPlace: ListViewModelPlace
    @EnvironmentObject var placeCardViewModel: PlaceCardViewModel

    @State private var categorySelection: PlaceCategory = .allCategories

    @State private var textFieldRating: String = ""
    @State private var textFieldCountry: String = ""
    @State private var textFieldTitle: String = ""
    @State private var textFieldDescription: String = ""
    @State private var textFieldAddress: String = ""

    @State private var addedImagesData: [Data] = []
    @State private var selectedImageData: Data? = nil
    @State private var isImagePickerPresented: Bool = false         
    @State private var isImageFullScreenPresented: Bool = false
    @State private var errorMessage: String? = nil

    var body: some View {
        ScrollView {
            VStack(alignment: .center, spacing: 20) {
                Text("Add New Place")
                    .font(.largeTitle)
                    .fontWeight(.bold)

                CustomTextField(
                    title: "Country:",
                    placeholder: "Enter country name...",
                    text: $textFieldCountry)
                
                CustomTextField(
                    title: "Address:",
                    placeholder: "Enter address...",
                    text: $textFieldAddress)
                
                CustomTextField(
                    title: "Title:",
                    placeholder: "Enter place title...",
                    text: $textFieldTitle)

                ImageSelectionSection(
                    selectedImageData: $selectedImageData,
                    addedImagesData: $addedImagesData,
                    isImagePickerPresented: $isImagePickerPresented,
                    isImageFullScreenPresented: $isImageFullScreenPresented,
                    onError: { message in errorMessage = message }
                )

                CustomTextField(numericTitle: "Rating:", placeholder: "Enter rating...", text: $textFieldRating)

                CategoryPickerView(
                    title: "Category:",
                    selection: $categorySelection,
                    allOptions: PlaceCategory.allCases.filter { $0 != .allCategories }
                )

                CustomTextField(
                    title: "Description:",
                    placeholder: "Add a description...",
                    text: $textFieldDescription)

                PrimaryActionButton(action: saveButtonPressed, title: "Save")
                    .frame(maxWidth: .infinity)

            }
            .padding(16)
        }
        .hideKeyboardOnTap()
    }

    private func saveButtonPressed() {
        guard !textFieldCountry.isEmpty, !textFieldTitle.isEmpty else {
            errorMessage = "Please fill in all required fields."
            return
        }

        let newPlace = Place(
            rating: textFieldRating,
            country: textFieldCountry,
            images: addedImagesData,
            descriptionText: textFieldDescription,
            title: textFieldTitle,
            category: categorySelection.rawValue,
            isVisited: false,
            likedPlaceStatus: nil,
            reviewText: textFieldDescription.isEmpty ? nil : textFieldDescription,
            adress: textFieldAddress.isEmpty ? nil : textFieldAddress
        )

        listViewModelPlace.addPlaces(newPlace)
        placeCardViewModel.addItem(place: newPlace)

        resetFields()
        dismiss()
    }

    private func resetFields() {
        textFieldRating = ""
        textFieldCountry = ""
        textFieldTitle = ""
        textFieldDescription = ""
        textFieldAddress = ""
        addedImagesData.removeAll()
        selectedImageData = nil
        errorMessage = nil
    }
}

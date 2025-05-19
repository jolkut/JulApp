





import SwiftUI

struct AddViewMood: View {
    
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var listViewModelMood: ListViewModelMood
    @EnvironmentObject var moodCardViewModel: MoodCardViewModel
    
    @State private var categorySelection: MoodCategory = .allCategories
    
    @State private var textFieldTitle: String = ""
    @State private var textFieldLink: String = ""
    @State private var textFieldDescription: String = ""
    
    @State private var addedImagesData: [Data] = []
    @State private var selectedImageData: Data? = nil
    @State private var isImagePickerPresented: Bool = false
    @State private var isImageFullScreenPresented: Bool = false
    @State private var errorMessage: String? = nil
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                Text("Add New Mood")
                    .font(.largeTitle)
                    .fontWeight(.bold)

                CustomTextField(
                    title: "Title:",
                    placeholder: "Enter title...",
                    text: $textFieldTitle)
                
                CustomTextField(
                    title: "Link (optional):",
                    placeholder: "Enter link...",
                    text: $textFieldLink)

                ImageSelectionSection(
                    selectedImageData: $selectedImageData,
                    addedImagesData: $addedImagesData,
                    isImagePickerPresented: $isImagePickerPresented,
                    isImageFullScreenPresented: $isImageFullScreenPresented,
                    onError: { message in errorMessage = message }
                )

                CategoryPickerView(
                    title: "Category:",
                    selection: $categorySelection,
                    allOptions: MoodCategory.allCases.filter { $0 != .allCategories }
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

        let newMood = Mood(
            images: addedImagesData,
            title: textFieldTitle,
            category: categorySelection.rawValue,
            link: textFieldLink.isEmpty ? nil : textFieldLink,
            descriptionT: textFieldDescription
        )

        listViewModelMood.addMood(newMood)
        moodCardViewModel.addMood(mood: newMood)

        resetFields()
        dismiss()
    }

    private func resetFields() {
        textFieldTitle = ""
        textFieldLink = ""
        textFieldDescription = ""
        addedImagesData.removeAll()
        selectedImageData = nil
        categorySelection = .allCategories
        errorMessage = nil
    }
}

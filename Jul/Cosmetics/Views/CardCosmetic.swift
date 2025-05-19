





import SwiftUI

@MainActor
struct CardCosmetic: View {
    @Environment(\.modelContext) private var modelContext
    @Bindable var cosmetics: Cosmetic
    @EnvironmentObject var listViewModelCosmetic: ListViewModelCosmetic
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var priorityManager: PriorityAnimationManager
    
    @State private var showRatingUpdateAlert = false
    @State private var reviewText: String = ""
    @State private var newRating: String = ""
    @State private var selectedConfiguration: CosmeticConfiguration?
    @State private var textFieldPrice: String = ""
    @State private var errorMessage: String? = nil
    @State private var showDeleteAlert: Bool = false
    @State private var isImagePickerPresented: Bool = false
    @State private var selectedImageData: Data?
    @State private var isEditingReview: Bool = false
    @State private var storeSelection: CurrencyCosmetic = .sephoraAmerica
    @State private var isImageFullScreenPresented = false
    @State private var showDeleteImageAlert = false
    @State private var configurationToDelete: CosmeticConfiguration?
    
    @State private var showCenterHeart = false
    @State private var animateCenterHeart = false
    @State private var showInfoText = false
    @State private var justAdded = false
    
    private let storeFilterOptions = CurrencyCosmetic.allCases
    
    var body: some View {
        ScrollView {
            VStack {
                Text(cosmetics.brand)
                    .font(.headline)
                    .padding(10)
                    .multilineTextAlignment(.center)
                
                Text(cosmetics.title)
                    .font(.subheadline)
                    .padding(10)
                
                ConfigurationPickerView(
                    item: cosmetics,
                    getTitle: { $0.configuration },
                    getImage: { $0.image },
                    setImage: { config, newData in config.image = newData },
                    selectedConfiguration: $selectedConfiguration,
                    selectedImageData: $selectedImageData,
                    isImagePickerPresented: $isImagePickerPresented,
                    isImageFullScreenPresented: $isImageFullScreenPresented,
                    showDeleteAlert: $showDeleteImageAlert,
                    configurationToDelete: $configurationToDelete,
                    errorMessage: $errorMessage
                )
                                
                HStack {
                    Text("Size: \(cosmetics.size)")
                        .font(.subheadline)
                        .fontWeight(.semibold)

                    Spacer()

                    PriorityButtonView(
                        isHasPriority: $cosmetics.isHasPriority,
                        priorityStatus: $cosmetics.priorityStatus,
                        allItems: listViewModelCosmetic.cosmetics,
                        extractPriorityStatus: { $0.priorityStatus },
                        onSave: {
                            try? modelContext.save()
                            listViewModelCosmetic.fetchCosmetics()
                        },
                        onTriggerCenterAnimation: { isAdding, from in
                            priorityManager.trigger(isAdding: isAdding, from: from)
                        }
                    )
                    .frame(width: 44, height: 44)
                }
                .padding(.horizontal)
                
                RatingSectionView(
                    rating: Binding(
                        get: { cosmetics.rating },
                        set: { cosmetics.rating = $0 }
                    ),
                    newRating: $newRating,
                    onSave: {
                        cosmetics.rating = newRating
                        try? modelContext.save()
                        dismissKeyboard()
                        newRating = ""
                    },
                    showRatingUpdateAlert: $showRatingUpdateAlert
                )
                
                PricesSectionCard(
                    prices: $cosmetics.prices,
                    selectedStore: $storeSelection,
                    priceInput: $textFieldPrice,
                    errorMessage: $errorMessage,
                    createPrice: { entered, store in
                        let p = CosmeticPrice(price: store.calculatedPrice(entered), store: store)
                        modelContext.insert(p)
                        try? modelContext.save()
                        return p
                    }
                )
                
                LikedAndReviewSection(
                    isDone: $cosmetics.isBuying,
                    likedStatus: Binding(
                        get: { cosmetics.likedCosmeticStatus ?? "〰️" },
                        set: { cosmetics.likedCosmeticStatus = $0 }
                    ),
                    reviewText: Binding(
                        get: { cosmetics.reviewText ?? "" },
                        set: { cosmetics.reviewText = $0 }
                    ),
                    isEditing: $isEditingReview,
                    onSave: {
                        try? modelContext.save()
                    }
                )
                
            }
        }
        .onAppear {
            selectedConfiguration = cosmetics.configurations.first
            textFieldPrice = ""
        }
        .navigationBarItems(
            trailing: Button(role: .destructive) {
                showDeleteAlert = true
            } label: {
                Image(systemName: "trash")
            }
        )
        .reusableAlert(
            title: "Delete this cosmetic?",
            message: "This action cannot be undone.",
            isPresented: $showDeleteAlert,
            onDestructive: {
                modelContext.delete(cosmetics)
                listViewModelCosmetic.fetchCosmetics()
                dismiss()
            }
        )

    }
    
    private func dismissKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

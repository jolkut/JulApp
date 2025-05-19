





import SwiftUI
import SwiftData

struct CardThing: View {
    
    @Environment(\.modelContext) private var modelContext
    @Bindable var things: Thing
    @EnvironmentObject var listViewModelThing: ListViewModelThing
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var priorityManager: PriorityAnimationManager
    
    @State private var showRatingUpdateAlert = false
    @State private var reviewText: String = ""
    @State private var newRating: String = ""
    @State private var selectedConfiguration: ThingConfiguration?
    @State private var textFieldPrice: String = ""
    @State private var errorMessage: String? = nil
    @State private var showDeleteAlert: Bool = false
    @State private var isImagePickerPresented: Bool = false
    @State private var selectedImageData: Data?
    @State private var isEditingReview: Bool = false
    @State private var storeSelection: CurrencyThing = .amazon
    @State private var isImageFullScreenPresented = false
    @State private var showDeleteImageAlert = false
    @State private var configurationToDelete: ThingConfiguration?
    
    private let storeFilterOptions = CurrencyCosmetic.allCases
    
    var body: some View {
        ScrollView {
            VStack {
                Text(things.brand)
                    .font(.headline)
                    .padding(.top, 10)
                    .multilineTextAlignment(.center)
                
                Text(things.title)
                    .font(.subheadline)
                    .padding(.bottom, 10)
                
                ConfigurationPickerView(
                    item: things,
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
                    
                    Spacer()
                    
                    PriorityButtonView(
                        isHasPriority: $things.isHasPriority,
                        priorityStatus: $things.priorityStatus,
                        allItems: listViewModelThing.things,
                        extractPriorityStatus: { $0.priorityStatus },
                        onSave: {
                            try? modelContext.save()
                            listViewModelThing.fetchThings()
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
                        get: { things.rating },
                        set: { things.rating = $0 }
                    ),
                    newRating: $newRating,
                    onSave: {
                        things.rating = newRating
                        try? modelContext.save()
                        dismissKeyboard()
                        newRating = ""
                    },
                    showRatingUpdateAlert: $showRatingUpdateAlert
                )
                
                PricesSectionCard(
                    prices: $things.prices,
                    selectedStore: $storeSelection,
                    priceInput: $textFieldPrice,
                    errorMessage: $errorMessage,
                    createPrice: { entered, store in
                        let p = ThingPrice(price: store.calculatedPrice(entered), store: store)
                        modelContext.insert(p)
                        try? modelContext.save()
                        return p
                    }
                )
                
                LikedAndReviewSection(
                    isDone: $things.isBuying,
                    likedStatus: Binding(
                        get: { things.likedThingStatus ?? "〰️" },
                        set: { things.likedThingStatus = $0 }
                    ),
                    reviewText: Binding(
                        get: { things.reviewText ?? "" },
                        set: { things.reviewText = $0 }
                    ),
                    isEditing: $isEditingReview,
                    onSave: {
                        try? modelContext.save()
                    }
                )
                
            }
        }
        .onAppear {
            selectedConfiguration = things.configurations.first
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
            title: "Delete this thing?",
            message: "This action cannot be undone.",
            isPresented: $showDeleteAlert,
            onDestructive: {
                modelContext.delete(things)
                listViewModelThing.fetchThings()
                dismiss()
            }
        )

    }
    
    private func dismissKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

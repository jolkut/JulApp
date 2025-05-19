





import SwiftUI

struct CardPerfume: View {

    @Bindable var perfume: Perfume

    @EnvironmentObject var listViewModelPerfume: ListViewModelPerfume
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var priorityManager: PriorityAnimationManager

    @State private var showDeleteAlert: Bool = false
    @State private var newRating: String = ""
    @State private var textFieldPrice: String = ""
    @State private var errorMessage: String? = nil
    @State private var storeSelection: CurrencyPerfume = .sephoraAmerica
    @State private var isEditingReview: Bool = false
    @State private var showRatingUpdateAlert = false

    @State private var isMainImagePickerPresented = false
    @State private var isMainImageFullScreenPresented = false
    @State private var isAccordsImagePickerPresented = false
    @State private var isAccordsImageFullScreenPresented = false
    @State private var isPyramidImagePickerPresented = false
    @State private var isPyramidImageFullScreenPresented = false
    
    var body: some View {
        ScrollView {
            VStack {
                Text(perfume.title)
                    .font(.headline)
                    .padding(.top, 10)
                    .multilineTextAlignment(.center)
                
                Text(perfume.brand)
                    .font(.subheadline)
                    .padding(.bottom, 10)
                
                ImageSectionView(
                    title: "Main Image:",
                    imageData: Binding(
                        get: { perfume.mainImage },
                        set: { perfume.mainImage = $0 }
                    ),
                    isImagePickerPresented: $isMainImagePickerPresented,
                    isImageFullScreenPresented: $isMainImageFullScreenPresented
                )
                
                ImageSectionView(
                    title: "Main Accords:",
                    imageData: Binding(
                        get: { perfume.accordsImage },
                        set: { perfume.accordsImage = $0 }
                    ),
                    isImagePickerPresented: $isAccordsImagePickerPresented,
                    isImageFullScreenPresented: $isAccordsImageFullScreenPresented
                )
                
                ImageSectionView(
                    title: "Pyramid:",
                    imageData: Binding(
                        get: { perfume.pyramidImage },
                        set: { perfume.pyramidImage = $0 }
                    ),
                    isImagePickerPresented: $isPyramidImagePickerPresented,
                    isImageFullScreenPresented: $isPyramidImageFullScreenPresented
                )
                
                HStack {
                    Text("Size: \(perfume.size)")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                    
                    Spacer()
                    
                    PriorityButtonView(
                        isHasPriority: $perfume.isHasPriority,
                        priorityStatus: $perfume.priorityStatus,
                        allItems: listViewModelPerfume.perfumes,
                        extractPriorityStatus: { $0.priorityStatus },
                        onSave: {
                            try? modelContext.save()
                            listViewModelPerfume.fetchPerfumes()
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
                        get: { perfume.rating },
                        set: { perfume.rating = $0 }
                    ),
                    newRating: $newRating,
                    onSave: {
                        perfume.rating = newRating
                        try? modelContext.save()
                        dismissKeyboard()
                        newRating = ""
                    },
                    showRatingUpdateAlert: $showRatingUpdateAlert
                )
                
                PricesSectionCard(
                    prices: $perfume.prices,
                    selectedStore: $storeSelection,
                    priceInput: $textFieldPrice,
                    errorMessage: $errorMessage,
                    createPrice: { entered, store in
                        let p = PerfumePrice(price: store.calculatedPrice(entered), store: store)
                        modelContext.insert(p)
                        try? modelContext.save()
                        return p
                    }
                )
                
                LikedAndReviewSection(
                    isDone: $perfume.isBuying,
                    likedStatus: Binding(
                        get: { perfume.likedPerfumeStatus ?? "〰️" },
                        set: { perfume.likedPerfumeStatus = $0 }
                    ),
                    reviewText: Binding(
                        get: { perfume.reviewText ?? "" },
                        set: { perfume.reviewText = $0 }
                    ),
                    isEditing: $isEditingReview,
                    onSave: {
                        try? modelContext.save()
                    }
                )
                
            }
        }
        .onAppear {
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
            title: "Delete this perfume?",
            message: "This action cannot be undone.",
            isPresented: $showDeleteAlert,
            onDestructive: {
                modelContext.delete(perfume)
                listViewModelPerfume.fetchPerfumes()
                dismiss()
            }
        )
    }
    
    private func dismissKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}







import SwiftUI

struct CardPlace: View {
    
    @Environment(\.modelContext) private var modelContext
    @Bindable var place: Place
    @EnvironmentObject var listViewModelPlace: ListViewModelPlace
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var priorityManager: PriorityAnimationManager

    @State private var newRating: String = ""
    @State private var showDeleteAlert: Bool = false
    @State private var isImagePickerPresented: Bool = false
    @State private var downloadedImage: [Data]
    @State private var isImageFullScreenPresented: Bool = false
    @State private var showRatingUpdateAlert = false
    @State private var isEditingReview: Bool = false

    init(place: Place, downloadedImage: [Data] = []) {
        self._place = Bindable(wrappedValue: place)
        self._downloadedImage = State(initialValue: downloadedImage)
    }
    
    var body: some View {
        ScrollView {
            VStack {
                Text(place.title)
                    .font(.headline)
                    .padding(.top, 10)
                    .multilineTextAlignment(.center)
                
                Text(place.country)
                    .font(.subheadline)
                    .padding(.bottom, 10)
                
                HorizontalImagesGallery(
                    images: $place.images,
                    isImagePickerPresented: $isImagePickerPresented,
                    isImageFullScreenPresented: $isImageFullScreenPresented
                )
                .padding()
                
                HStack {
                    Spacer()

                    PriorityButtonView(
                        isHasPriority: $place.isHasPriority,
                        priorityStatus: $place.priorityStatus,
                        allItems: listViewModelPlace.places,
                        extractPriorityStatus: { $0.priorityStatus },
                        onSave: {
                            try? modelContext.save()
                            listViewModelPlace.fetchPlaces()
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
                        get: { place.rating },
                        set: { place.rating = $0 }
                    ),
                    newRating: $newRating,
                    onSave: {
                        place.rating = newRating
                        try? modelContext.save()
                        dismissKeyboard()
                        newRating = ""
                    },
                    showRatingUpdateAlert: $showRatingUpdateAlert
                )
                
                Text("Description:")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                
                Text(place.descriptionText ?? "No description available.")
                    .font(.body)
                    .padding(.bottom, 10)
                
                LikedAndReviewSection(
                    isDone: $place.isVisited,
                    likedStatus: Binding(
                        get: { place.likedPlaceStatus ?? "〰️" },
                        set: { place.likedPlaceStatus = $0 }
                    ),
                    reviewText: Binding(
                        get: { place.reviewText ?? "" },
                        set: { place.reviewText = $0 }
                    ),
                    isEditing: $isEditingReview,
                    onSave: {
                        try? modelContext.save()
                    }
                )
            }
            .padding()
        }
        .navigationBarItems(
            trailing: Button(role: .destructive) {
                showDeleteAlert = true
            } label: {
                Image(systemName: "trash")
            }
        )
        .reusableAlert(
            title: "Delete this place?",
            message: "This action cannot be undone.",
            isPresented: $showDeleteAlert,
            onDestructive: {
                modelContext.delete(place)
                listViewModelPlace.fetchPlaces()
                dismiss()
            }
        )
    }

    private func nextPriorityStatus() -> PriorityStatus? {
        let used = listViewModelPlace.places
            .compactMap { $0.priorityStatus }
            .compactMap(PriorityStatus.init)
        return PriorityStatus.allCases.first { !used.contains($0) }
    }
    
    private func dismissKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

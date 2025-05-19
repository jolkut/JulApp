





import SwiftUI

struct ListViewPlace: View {
    @Environment(\.modelContext) private var modelContext
    @EnvironmentObject var listViewModelPlace: ListViewModelPlace

    @State private var mainSelection = "All"
    @State private var categorySelection: PlaceCategory = .allCategories
    @State private var justSortSelection = "A...Z"
    @State private var searchText = ""

    @State private var filteredBaseItems: [Place] = []

    private let mainFilterOptions = ["All", "Not Visit", "Visit"]
    private let justSortOptions = ["A...Z", "Rating Low...High", "Rating High...Low"]

    private var filteredItems: [Place] {
        FilteredAndSortedItems(
            items: filteredBaseItems,
            filterOption: mainSelection,
            sortOption: justSortSelection,
            isDone: { $0.isVisited },
            getTitle: { $0.title },
            getRating: { $0.rating },
            filterValueUndone: "Not Visit",
            filterValueDone: "Visit"
        ).result()
    }
    
    var body: some View {
        List {
            Section {
                
                CategoryFilterView<PlaceCategory, Place>(
                    selectedCategory: $categorySelection,
                    allItems: listViewModelPlace.places,
                    extractCategory: { PlaceCategory(rawValue: $0.category) },
                    onFiltered: { filteredBaseItems = $0 }
                )

                SortPicker(
                    selection: $justSortSelection,
                    sortOptions: justSortOptions)

                SegmentedFilterPicker(
                    selection: $mainSelection,
                    options: mainFilterOptions,
                    label: ""
                )
            }

            ForEach(filteredItems) { place in
                NavigationLink(destination: CardPlace(place: place, downloadedImage: [])) {
                    RowViewPlace(place: place)
                }
            }
        }
        .searchable(text: $searchText, prompt: "Search by title or country")
        .onChange(of: searchText) { _ in
            filteredBaseItems = listViewModelPlace.places.filter {
                searchText.isEmpty ||
                $0.title.localizedCaseInsensitiveContains(searchText) ||
                $0.country.localizedCaseInsensitiveContains(searchText)
            }
        }
        .listStyle(PlainListStyle())
        .onAppear {
            filteredBaseItems = listViewModelPlace.places
        }
        .navigationTitle("Places 🌍")
        .navigationBarTitleDisplayMode(.automatic)
        .navigationBarItems(
            leading: NavigationLink(destination: FirstPriorityPlace()) {
                Image(systemName: "heart.fill")
            },
            trailing: NavigationLink("Add", destination: AddViewPlace())
        )
    }
}

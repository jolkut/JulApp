





import SwiftUI

struct ListViewThing: View {
    @Environment(\.modelContext) private var modelContext
    @EnvironmentObject var listViewModelThing: ListViewModelThing

    @State private var mainSelection = "All"
    @State private var categorySelection: ThingCategory = .allCategories
    @State private var justSortSelection = "A...Z"
    @State private var searchText = ""

    @State private var baseFilteredByCategory: [Thing] = []
    @State private var filteredBaseItems: [Thing] = []

    private let mainFilterOptions = ["All", "Wish", "Bought"]
    private let justSortOptions = ["A...Z", "Rating Low...High", "Rating High...Low"]

    private var filteredItems: [Thing] {
        FilteredAndSortedItems(
            items: filteredBaseItems,
            filterOption: mainSelection,
            sortOption: justSortSelection,
            isDone: { $0.isBuying },
            getTitle: { $0.title },
            getRating: { $0.rating }
        ).result()
    }

    var body: some View {
        List {
            Section {
                CategoryFilterView<ThingCategory, Thing>(
                    selectedCategory: $categorySelection,
                    allItems: listViewModelThing.things,
                    extractCategory: { ThingCategory(rawValue: $0.category) },
                    onFiltered: { baseFilteredByCategory = $0 }
                )

                SortPicker(
                    selection: $justSortSelection,
                    sortOptions: justSortOptions
                )

                SegmentedFilterPicker(
                    selection: $mainSelection,
                    options: mainFilterOptions,
                    label: ""
                )
            }

            ForEach(filteredItems) { item in
                NavigationLink(destination: CardThing(things: item)) {
                    RowViewThing(things: item)
                }
            }
        }
        .searchable(text: $searchText, prompt: "Search by title or brand")
        .onChange(of: searchText) { _ in
            filteredBaseItems = baseFilteredByCategory.filter {
                searchText.isEmpty ||
                ($0.title ?? "").localizedCaseInsensitiveContains(searchText) ||
                ($0.brand ?? "").localizedCaseInsensitiveContains(searchText)
            }
        }
        .listStyle(PlainListStyle())
        .onAppear {
            baseFilteredByCategory = listViewModelThing.things
            filteredBaseItems = listViewModelThing.things
        }
        .navigationTitle("Things ✨")
        .navigationBarTitleDisplayMode(.automatic)
        .navigationBarItems(
            leading: NavigationLink(destination: FirstPriorityThing()) {
                Image(systemName: "heart.fill")
            },
            trailing: NavigationLink("Add", destination: AddViewThing())
        )
    }
}

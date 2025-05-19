 





import SwiftUI

struct ListViewCosmetic: View {
    @Environment(\.modelContext) private var modelContext
    @EnvironmentObject var listViewModelCosmetic: ListViewModelCosmetic

    @State private var mainSelection = "All"
    @State private var categorySelection: CosmeticCategory = .allCategories
    @State private var justSortSelection = "A...Z"
    @State private var searchText = ""

    @State private var baseFilteredByCategory: [Cosmetic] = []
    @State private var filteredBaseItems: [Cosmetic] = []

    private let mainFilterOptions = ["All", "Wish", "Bought"]
    private let justSortOptions = ["A...Z", "Rating Low...High", "Rating High...Low"]

    private var filteredItems: [Cosmetic] {
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
                CategoryFilterView<CosmeticCategory, Cosmetic>(
                    selectedCategory: $categorySelection,
                    allItems: listViewModelCosmetic.cosmetics,
                    extractCategory: { CosmeticCategory(rawValue: $0.category) },
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
                NavigationLink(destination: CardCosmetic(cosmetics: item)) {
                    RowViewCosmetic(cosmetics: item)
                }
            }
        }
        .searchable(text: $searchText, prompt: "Search by title or brand")
        .onChange(of: searchText) { _ in
            filteredBaseItems = baseFilteredByCategory.filter {
                searchText.isEmpty ||
                $0.title.localizedCaseInsensitiveContains(searchText) ||
                $0.brand.localizedCaseInsensitiveContains(searchText)
            }
        }
        .listStyle(PlainListStyle())
        .onAppear {
            baseFilteredByCategory = listViewModelCosmetic.cosmetics
            filteredBaseItems = listViewModelCosmetic.cosmetics
        }
        .navigationTitle("Cosmetics ✨")
        .navigationBarTitleDisplayMode(.automatic)
        .navigationBarItems(
            leading: NavigationLink(destination: FirstPriorityCosmetic()) {
                Image(systemName: "heart.fill")
            },
            trailing: NavigationLink("Add", destination: AddViewCosmetic(categorySelection: $categorySelection))
        )
    }
}

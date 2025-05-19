





import SwiftUI

struct ListViewPerfume: View {
    @Environment(\.modelContext) private var modelContext
    @EnvironmentObject var listViewModelPerfume: ListViewModelPerfume

    @State private var mainSelection = "All"
    @State private var justSortSelection = "A...Z"
    @State private var searchText = ""

    @State private var filteredBaseItems: [Perfume] = []

    private let mainFilterOptions = ["All", "Wish", "Bought"]
    private let justSortOptions = ["A...Z", "Rating Low...High", "Rating High...Low"]

    private var filteredItems: [Perfume] {
        FilteredAndSortedItems(
            items: filteredBaseItems,
            filterOption: mainSelection,
            sortOption: justSortSelection,
            isDone: { $0.isBuying },
            getTitle: { $0.title },
            getRating: { $0.rating },
            filterValueUndone: "Wish",
            filterValueDone: "Bought" 
        ).result()
    }
    var body: some View {
        List {
            Section {
                SortPicker(selection: $justSortSelection, sortOptions: justSortOptions)

                SegmentedFilterPicker(
                    selection: $mainSelection,
                    options: mainFilterOptions,
                    label: ""
                )
            }

            ForEach(filteredItems) { item in
                NavigationLink(destination: CardPerfume(perfume: item)) {
                    RowViewPerfume(perfume: item)
                }
            }
        }
        .searchable(text: $searchText, prompt: "Search by title or brand")
        .onChange(of: searchText) { newValue in
            filteredBaseItems = listViewModelPerfume.perfumes.filter {
                newValue.isEmpty ||
                $0.title.localizedCaseInsensitiveContains(newValue) ||
                $0.brand.localizedCaseInsensitiveContains(newValue)
            }
        }
        .listStyle(PlainListStyle())
        .onAppear {
            filteredBaseItems = listViewModelPerfume.perfumes
        }
        .navigationTitle("Perfumes ✨")
        .navigationBarTitleDisplayMode(.automatic)
        .navigationBarItems(
            leading: NavigationLink(destination: FirstPriorityPerfume()) {
                Image(systemName: "heart.fill")
            },
            trailing: NavigationLink("Add", destination: AddViewPerfume())
        )
    }
}

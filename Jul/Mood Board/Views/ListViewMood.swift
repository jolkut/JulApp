





import SwiftUI
import SwiftData

struct ListViewMood: View {
    @Environment(\.modelContext) private var modelContext
    @EnvironmentObject var listViewModelMood: ListViewModelMood

    @State private var mainSelection = "All"
    @State private var categorySelection: MoodCategory = .allCategories
    @State private var searchText = ""

    @State private var baseFilteredByCategory: [Mood] = []
    @State private var filteredBaseItems: [Mood] = []

    private var filteredItems: [Mood] {
        baseFilteredByCategory.filter {
            searchText.isEmpty ||
            $0.title.localizedCaseInsensitiveContains(searchText)
        }
    }

    let columns = [
        GridItem(.flexible(), spacing: 5),
        GridItem(.flexible(), spacing: 5),
        GridItem(.flexible(), spacing: 5)
    ]

    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                CategoryFilterView<MoodCategory, Mood>(
                    selectedCategory: $categorySelection,
                    allItems: listViewModelMood.moods,
                    extractCategory: { MoodCategory(rawValue: $0.category) },
                    onFiltered: { baseFilteredByCategory = $0 }
                )

                LazyVGrid(columns: columns, spacing: 5) {
                    ForEach(filteredItems) { item in
                        NavigationLink(destination: CardMood(mood: item)) {
                            RowViewMood(item: item)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                }
                .padding(8)
            }
        }
        .searchable(text: $searchText, prompt: "Search by title")
        .listStyle(PlainListStyle())
        .onAppear {
            baseFilteredByCategory = listViewModelMood.moods
            filteredBaseItems = listViewModelMood.moods
        }
        .navigationTitle("Moods 🌟")
        .navigationBarTitleDisplayMode(.automatic)
        .navigationBarItems(
            trailing: NavigationLink(destination: AddViewMood()) {
                Text("Add")
                    .font(.headline)
            }
        )
    }
}

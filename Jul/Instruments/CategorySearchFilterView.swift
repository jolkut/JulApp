





import SwiftUI

struct CategoryFilterView<Category: Hashable & RawRepresentable & CaseIterable, Item: Identifiable>: View where Category.RawValue == String {
    
    @Binding var selectedCategory: Category
    let allItems: [Item]
    let extractCategory: (Item) -> Category?
    let onFiltered: ([Item]) -> Void

    var body: some View {
        Picker("Category:", selection: $selectedCategory) {
            ForEach(categoryOptions, id: \.self) { category in
                Text(category.rawValue).tag(category)
            }
        }
        .pickerStyle(MenuPickerStyle())
        .onChange(of: selectedCategory) { _ in filterItems() }
        .onAppear { filterItems() }
    }

    private var categoryOptions: [Category] {
        var result: [Category] = [Category.allCases.first!]
        let unique = Set(allItems.compactMap { extractCategory($0) })
        result.append(contentsOf: unique.filter { $0 != Category.allCases.first! })
        return result.sorted { $0.rawValue < $1.rawValue }
    }

    private func filterItems() {
        let filtered = allItems.filter { item in
            selectedCategory == Category.allCases.first! || extractCategory(item) == selectedCategory
        }
        onFiltered(filtered)
    }
}

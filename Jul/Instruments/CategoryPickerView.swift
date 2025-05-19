





import SwiftUI

struct CategoryPickerView<Category: RawRepresentable & CaseIterable & Hashable>: View
where Category.RawValue == String {
    let title: String
    @Binding var selection: Category
    let allOptions: [Category]
    
    init(
        title: String = "Category:",
        selection: Binding<Category>,
        allOptions: [Category]
    ) {
        self.title = title
        self._selection = selection
        self.allOptions = allOptions
    }
    
    var body: some View {
        HStack {
            Text(title)
                .font(.headline)
            Picker(title, selection: $selection) {
                ForEach(allOptions, id: \.self) { option in
                    Text(option.rawValue).tag(option)
                }
            }
            .pickerStyle(MenuPickerStyle())
        }
        .padding(.horizontal)
    }
}

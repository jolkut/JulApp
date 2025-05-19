





import SwiftUI

struct SortPicker: View {
    @Binding var selection: String
    let sortOptions: [String]

    var body: some View {
        Picker("Sort by:", selection: $selection) {
            ForEach(sortOptions, id: \.self) { option in
                Text(option).tag(option)
            }
        }
        .pickerStyle(MenuPickerStyle())
    }
}

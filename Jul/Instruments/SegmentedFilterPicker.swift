





import SwiftUI

struct SegmentedFilterPicker: View {
    @Binding var selection: String
    let options: [String]
    let label: String?

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            if let label = label {
                Text(label)
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }

            Picker("", selection: $selection) {
                ForEach(options, id: \.self) { option in
                    Text(option).tag(option)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
        }
    }
}

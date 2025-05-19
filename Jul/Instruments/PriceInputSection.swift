





import SwiftUI

struct PriceInputSection<PriceType: PriceProtocol, StoreType: CurrencyProtocol>: View
where StoreType.AllCases: RandomAccessCollection {

    @Binding var selectedStore: StoreType
    @Binding var priceInput: String
    @Binding var prices: [PriceType]
    @Binding var errorMessage: String?

    @State private var priceToDelete: PriceType?
    @State private var showDeletePriceAlert = false

    let createPrice: (Double, StoreType) -> PriceType

    var body: some View {
        VStack(spacing: 16) {
            Text("Price:")
                .font(.headline)

            HStack {
                Picker("Store", selection: $selectedStore) {
                    ForEach(StoreType.allCases, id: \.self) { store in
                        Text(store.title).tag(store)
                    }
                }
                .pickerStyle(MenuPickerStyle())

                CustomTextField(
                    numericTitle: "",
                    placeholder: "Enter price…",
                    text: $priceInput
                )

                PrimaryActionButton(action: addPrice, title: "Add")
            }

            ForEach(prices, id: \.id) { price in
                ZStack(alignment: .topTrailing) {
                    VStack(alignment: .leading, spacing: 5) {
                        Text("Store: \(price.store?.title ?? "Unknown")")
                        Text(String(format: "Price: %.2f$", price.price))
                    }
                    .font(.subheadline)
                    .padding()
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(8)
                    .padding(.trailing, 25)

                    Button {
                        priceToDelete = price
                        showDeletePriceAlert = true
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(.gray)
                            .background(Color.white.opacity(0.7), in: Circle())
                    }
                    .offset(x: 10, y: -10)
                }
            }

        }
        .alert("Delete this price?", isPresented: $showDeletePriceAlert) {
            Button("Delete", role: .destructive) {
                if let target = priceToDelete,
                   let idx = prices.firstIndex(of: target) {
                    prices.remove(at: idx)
                }
                priceToDelete = nil
            }
            Button("Cancel", role: .cancel) {
                priceToDelete = nil
            }
        } message: {
            Text("This will remove the selected price.")
        }
    }

    private func addPrice() {
        guard let enteredPrice = Double(priceInput) else {
            errorMessage = "Invalid price entered."
            return
        }
        let newPrice = createPrice(enteredPrice, selectedStore)
        prices.append(newPrice)
        priceInput = ""
        errorMessage = nil
    }
}







import SwiftUI

struct PricesSectionCard<PriceType: PriceProtocol, StoreType: CurrencyProtocol, RowContent: View>: View
where StoreType.AllCases: RandomAccessCollection {

    @Binding var prices: [PriceType]
    @Binding var selectedStore: StoreType
    @Binding var priceInput: String
    @Binding var errorMessage: String?

    let createPrice: (Double, StoreType) -> PriceType
    let priceRow: (PriceType) -> RowContent

    @State private var priceToDelete: PriceType?
    @State private var showDeletePriceAlert = false

    var body: some View {
        VStack(spacing: 16) {
            Text("Prices:")
                .font(.headline)
                .padding(10)

            if prices.isEmpty {
                Text("There are no prices.")
                    .italic()
                    .foregroundColor(.secondary)
                    .padding(10)
            } else {
                VStack(spacing: 8) {
                    ForEach(prices, id: \.id) { price in
                        ZStack {
                            VStack {
                                ZStack(alignment: .topTrailing) {
                                    priceRow(price)
                                        .padding(10)
                                        .background(Color.gray.opacity(0.05))
                                        .cornerRadius(8)

                                    Button {
                                        priceToDelete = price
                                        showDeletePriceAlert = true
                                    } label: {
                                        Image(systemName: "xmark.circle.fill")
                                            .foregroundColor(.gray)
                                            .background(Color.white.opacity(0.8), in: Circle())
                                    }
                                    .offset(x: 8, y: -8)
                                }
                            }
                            .frame(maxWidth: 240)
                        }
                        .frame(maxWidth: .infinity, alignment: .center)
                    }
                }
                .padding(10)
            }

            Text("Add New Price:")
                .font(.headline)
                .padding(.vertical, 8)

            HStack(spacing: 12) {
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
            .padding(10)

            
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
            Text("This will permanently delete the selected price.")
        }
    }

    private func addPrice() {
        guard let value = Double(priceInput) else {
            errorMessage = "Invalid price entered."
            return
        }
        let price = createPrice(value, selectedStore)
        prices.append(price)
        priceInput = ""
        errorMessage = nil
    }
}

extension PricesSectionCard where RowContent == AnyView {
    init(
        prices: Binding<[PriceType]>,
        selectedStore: Binding<StoreType>,
        priceInput: Binding<String>,
        errorMessage: Binding<String?>,
        createPrice: @escaping (Double, StoreType) -> PriceType
    ) {
        self._prices = prices
        self._selectedStore = selectedStore
        self._priceInput = priceInput
        self._errorMessage = errorMessage
        self.createPrice = createPrice

        self.priceRow = { price in
            AnyView(
                HStack {
                    VStack(alignment: .leading, spacing: 4) {
                        Text(price.store?.title ?? "Unknown Store")
                            .font(.subheadline)
                            .fontWeight(.semibold)

                        Text(String(format: "$ %.2f", price.price))
                            .font(.subheadline)
                            .foregroundColor(.blue)
                    }
                    Spacer()
                }
            )
        }
    }
}

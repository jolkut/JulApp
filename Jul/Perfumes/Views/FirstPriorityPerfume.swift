





import SwiftUI

struct FirstPriorityPerfume: View {

        @Environment(\.modelContext) private var modelContext
        @EnvironmentObject var listViewModelPerfume: ListViewModelPerfume

        @State private var reorderedItems: [Perfume] = []

        var body: some View {
            List {
                ForEach(reorderedItems, id: \.id) { item in
                    NavigationLink(destination: CardPerfume(perfume: item)) {
                        RowViewPerfume(perfume: item)
                    }
                }
                .onMove(perform: moveItem)
            }
            .navigationTitle("Priority List")
            .toolbar {
                EditButton()
            }
            .onAppear {
                reorderedItems = priorityItems
            }
        }

    private var priorityItems: [Perfume] {
        listViewModelPerfume.perfumes
                .filter { $0.isHasPriority == true }
                .sorted(by: prioritySort)
        }

    private func prioritySort(lhs: Perfume, rhs: Perfume) -> Bool {
            let all = PriorityStatus.allCases.map { $0.rawValue }
            return (all.firstIndex(of: lhs.priorityStatus ?? "") ?? .max) <
                   (all.firstIndex(of: rhs.priorityStatus ?? "") ?? .max)
        }

        private func moveItem(from source: IndexSet, to destination: Int) {
            reorderedItems.move(fromOffsets: source, toOffset: destination)

            for (index, item) in reorderedItems.enumerated() {
                if index < PriorityStatus.allCases.count {
                    item.priorityStatus = PriorityStatus.allCases[index].rawValue
                } else {
                    item.priorityStatus = nil 
                }
            }

            try? modelContext.save()
        }
    }

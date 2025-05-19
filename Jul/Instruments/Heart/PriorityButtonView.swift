





import SwiftUI

struct PriorityButtonView<Model: Identifiable>: View {
    @EnvironmentObject var animationManager: PriorityAnimationManager

    var isHasPriority: Binding<Bool?>
    var priorityStatus: Binding<String?>
    var allItems: [Model]
    var extractPriorityStatus: (Model) -> String?
    var onSave: () -> Void
    var onTriggerCenterAnimation: (_ isAdding: Bool, _ from: CGRect) -> Void

    @State private var frame: CGRect = .zero

    var body: some View {
        GeometryReader { geo in
            Button {
                let willAdd = !(isHasPriority.wrappedValue ?? false)
                frame = geo.frame(in: .global)
                onTriggerCenterAnimation(willAdd, frame)

                if willAdd {
                    isHasPriority.wrappedValue = true
                    priorityStatus.wrappedValue = getNextPriorityStatus()
                } else {
                    isHasPriority.wrappedValue = false
                    priorityStatus.wrappedValue = nil
                }

                onSave()
            } label: {
                HeartShape()
                    .fill(animationManager.currentColor)
                    .overlay(
                        HeartShape()
                            .stroke(Color.black, lineWidth: 2)
                    )
                    .frame(width: 40, height: 40)
                    .animation(.easeInOut(duration: 0.8), value: animationManager.currentColor) 
            }
            .buttonStyle(.plain)
        }
        .frame(width: 44, height: 44)
    }

    private func getNextPriorityStatus() -> String? {
        let used = allItems.compactMap { extractPriorityStatus($0) }
        return PriorityStatus.allCases.first { !used.contains($0.rawValue) }?.rawValue
    }
}

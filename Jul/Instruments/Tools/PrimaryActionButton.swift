





import SwiftUI

struct PrimaryActionButton: View {
    
    let action: () -> Void
    let title: String
    var width: CGFloat = 70
    var height: CGFloat = 40
    var backgroundColor: Color = .blue
    var foregroundColor: Color = .white

    var body: some View {
        Button(action: action) {
            Text(title)
                .fontWeight(.bold)
                .frame(width: width, height: height)
                .background(Color("SoftClay"))
                .foregroundColor(Color("DeepAsh"))
                .cornerRadius(8)
        }
    }
}

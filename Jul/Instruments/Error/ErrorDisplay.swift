





import SwiftUI

struct ErrorDisplay: View {
    let error: AppError?

    var body: some View {
        if let error = error {
            ErrorBanner(message: error.message)
                .padding(.top)
        }
    }
}

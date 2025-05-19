





import SwiftUI

struct SplashDrop: View {
    let angle: Double
    var progress: CGFloat
    var color: Color

    private let maxDistance: CGFloat = 140
    private let maxWidth: CGFloat = 18
    private let maxHeight: CGFloat = 40

    var body: some View {
        GeometryReader { geo in
            let center = CGPoint(x: geo.size.width / 2, y: geo.size.height / 2)
            let angleRad = CGFloat(angle) * .pi / 180
            let distance = maxDistance * progress

            let offset = CGSize(
                width: cos(angleRad) * distance,
                height: sin(angleRad) * distance
            )

            TeardropShape()
                .fill(color)
                .overlay(
                    TeardropShape()
                        .stroke(Color.black, lineWidth: max(0.1, 1.5 * progress))
                )
                .frame(width: max(0.1, maxWidth * progress),
                       height: max(0.1, maxHeight * progress))
                .position(center)
                .rotationEffect(.degrees(angle + 270))
                .offset(offset)
                .animation(.easeOut(duration: 0.6), value: progress)
        }
        .frame(width: 1, height: 1)
    }
}

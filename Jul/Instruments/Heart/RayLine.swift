





import SwiftUI

struct RayLine: View {
    let angle: Double
    var progress: CGFloat

    private let maxStart: CGFloat = 90
    private let maxEnd: CGFloat = 130

    var body: some View {
        GeometryReader { geo in
            let center = CGPoint(x: geo.size.width / 2, y: geo.size.height / 2)
            let angleRad = CGFloat(angle) * .pi / 180
            let startDistance = maxStart * progress
            let endDistance = maxEnd * progress

            let start = CGPoint(
                x: center.x + cos(angleRad) * startDistance,
                y: center.y + sin(angleRad) * startDistance
            )
            let end = CGPoint(
                x: center.x + cos(angleRad) * endDistance,
                y: center.y + sin(angleRad) * endDistance
            )

            Path { path in
                path.move(to: start)
                path.addLine(to: end)
            }
            .stroke(Color.black, style: StrokeStyle(lineWidth: max(0.1, 5 * progress), lineCap: .round))
            .animation(.easeOut(duration: 0.6), value: progress) 
        }
        .frame(width: 1, height: 1)
    }
}

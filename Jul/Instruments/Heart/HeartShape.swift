





import SwiftUI

struct HeartShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()

        let width = rect.width
        let height = rect.height

        path.move(to: CGPoint(x: width / 2, y: height))
        path.addCurve(to: CGPoint(x: 0, y: height / 4),
                      control1: CGPoint(x: width / 2, y: height * 3 / 4),
                      control2: CGPoint(x: 0, y: height / 2.5))

        path.addArc(center: CGPoint(x: width / 4, y: height / 4),
                    radius: width / 4,
                    startAngle: .degrees(180),
                    endAngle: .degrees(0),
                    clockwise: false)

        path.addArc(center: CGPoint(x: width * 3 / 4, y: height / 4),
                    radius: width / 4,
                    startAngle: .degrees(180),
                    endAngle: .degrees(0),
                    clockwise: false)

        path.addCurve(to: CGPoint(x: width / 2, y: height),
                      control1: CGPoint(x: width, y: height / 2.5),
                      control2: CGPoint(x: width / 2, y: height * 3 / 4))

        return path
    }
}

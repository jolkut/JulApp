





import SwiftUI

struct TeardropShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()

        let width = rect.width
        let height = rect.height

        let topOffset: CGFloat = height * 0.01

        path.move(to: CGPoint(x: width / 2, y: topOffset))

        path.addQuadCurve(to: CGPoint(x: 0, y: height),
                          control: CGPoint(x: -width * 0.5, y: height * 0.6))

        path.addQuadCurve(to: CGPoint(x: width, y: height),
                          control: CGPoint(x: width / 2, y: height * 1.3))

        path.addQuadCurve(to: CGPoint(x: width / 2, y: topOffset),
                          control: CGPoint(x: width * 1.5, y: height * 0.6))

        return path
    }
}

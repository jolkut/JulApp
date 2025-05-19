





import SwiftUI

struct PriorityHeartOverlay: View {
    @EnvironmentObject var animationManager: PriorityAnimationManager
    
    @State private var heartPosition: CGPoint = .zero
    @State private var heartScale: CGFloat = 1.0
    @State private var splashProgress: CGFloat = 0.0
    
    private let splashCount = 10
    
    var body: some View {
        GeometryReader { geo in
            if animationManager.showHeart {
                ZStack {
                    Color.clear
                    
                    ForEach(0..<splashCount) { i in
                        let dropAngle = Double(i) * (360.0 / Double(splashCount))
                        SplashDrop(
                            angle: dropAngle,
                            progress: splashProgress,
                            color: animationManager.currentColor
                        )
                        let rayAngle = dropAngle + 360.0 / Double(splashCount * 2)
                        RayLine(angle: rayAngle, progress: splashProgress)
                    }
                    
                    HeartShape()
                        .fill(animationManager.currentColor)
                        .overlay(HeartShape().stroke(Color.black, lineWidth: 2))
                        .frame(width: 40, height: 40)
                        .scaleEffect(heartScale)
                        .position(heartPosition)
                        .animation(.easeInOut(duration: 0.8), value: animationManager.currentColor)
                        .onAppear {
                            animateHeart(in: geo)
                        }
                }
                .frame(width: geo.size.width, height: geo.size.height)
            }
        }
    }
    
    private func animateHeart(in geo: GeometryProxy) {
        let origin = animationManager.origin
        let start = CGPoint(x: origin.midX, y: origin.midY)
        let end = CGPoint(x: geo.size.width / 2, y: geo.size.height / 2)
        
        heartPosition = start
        heartScale = 1.0
        splashProgress = 0.0
        
        withAnimation(.easeInOut(duration: 0.5)) {
            heartPosition = end
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            withAnimation(.easeOut(duration: 1.0)) {
                heartScale = 3.3
                splashProgress = 1.0
                animationManager.currentColor = animationManager.isAdding ? Color("BlushPink") : .white
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
                withAnimation(.spring(response: 0.6, dampingFraction: 0.7)) {
                    heartScale = 0.5
                    splashProgress = 0.0
                }

                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                    withAnimation(.easeOut(duration: 0.4)) {
                        heartScale = 0.1
                    }
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                        animationManager.reset()
                    }
                }
            }
        }
    }
}

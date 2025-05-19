





import SwiftUI

class MoodCardViewModel: ObservableObject {
    @Published var moods: [Mood] = []
    
    func addMood(mood: Mood) {
        moods.append(mood)
    }
}

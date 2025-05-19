




import SwiftUI
import SwiftData

@main
struct JulApp: App {
    
    @StateObject var listViewModelCosmetic = ListViewModelCosmetic()
    @StateObject var listViewModelThing = ListViewModelThing()
    @StateObject var listViewModelPerfume = ListViewModelPerfume()
    @StateObject var listViewModelPlace = ListViewModelPlace()
    @StateObject var listViewModelMood = ListViewModelMood()
    
    @StateObject var cosmeticsCardViewModel = CosmeticsCardViewModel()
    @StateObject var perfumeCardViewModel = PerfumeCardViewModel()
    @StateObject var thingCardViewModel = ThingCardViewModel()
    @StateObject var placeCardViewModel = PlaceCardViewModel()
    @StateObject var moodCardViewModel = MoodCardViewModel()
    
    @StateObject var priorityAnimationManager = PriorityAnimationManager()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(listViewModelCosmetic)
                .environmentObject(listViewModelThing)
                .environmentObject(listViewModelPerfume)
                .environmentObject(listViewModelPlace)
                .environmentObject(listViewModelMood)

                .environmentObject(cosmeticsCardViewModel)
                .environmentObject(perfumeCardViewModel)
                .environmentObject(thingCardViewModel)
                .environmentObject(placeCardViewModel)
                .environmentObject(moodCardViewModel)

                .environmentObject(priorityAnimationManager)

                .modelContainer(for: [
                    Cosmetic.self,
                    CosmeticPrice.self,
                    CosmeticConfiguration.self,
                    StoreCosmetic.self,
                    Mood.self,
                    Perfume.self,
                    PerfumePrice.self,
                    StorePerfume.self,
                    Place.self,
                    StoreThing.self,
                    Thing.self,
                    ThingConfiguration.self,
                    ThingPrice.self
                ])
        }
    }
}

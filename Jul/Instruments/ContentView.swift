





import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @EnvironmentObject var listViewModelCosmetic: ListViewModelCosmetic
    @EnvironmentObject var listViewModelMood: ListViewModelMood
    @EnvironmentObject var listViewModelPerfume: ListViewModelPerfume
    @EnvironmentObject var listViewModelPlace: ListViewModelPlace
    @EnvironmentObject var listViewModelThing: ListViewModelThing

    var body: some View {
        TabView {
            NavigationView {
                ListViewCosmetic()
                    .navigationTitle("Cosmetics")
            }
            .tabItem {
                Label("Cosmetics", systemImage: "heart")
            }

            NavigationView {
                ListViewMood()
                    .navigationTitle("Mood")
            }
            .tabItem {
                Label("Mood", systemImage: "clipboard")
            }

            NavigationView {
                ListViewPerfume()
                    .navigationTitle("Perfumes")
            }
            .tabItem {
                Label("Perfumes", systemImage: "waterbottle")
            }

            NavigationView {
                ListViewPlace()
                    .navigationTitle("Places")
            }
            .tabItem {
                Label("Places", systemImage: "map")
            }

            NavigationView {
                ListViewThing()
                    .navigationTitle("Things")
            }
            .tabItem {
                Label("Things", systemImage: "bag")
            }
        }
        .onAppear {
            listViewModelCosmetic.setContext(modelContext)
            listViewModelMood.setContext(modelContext)
            listViewModelPerfume.setContext(modelContext)
            listViewModelPlace.setContext(modelContext)
            listViewModelThing.setContext(modelContext)
        }
        .overlay {
            PriorityHeartOverlay()
        }
    }
}

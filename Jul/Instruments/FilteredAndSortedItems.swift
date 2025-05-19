





import SwiftUI

struct FilteredAndSortedItems<Item> {
    let items: [Item]
    let filterOption: String
    let sortOption: String

    let isDone: (Item) -> Bool
    let getTitle: (Item) -> String
    let getRating: (Item) -> String

    var filterValueUndone: String = "Wish"
    var filterValueDone: String = "Get"

    func result() -> [Item] {
        var filtered = items

        switch filterOption {
        case filterValueUndone:
            filtered = filtered.filter { !isDone($0) }
        case filterValueDone:
            filtered = filtered.filter { isDone($0) }
        default:
            break
        }

        switch sortOption {
        case "A...Z":
            filtered.sort { getTitle($0) < getTitle($1) }
        case "Rating Low...High":
            filtered.sort { (Double(getRating($0)) ?? 0) < (Double(getRating($1)) ?? 0) }
        case "Rating High...Low":
            filtered.sort { (Double(getRating($0)) ?? 0) > (Double(getRating($1)) ?? 0) }
        default:
            break
        }

        return filtered
    }
}

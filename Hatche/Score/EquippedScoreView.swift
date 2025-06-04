import SwiftUI
import CoreData

struct EquippedScoreView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @Binding public var hatch: Hatch?

    // Fetch only equipped items, sorted by name (optional)
    @FetchRequest(
        entity: Equipment.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \Equipment.name, ascending: true)],
        predicate: NSPredicate(format: "equipped == YES")
    ) private var equippedItems: FetchedResults<Equipment>

    // Computed property to sum scores reactively
    private var totalScore: Int {
        equippedItems.reduce(0) { partialResult, equipment in
            if equipment.equipmentHatch == hatch {
                return partialResult + Int(equipment.score)
            } else {
                return partialResult
            }
        }
    }

    var body: some View {
        VStack {
            Text("Total Equipped Score: \(totalScore)")
                .font(.title)
                .padding()
        }
    }
}

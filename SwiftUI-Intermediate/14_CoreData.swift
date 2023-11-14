//
//  14_CoreData.swift
//  SwiftUI-Intermediate
//
//  Created by Vuk Knezevic on 13.11.23.
//

import SwiftUI
import CoreData

// MARK: - Na simulatoru radi, ali ovde nisam uspeo da ga nateram da dodaje nove redove

struct CoreDataBootcamp: View {
    @Environment(\.managedObjectContext) private var viewContext

    // MARK: - Ovo se ponasa kao publisher, ne mora da se poziva request funkcija kao sto je slucaj kod klasicnog NSFetchRequest-a
    @FetchRequest(
        entity: FruitEntity.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \FruitEntity.name, ascending: true)]
    ) private var fruits: FetchedResults<FruitEntity>

    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(fruits) { fruit in
                        NavigationLink {
                            Text("Item at \(fruit)")
                        } label: {
                            Text(fruit.name ?? "N/A")
                        }
                    }
                    .onDelete(perform: deleteItems)
                }
                .listStyle(.plain)
                .navigationTitle("Core Data")
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        EditButton()
                    }
                    ToolbarItem {
                        addButton
                    }
                }
                
                Text("Select an item")
                
            }
            
            
            
        }
    }
    
    private var addButton: some View {
        Button(action: addItem) {
            Label("Add Item", systemImage: "plus")
        }
    }

    private func addItem() {
        withAnimation {
            let newFruit = FruitEntity(context: viewContext)
            newFruit.name = "Vuk ----- \(Date())"

            saveItems()
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { fruits[$0] }.forEach(viewContext.delete)
            saveItems()
        }
    }
    
    private func saveItems() {
        do {
            try viewContext.save()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
}

#Preview {
    PersistenceController.view = .coreDataView
    return CoreDataBootcamp().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}

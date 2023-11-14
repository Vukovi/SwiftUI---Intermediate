//
//  SwiftUI_IntermediateApp.swift
//  SwiftUI-Intermediate
//
//  Created by Vuk Knezevic on 10.11.23.
//

import SwiftUI

@main
struct SwiftUI_IntermediateApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
//            ContentView()
            CoreDataBootcamp()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}

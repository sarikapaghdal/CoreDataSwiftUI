//
//  CoreDataIntroApp.swift
//  CoreDataIntro
//
//  Created by Sarika on 24.03.22.
//

import SwiftUI

@main
struct CoreDataIntroApp: App {
    @Environment(\.scenePhase) var scenePhase
    
    let persistenceController = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            ContentView() //highest level obj in our application
                .environment(\.managedObjectContext, persistenceController.viewContext) //injecting our context here, (key ,value) pair! this will be available throughout our entire app
        }.onChange(of: scenePhase) { _ in
            persistenceController.saveContext() //saving context of coredata while app is going in background- this way we dont loose any data
        }
    }
}

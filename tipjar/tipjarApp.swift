//
//  tipjarApp.swift
//  tipjar
//
//  Created by Victor Idongesit on 10/06/2022.
//

import SwiftUI

@main
struct tipjarApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            HomeView()
//            ContentView(value: 20)
//                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

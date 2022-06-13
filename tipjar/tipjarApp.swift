//
//  tipjarApp.swift
//  tipjar
//
//  Created by Victor Idongesit on 10/06/2022.
//

import SwiftUI

@main
struct tipjarApp: App {
    private var dataController = DataController.shared

    var body: some Scene {
        WindowGroup {
            HomeView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

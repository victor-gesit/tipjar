//
//  DataController.swift
//  tipjar
//
//  Created by Victor Idongesit on 12/06/2022.
//

import CoreData

class DataController: ObservableObject {
    static let shared = DataController()
    let container = NSPersistentContainer(name: "tipjar")
    
    private init() {
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Core Data failed to load: \(error.localizedDescription)")
            }
        }
    }
}


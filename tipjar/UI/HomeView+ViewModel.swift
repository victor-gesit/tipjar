//
//  HomeView+ViewModel.swift
//  tipjar
//
//  Created by Victor Idongesit on 13/06/2022.
//

import Foundation
import CoreData

extension HomeView {
    @MainActor class ViewModel: ObservableObject {
        @Published var amount: Double = 0
        @Published var amountString: String = ""
        @Published var numberOfPeople: Int = 1
        @Published var percentTip: Double = 10
        @Published var percentTipString: String = "10"
        @Published private(set) var totalTip: Double = 10
        @Published private(set) var perPersonTip: Double = 10
        @Published var takeReceiptOfPhoto: Bool = false
        @Published var imageData: Data?
        @Published var showValidationErrors: Bool = false
        
        @Published var history: [HistoryItem] = [HistoryItem.dummyItem, HistoryItem.dummyItem, HistoryItem.dummyItem, HistoryItem.dummyItem, HistoryItem.dummyItem]
        var context: NSManagedObjectContext?
        
        func computeTotal() {
            let total = percentTip * amount * Double(numberOfPeople) / 100
            let perPersonTip = percentTip * amount / 100
            self.totalTip = total
            self.perPersonTip = perPersonTip
        }
        
        func addHistoryItem() {
            guard let context = context else {
                return
            }

            let item = TipEntry(context: context)
            item.id = UUID()
            item.date = Date()
            item.amount = amount
            item.tip = totalTip
            item.imageData = imageData
            
            try? context.save()
            resetInputs()
        }
        
        func resetInputs() {
            self.amountString = ""
            self.percentTipString = "10"
            self.numberOfPeople = 1
            self.takeReceiptOfPhoto = false
            self.imageData = nil
        }
        
        func validateInputs() -> Bool {
            let inputsValid = !amountString.isEmpty && amount > 0 && !percentTipString.isEmpty && percentTip > 0
            return inputsValid
        }
    }
}

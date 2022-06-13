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
        @Published var currency: Currency = .dollar
        @Published var changeCurrency: Bool = false
        
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
            
            if !validateInputs() { return }

            let item = TipEntry(context: context)
            item.id = UUID()
            item.date = Date()
            item.amount = amount
            item.tip = totalTip
            item.imageData = imageData
            item.currency = currency.rawValue
            
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
        
        func changeCurrency(to: Currency) {
            self.currency = currency
        }
        
        func validateInputs() -> Bool {
            let inputsValid = !amountString.isEmpty && amount > 0 && !percentTipString.isEmpty && percentTip > 0
            return inputsValid
        }
    }
}

enum Currency: String, CaseIterable {
    case dollar
    case pounds
    case euros
    
    var symbol: String {
        switch self {
        case .dollar: return AppStrings.dollarSymbol
        case .pounds: return AppStrings.poundsSymbol
        case .euros: return AppStrings.euroSymbol
        }
    }
}

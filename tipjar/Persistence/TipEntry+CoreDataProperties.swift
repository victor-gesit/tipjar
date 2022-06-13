//
//  TipEntry+CoreDataProperties.swift
//  tipjar
//
//  Created by Victor Idongesit on 12/06/2022.
//
//

import Foundation
import CoreData


extension TipEntry {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<TipEntry> {
        return NSFetchRequest<TipEntry>(entityName: "TipEntry")
    }

    @NSManaged public var amount: Double
    @NSManaged public var date: Date
    @NSManaged public var id: UUID
    @NSManaged public var imageData: Data?
    @NSManaged public var tip: Double
    @NSManaged public var currency: String

    var historyItem: HistoryItem {
        let currency = Currency(rawValue: currency) ?? .dollar
        return HistoryItem(id: id, date: date, amount: amount, tip: tip, imageData: imageData, currency: currency)
    }
}

extension TipEntry : Identifiable {

}

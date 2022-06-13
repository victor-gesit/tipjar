//
//  HistoryItem.swift
//  tipjar
//
//  Created by Victor Idongesit on 13/06/2022.
//

import SwiftUI

struct HistoryItem: Identifiable {
    var id: UUID
    var date: Date
    var amount: Double
    var tip: Double
    var imageData: Data?
    var currency: Currency
    
    var uiImage: UIImage?
    var image: Image?
    
    init(id: UUID = UUID(), date: Date, amount: Double, tip: Double, imageData: Data?, currency: Currency = .dollar) {
        self.id = id
        self.date = date
        self.amount = amount
        self.tip = tip
        self.imageData = imageData
        self.currency = currency
        if let imageData = imageData,
           let uiImage = UIImage(data: imageData) {
            self.uiImage = uiImage
            self.image = Image(uiImage: uiImage)
        }
    }
    
    static let dummyItem: HistoryItem = HistoryItem(date: Date(), amount: 20.00, tip: 2.0, imageData: UIImage.from(.textyImage)?.jpegData(compressionQuality: .Conversions.imageCompression))
}

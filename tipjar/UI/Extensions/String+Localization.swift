//
//  String+Localization.swift
//  tipjar
//
//  Created by Victor Idongesit on 11/06/2022.
//

import Foundation

enum AppStrings: String {
    case enterAmount = "enter_amount"
    case howManyPeople = "how_many_people"
    case totalTip = "total_tip"
    case perPerson = "per_person"
    case takePhoto = "take_photo_of_receipt"
    case savePayment = "save_payment"
    case percentTip = "percent_tip"
    case tip = "tip"
    case savedPayments = "saved_payments"
    case pinchToZoom = "pinch_to_zoom"
    
    var localized: String {
        return NSLocalizedString(self.rawValue, comment: "")
    }
    
    static let twenty = "20"
    static let ten = "10"
    static let oneHundred = "100.00"
    static let percentSign = "%"
    static let dollarSymbol = "$"
    static let euroSymbol = "€"
    static let poundsSymbol = "£"
    static let numbers = "9876543210."
}

//
//  CGFloat+Extensions.swift
//  tipjar
//
//  Created by Victor Idongesit on 11/06/2022.
//

import SwiftUI

extension CGFloat {
    struct FontSize {
        static let homeMainInput: CGFloat = 42
        static let homeMinorLabel: CGFloat = 16
        static let homeMainLabel: CGFloat = 24
        static let amountChangeFontSize: CGFloat = 42
    }
    
    struct CornerRadius {
        static let mainInputCornerRadius: CGFloat = 12
        static let checkBoxCornerRadius: CGFloat = 5
        static let saveButtonCornerRadius: CGFloat = 48
    }
    
    struct Dimensions {
        static let mainInputHeight: CGFloat = 82
        static let checkboxDimension: CGFloat = 31
        static let checkMarkHeight: CGFloat = 9
        static let checkMarkWidth: CGFloat = 13
        static let amountChangeDimention: CGFloat = 71
        static let historyItemImageDimension: CGFloat = 53
        static let historyItemPreviewWidth: CGFloat = 300
        static let historyItemPreviewHeight: CGFloat = 450
        static let historyItemPreviewFooterHeight: CGFloat = 90
    }
    
    struct Padding {
        static let defaultPadding: CGFloat = 12
        static let sidePadding: CGFloat = 24
        static let historyItemSpacing: CGFloat = 4
        static let navItemPadding: CGFloat = 10
        static let navItemExtraSpace: CGFloat = 60
        static let historyItemPreviewPadding: CGFloat = 20
    }
    
    struct Borders {
        static let lineWidth: CGFloat = 1
        static let shadowOffset: CGFloat = 0.5
        static let shadowRadius: CGFloat = 1
    }
}

extension Double {
    func round(to places: Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
    
    var to2Dp:  Double {
        return self.round(to: 2)
    }
}

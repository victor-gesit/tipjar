//
//  Font+Extensions.swift
//  tipjar
//
//  Created by Victor Idongesit on 11/06/2022.
//

import SwiftUI

enum TipjarFont: String {
    case robotoBlack = "Roboto-Black"
}

extension Font {
    static func custom(from tipjarFont: TipjarFont, size: CGFloat) -> Font {
        return Font.custom(tipjarFont.rawValue, size: size)
    }
}

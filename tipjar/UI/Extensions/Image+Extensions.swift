//
//  Image+Extensions.swift
//  tipjar
//
//  Created by Victor Idongesit on 11/06/2022.
//

import SwiftUI

enum TipJarImage: String {
    case check
    case tipjarLogo
    case tipsHistoryIcon
    case sampleImage
    case backChevron
}

extension Image {
    static func from(_ tipJarImage: TipJarImage) -> Image {
        return Image(tipJarImage.rawValue)
    }
}

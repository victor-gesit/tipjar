//
//  SectionLabelView.swift
//  tipjar
//
//  Created by Victor Idongesit on 11/06/2022.
//

import SwiftUI

struct LabelView: View {
    var title: String
    var type: LabelType = .minor
    var body: some View {
        Text(title)
            .font(Font.custom(from: .robotoMedium, size: type == .minor ? .FontSize.homeMinorLabel : .FontSize.homeMainLabel))
    }
    
    enum LabelType {
        case minor
        case major
    }
}

struct SectionLabelView_Previews: PreviewProvider {
    static var previews: some View {
        LabelView(title: AppStrings.howManyPeople.localized)
    }
}

//
//  HistoryItemView.swift
//  tipjar
//
//  Created by Victor Idongesit on 12/06/2022.
//

import SwiftUI

struct HistoryItemView: View {
    var item: HistoryItem
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: .Padding.historyItemSpacing) {
                SectionLabelView(title: item.date.formatted)
                    .frame(alignment: .leading)
                HStack {
                    SectionLabelView(title: "\(AppStrings.dollarSign)\(item.amount.to2Dp)", type: .major)
                    SectionLabelView(title: "\(AppStrings.tip.localized): \(AppStrings.dollarSign)\(item.tip.to2Dp)")
                        .foregroundColor(Color.from(.lightGray))
                }
            }
            Spacer()
            Image.from(.sampleImage)
                .resizable()
                .frame(width: .Heights.historyItemImageDimension, height: .Heights.historyItemImageDimension)
                .aspectRatio(contentMode: .fill)
        }
    }
}

struct HistoryItemView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryItemView(item: HistoryItem())
    }
}

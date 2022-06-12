//
//  HistoryItemView.swift
//  tipjar
//
//  Created by Victor Idongesit on 12/06/2022.
//

import SwiftUI

struct HistoryItemView: View {
    var item: HistoryItem
    var showImage: Bool = true
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: .Padding.historyItemSpacing) {
                SectionLabelView(title: item.date.formatted)
                    .frame(alignment: .leading)
                HStack {
                    SectionLabelView(title: "\(AppStrings.dollarSign)\(item.amount.to2Dp)", type: .major)
                    if(!showImage) {
                        Spacer()
                    }
                    SectionLabelView(title: "\(AppStrings.tip.localized): \(AppStrings.dollarSign)\(item.tip.to2Dp)")
                        .foregroundColor(Color.from(.lightGray))
                }
            }
            Spacer()
            if showImage {
                Image.from(.sampleImage)
                    .resizable()
                    .frame(width: .Dimensions.historyItemImageDimension, height: .Dimensions.historyItemImageDimension)
                    .aspectRatio(contentMode: .fill)
            }
        }
    }
}

struct HistoryItemView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryItemView(item: HistoryItem())
    }
}

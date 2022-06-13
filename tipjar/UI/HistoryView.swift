//
//  HistoryView.swift
//  tipjar
//
//  Created by Victor Idongesit on 12/06/2022.
//

import SwiftUI
import CoreData

struct HistoryView: View {
    var historyItems: FetchedResults<TipEntry>
    @Environment(\.presentationMode) var presentationMode
    @State private var showDetail = false
    @State private var selectedHistoryItem: HistoryItem?
    
    var body: some View {
        VStack {
            if historyItems.count == 0 {
                Text(AppStrings.noTipsRecorded.localized)
                    .font(Font.custom(from: .robotoMedium, size: .FontSize.homeMainLabel))
                    .foregroundColor(Color.from(.lightGray))
                    .frame(alignment: .center)
                    .multilineTextAlignment(.center)
            } else {
                ScrollView(showsIndicators: false) {
                    VStack(spacing: .Dimensions.historySpacing) {
                        ForEach(historyItems, id: \.id) { item in
                            HistoryItemView(item: item.historyItem)
                                .onTapGesture {
                                    selectedHistoryItem = item.historyItem
                                    showDetail.toggle()
                                }
                        }
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .padding(.Padding.sidePadding)
                .fullScreenCover(item: $selectedHistoryItem) { item in
                    SavedItemDetailView(item: item)
                }
            }
        }
        .toolbar {
            ToolbarItem(placement: .principal) {
                LabelView(title: AppStrings.savedPayments.localized)
            }
        }
        .navigationViewStyle(.stack)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Image.from(.backChevron)
                    .padding(.top, .Padding.navItemPadding)
                    .padding(.bottom, .Padding.navItemPadding)
                    .padding(.trailing, .Padding.navItemExtraSpace)
                    .onTapGesture {
                        self.presentationMode.wrappedValue.dismiss()
                    }
            }
        }
    }
}

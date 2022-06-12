//
//  HistoryView.swift
//  tipjar
//
//  Created by Victor Idongesit on 12/06/2022.
//

import SwiftUI

struct HistoryItem {
    var id = UUID()
    var date: Date
    var amount: Double
    var tip: Double
    var image: Data
    
    init() {
        date = Date()
        amount = 20.2
        tip = 2.5
        image = Data()
    }
}

struct HistoryView: View {
    var historyItems: [HistoryItem] = [HistoryItem(), HistoryItem(), HistoryItem(), HistoryItem()]
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        ScrollView {
            VStack {
                ForEach(historyItems, id: \.id) { item in
                    HistoryItemView(item: item)
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(.leading, .Padding.sidePadding)
        .padding(.trailing, .Padding.sidePadding)
        .toolbar {
            ToolbarItem(placement: .principal) {
                SectionLabelView(title: AppStrings.savedPayments.localized)
            }
        }
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
        .navigationViewStyle(.stack)
    }
}

struct HistoryView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryView()
    }
}

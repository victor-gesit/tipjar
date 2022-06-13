//
//  HistoryView.swift
//  tipjar
//
//  Created by Victor Idongesit on 12/06/2022.
//

import SwiftUI
import CoreData

struct HistoryItem: Identifiable {
    var id: UUID
    var date: Date
    var amount: Double
    var tip: Double
    var imageData: Data?
    
    var uiImage: UIImage?
    var image: Image?
    
    init(id: UUID = UUID(), date: Date, amount: Double, tip: Double, imageData: Data?) {
        self.id = id
        self.date = date
        self.amount = amount
        self.tip = tip
        self.imageData = imageData
        if let imageData = imageData,
           let uiImage = UIImage(data: imageData) {
            self.uiImage = uiImage
            self.image = Image(uiImage: uiImage)
        }
    }
    
    static let dummyItem: HistoryItem = HistoryItem(date: Date(), amount: 20.00, tip: 2.0, imageData: UIImage.from(.textyImage)?.jpegData(compressionQuality: .Conversions.imageCompression))
}

struct HistoryView: View {
    var historyItems: FetchedResults<TipEntry>
    @Environment(\.presentationMode) var presentationMode
    @State private var showDetail = false
    @State private var selectedHistoryItem: HistoryItem?
    
    var body: some View {
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
        .toolbar {
            ToolbarItem(placement: .principal) {
                LabelView(title: AppStrings.savedPayments.localized)
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
        .fullScreenCover(item: $selectedHistoryItem) { item in
            SavedItemDetailView(item: item)
        }
        .navigationViewStyle(.stack)
    }
}

//struct HistoryView_Previews: PreviewProvider {
//    static var previews: some View {
//        HistoryView(historyItems: [])
//    }
//}

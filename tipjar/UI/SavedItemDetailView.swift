//
//  SavedItemDetailView.swift
//  tipjar
//
//  Created by Victor Idongesit on 12/06/2022.
//

import SwiftUI
import UIKit
import PDFKit

struct SavedItemDetailView: View {
    @Environment(\.dismiss) var dismiss
    var body: some View {
        VStack {
            Spacer()
            VStack {
                ZoomableImageView(image: UIImage(named: "textyImage")!)
                    .frame(width: .Dimensions.historyItemPreviewWidth, height: .Dimensions.historyItemPreviewHeight)
                    .cornerRadius(.CornerRadius.mainInputCornerRadius)
                HistoryItemView(item: HistoryItem(), showImage: false)
                    .padding()
                    .frame(width: .Dimensions.historyItemPreviewWidth, height: .Dimensions.historyItemPreviewFooterHeight)
                    .background(.white)
                    .cornerRadius(.CornerRadius.mainInputCornerRadius)
            }
            .padding(.leading, .Padding.historyItemPreviewPadding)
            .padding(.trailing, .Padding.historyItemPreviewPadding)
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(
            BackgroundBlurView()
                .onTapGesture {
                    dismiss()
                })
        .edgesIgnoringSafeArea(.all)
    }
}

struct SavedItemDetailView_Previews: PreviewProvider {
    static var previews: some View {
        SavedItemDetailView()
    }
}


struct BackgroundBlurView: UIViewRepresentable {
    func makeUIView(context: Context) -> UIView {
        let view = UIVisualEffectView(effect: UIBlurEffect(style: .systemThickMaterialDark))
        view.alpha = 0.8
        DispatchQueue.main.async {
            view.superview?.superview?.backgroundColor = .clear
        }
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {}
}

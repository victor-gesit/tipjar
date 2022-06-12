//
//  ZoomableImageView.swift
//  tipjar
//
//  Created by Victor Idongesit on 12/06/2022.
//

import SwiftUI
import PDFKit


struct ZoomableImageView: UIViewRepresentable {
    let image: UIImage

    func makeUIView(context: Context) -> PDFView {
        let view = PDFView()
        view.document = PDFDocument()
        guard let page = PDFPage(image: image) else { return view }
        view.document?.insert(page, at: 0)
        view.autoScales = true
        return view
    }

    func updateUIView(_ uiView: PDFView, context: Context) {}
}


struct ZoomableImageView_Previews: PreviewProvider {
    static var previews: some View {
        ZoomableImageView(image: UIImage(named: "textyImage")!)
    }
}

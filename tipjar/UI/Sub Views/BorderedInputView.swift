//
//  BorderedInputView.swift
//  tipjar
//
//  Created by Victor Idongesit on 11/06/2022.
//

import SwiftUI
import Combine

struct BorderedInputView<LeftLabel, RightLabel>: View where LeftLabel: View, RightLabel: View {
    @ViewBuilder var leftLabel: LeftLabel
    @ViewBuilder var rightLabel: RightLabel
    @State private var input: String = ""
    init(@ViewBuilder leftLabel: () -> LeftLabel, @ViewBuilder rightLabel: () -> RightLabel) {
        self.leftLabel = leftLabel()
        self.rightLabel = rightLabel()
    }
    
    var body: some View {
        HStack {
            leftLabel
            Spacer()
            TextField("200.00", text: $input)
                .font(Font.custom(from: .robotoBlack, size: 50))
                .multilineTextAlignment(.center)
                .keyboardType(.decimalPad)
                .onChange(of: input) { _ in
                    let filtered = input.filter {"0123456789.".contains($0)}
                    
                    
                    if filtered.contains(".") {
                        if input.count == 1 {
                            input = "0."
                            return
                        }
                        let splitted = filtered.split(separator: ".")
                        if splitted.count >= 2 {
                            let preDecimal = String(splitted[0])
                            let afterDecimal = String(splitted[1])
                            input = "\(preDecimal).\(afterDecimal)"
                        }
                    }
                }
            Spacer()
            rightLabel
        }
        .padding()
        .frame(height: 82)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.from(.borderGray), lineWidth: 1)
                .shadow(color: Color.from(.borderGray), radius: 1, x: 0.5, y: 0.5)
        )
        .padding()
    }
}

extension BorderedInputView where RightLabel == EmptyView   {
    init(@ViewBuilder leftLabel: () -> LeftLabel) {
        self.leftLabel = leftLabel()
        self.rightLabel = EmptyView()
    }
}

extension BorderedInputView where LeftLabel == EmptyView {
    init( @ViewBuilder rightLabel: () -> RightLabel) {
        self.rightLabel = rightLabel()
        self.leftLabel = EmptyView()
    }
}

struct BorderedInputView_Previews: PreviewProvider {
    static var previews: some View {
        BorderedInputView(rightLabel: {
            Text("%")
                .font(Font.custom(from: .robotoBlack, size: 24))
        })
    }
}

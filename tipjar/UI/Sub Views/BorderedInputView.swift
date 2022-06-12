//
//  BorderedInputView.swift
//  tipjar
//
//  Created by Victor Idongesit on 11/06/2022.
//

import SwiftUI

struct BorderedInputView<LeftLabel, RightLabel>: View where LeftLabel: View, RightLabel: View {
    @ViewBuilder var leftLabel: LeftLabel
    @ViewBuilder var rightLabel: RightLabel
    @State var inputString: String
    @Binding private var inputValue: Double
    var placeHolder: String
    init(inputValue: Binding<Double>, placeHolder: String = AppStrings.oneHundred, @ViewBuilder leftLabel: () -> LeftLabel, @ViewBuilder rightLabel: () -> RightLabel) {
        self.leftLabel = leftLabel()
        self.rightLabel = rightLabel()
        self.placeHolder = placeHolder
        let initialValue = inputValue.wrappedValue > 0 ? inputValue.wrappedValue.description : ""
        _inputString = State(initialValue: initialValue)
        _inputValue = inputValue
    }
    
    var body: some View {
        HStack {
            leftLabel
            Spacer()
            TextField(placeHolder, text: $inputString)
                .font(Font.custom(from: .robotoMedium, size: .FontSize.homeMainInput))
                .multilineTextAlignment(.center)
                .keyboardType(.decimalPad)
                .onChange(of: inputString) { _ in
                    let filtered = inputString.filter {AppStrings.numbers.contains($0)}
                    
                    if filtered.contains(".") {
                        if inputString.count == 1 {
                            inputString = "0."
                            return
                        }
                        let splitted = filtered.split(separator: ".")
                        if splitted.count >= 2 {
                            let preDecimal = String(splitted[0])
                            let afterDecimal = String(splitted[1])
                            inputString = "\(preDecimal).\(afterDecimal)"
                        }
                    }
                    inputValue = Double(inputString) ?? 0
                }
            Spacer()
            rightLabel
        }
        .padding()
        .frame(height: .Dimensions.mainInputHeight)
        .overlay(
            RoundedRectangle(cornerRadius: .CornerRadius.mainInputCornerRadius)
                .stroke(Color.from(.borderGray), lineWidth: .Borders.lineWidth)
                .shadow(color: Color.from(.borderGray), radius: .Borders.shadowRadius, x: .Borders.shadowOffset, y: .Borders.shadowOffset)
        )
    }
}

extension BorderedInputView where RightLabel == EmptyView   {
    init(inputValue: Binding<Double>, placeHolder: String = AppStrings.oneHundred, @ViewBuilder leftLabel: () -> LeftLabel) {
        self.leftLabel = leftLabel()
        self.rightLabel = EmptyView()
        self.placeHolder = placeHolder
        let initialValue = inputValue.wrappedValue > 0 ? inputValue.wrappedValue.description : ""
        _inputString = State(initialValue: initialValue)
        _inputValue = inputValue
    }
}

extension BorderedInputView where LeftLabel == EmptyView {
    init(inputValue: Binding<Double>, placeHolder: String = AppStrings.oneHundred, @ViewBuilder rightLabel: () -> RightLabel) {
        self.rightLabel = rightLabel()
        self.leftLabel = EmptyView()
        self.placeHolder = placeHolder
        let initialValue = inputValue.wrappedValue > 0 ? inputValue.wrappedValue.description : ""
        _inputString = State(initialValue: initialValue)
        _inputValue = inputValue
    }
}

struct BorderedInputView_Previews: PreviewProvider {
    static var previews: some View {
        BorderedInputView(inputValue: .constant(20), rightLabel: {
            Text(AppStrings.percentSign)
                .font(Font.custom(from: .robotoMedium, size: .FontSize.homeMainLabel))
        })
    }
}

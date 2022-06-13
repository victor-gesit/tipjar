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
    @Binding var inputString: String
    @Binding var inputValue: Double
    @Binding var validateInput: Bool
    @State var borderColor: Color = Color.from(.borderGray)
    var placeHolder: String
    
    init(inputValue: Binding<Double>, inputString: Binding<String>, placeHolder: String = AppStrings.oneHundred, validateInput: Binding<Bool>, @ViewBuilder leftLabel: () -> LeftLabel, @ViewBuilder rightLabel: () -> RightLabel) {
        self.leftLabel = leftLabel()
        self.rightLabel = rightLabel()
        self.placeHolder = placeHolder
        _inputString = inputString
        _inputValue = inputValue
        _validateInput = validateInput
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
                .onChange(of: validateInput) { newValue in
                    validate()
                    validateInput = false
                }
            Spacer()
            rightLabel
        }
        .padding()
        .frame(height: .Dimensions.mainInputHeight)
        .overlay(
            RoundedRectangle(cornerRadius: .CornerRadius.mainInputCornerRadius)
                .stroke(borderColor, lineWidth: .Borders.lineWidth)
                .shadow(color: Color.from(.borderGray), radius: .Borders.shadowRadius, x: .Borders.shadowOffset, y: .Borders.shadowOffset)
        )
    }
    
    func validate() {
        if !inputString.isEmpty && inputValue > 0 {
            return
        }
        borderColor = .red
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            withAnimation {
                borderColor = Color.from(.borderGray)
            }
        }
    }
}

extension BorderedInputView where RightLabel == EmptyView   {
    init(inputValue: Binding<Double>, inputString: Binding<String>, placeHolder: String = AppStrings.oneHundred, validateInput: Binding<Bool>, @ViewBuilder leftLabel: () -> LeftLabel) {
        self.leftLabel = leftLabel()
        self.rightLabel = EmptyView()
        self.placeHolder = placeHolder
        _inputString = inputString
        _inputValue = inputValue
        _validateInput = validateInput
    }
}

extension BorderedInputView where LeftLabel == EmptyView {
    init(inputValue: Binding<Double>, inputString: Binding<String>, placeHolder: String = AppStrings.oneHundred, validateInput: Binding<Bool>, @ViewBuilder rightLabel: () -> RightLabel) {
        self.rightLabel = rightLabel()
        self.leftLabel = EmptyView()
        self.placeHolder = placeHolder
        _inputString = inputString
        _inputValue = inputValue
        _validateInput = validateInput
    }
}

struct BorderedInputView_Previews: PreviewProvider {
    static var previews: some View {
        BorderedInputView(inputValue: .constant(20), inputString: .constant(""), validateInput: .constant(false), rightLabel: {
            Text(AppStrings.percentSign)
                .font(Font.custom(from: .robotoMedium, size: .FontSize.homeMainLabel))
        })
    }
}

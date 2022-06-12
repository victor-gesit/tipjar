//
//  AmountChangeButtonView.swift
//  tipjar
//
//  Created by Victor Idongesit on 11/06/2022.
//

import SwiftUI

struct AmountChangeButtonView: View {
    enum ChangeType: String {
        case increment = "+"
        case decrement = "-"
    }
    var type: ChangeType
    var disable: Bool {
        type == .decrement && value < 2
    }
    @Binding var value: Int
    var body: some View {
        Button {
            performChange()
        } label: {
            Text(type.rawValue)
                .frame(width: .Dimensions.amountChangeDimention, height: .Dimensions.amountChangeDimention)
                .font(Font.custom(from: .robotoMedium, size: .FontSize.amountChangeFontSize))
                .foregroundColor(disable ? Color.from(.borderGray) : Color.from(.valueChangeOrange))
                .overlay(Circle().stroke(Color.from(.borderGray)))
        }
        .disabled(disable)
    }
    
    func performChange() {
        switch type {
        case .increment:
            value += 1
        case .decrement:
            if value > 1 {
                value -= 1
            }
        }
    }
    
}

struct AmountChangeButtonView_Previews: PreviewProvider {
    static var previews: some View {
        AmountChangeButtonView(type: .decrement, value: .constant(20))
    }
}

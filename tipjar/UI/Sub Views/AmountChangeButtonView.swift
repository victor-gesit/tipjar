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
    @Binding var value: Double
    var body: some View {
        Button {
            performChange()
        } label: {
            Text(type.rawValue)
                .frame(width: 100, height: 100)
                .font(Font.custom(from: .robotoBlack, size: 40))
                .foregroundColor(Color.from(.valueChangeOrange))
                .overlay(Circle().stroke(Color.from(.borderGray)))
        }

    }
    
    func performChange() {
        switch type {
        case .increment:
            value += 1
        case .decrement:
            value -= 1
        }
    }
    
}

struct AmountChangeButtonView_Previews: PreviewProvider {
    static var previews: some View {
        AmountChangeButtonView(type: .decrement, value: .constant(20))
    }
}

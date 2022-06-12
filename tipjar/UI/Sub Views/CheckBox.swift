//
//  CheckBox.swift
//  tipjar
//
//  Created by Victor Idongesit on 11/06/2022.
//

import SwiftUI

struct CheckBox: View {
    @Binding var checked: Bool
    var body: some View {
        Button {
            toggle()
        } label: {
            Image.from(.check)
                .resizable()
                .renderingMode(.template)
                .foregroundColor(checked ? Color.from(.checkboxOrange) : Color.from(.checkboxGray))
                .frame(width: .Dimensions.checkMarkWidth, height: .Dimensions.checkMarkHeight)
                .overlay(
                    RoundedRectangle(cornerRadius: .CornerRadius.checkBoxCornerRadius).stroke(checked ? Color.from(.checkboxOrange) : Color.from(.checkboxGray))
                        .frame(width: .Dimensions.checkboxDimension, height: .Dimensions.checkboxDimension)
                )
        }
        .frame(width: .Dimensions.checkboxDimension, height: .Dimensions.checkboxDimension)
    }
    
    func toggle() {
        checked = !checked
    }
}

struct CheckBox_Previews: PreviewProvider {
    static var previews: some View {
        CheckBox(checked: .constant(false))
    }
}

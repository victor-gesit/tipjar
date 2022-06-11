//
//  SaveButtonView.swift
//  tipjar
//
//  Created by Victor Idongesit on 11/06/2022.
//

import SwiftUI

struct SaveButtonView: View {
    var body: some View {
        Button {
            savePayment()
        } label: {
            Text(AppStrings.savePayment.localized)
                .font(Font.custom(from: .robotoMedium, size: .FontSize.homeMinorLabel))
                .frame(height: .CornerRadius.saveButtonCornerRadius)
                .frame(maxWidth: .infinity)
                .background(
                    LinearGradient(colors: [Color.from(.valueChangeOrange), Color.from(.saveButtonGradientStop)], startPoint: .top, endPoint: .bottom)
                )
                .foregroundColor(.white)
                .cornerRadius(.CornerRadius.mainInputCornerRadius)
        }
    }
    
    func savePayment() {
        
    }
}

struct SaveButtonView_Previews: PreviewProvider {
    static var previews: some View {
        SaveButtonView()
    }
}

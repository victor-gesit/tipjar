//
//  HomeView.swift
//  tipjar
//
//  Created by Victor Idongesit on 11/06/2022.
//

import SwiftUI

extension HomeView {
    @MainActor class ViewModel: ObservableObject {
        @Published var amount: Double = 0
        @Published var numberOfPeople: Int = 1
        @Published var percentTip: Double = 10
        @Published private(set) var totalTip: Double = 10
        @Published private(set) var perPersonTip: Double = 10
        @Published var takeReceiptOfPhoto: Bool = false
        
        func computeTotal() {
            let total = percentTip * amount * Double(numberOfPeople) / 100
            let perPersonTip = percentTip * amount / 100
            self.totalTip = total
            self.perPersonTip = perPersonTip
        }
    }
}

struct HomeView: View {
    @StateObject var viewModel: ViewModel = ViewModel()
    @State private var goToHistory = false
    
    var body: some View {
        NavigationView {
            VStack {
                ScrollView(showsIndicators: false) {
                    VStack(alignment: .leading) {
                        SectionLabelView(title: AppStrings.enterAmount.localized)
                        
                        BorderedInputView(inputValue: $viewModel.amount, leftLabel: {
                            SectionLabelView(title: AppStrings.dollarSign, type: .major)
                        })
                        .onReceive(viewModel.$amount, perform: { amount in
                            viewModel.computeTotal()
                        })
                        .padding(.bottom, .Padding.defaultPadding)
                        SectionLabelView(title: AppStrings.howManyPeople.localized)
                        
                        HStack {
                            AmountChangeButtonView(type: .increment, value: $viewModel.numberOfPeople)
                            Spacer()
                            Text("\(viewModel.numberOfPeople)")
                                .font(Font.custom(from: .robotoMedium, size: .FontSize.amountChangeFontSize))
                                .onReceive(viewModel.$numberOfPeople, perform: { _ in
                                    viewModel.computeTotal()
                                })
                            Spacer()
                            AmountChangeButtonView(type: .decrement, value: $viewModel.numberOfPeople)
                        }
                        .padding(.bottom, .Padding.defaultPadding)
                        Text(AppStrings.percentTip.localized)
                            .padding(.bottom, .Padding.defaultPadding)
                        
                        BorderedInputView(inputValue: $viewModel.percentTip, placeHolder: AppStrings.ten, rightLabel: {
                            SectionLabelView(title: AppStrings.percentSign, type: .major)
                        })
                        .padding(.bottom, .Padding.defaultPadding)
                        .onReceive(viewModel.$percentTip, perform: { _ in
                            viewModel.computeTotal()
                        })
                        
                        VStack {
                            HStack {
                                SectionLabelView(title: AppStrings.totalTip.localized)
                                    Spacer()
                                SectionLabelView(title: "\(AppStrings.dollarSign)\(viewModel.totalTip.to2Dp)")
                                        .padding(.bottom, .Padding.defaultPadding)
                            }
                            HStack {
                                SectionLabelView(title: AppStrings.perPerson.localized, type: .major)
                                    .padding(.bottom, .Padding.defaultPadding)
                                    Spacer()
                                SectionLabelView(title: "\(AppStrings.dollarSign)\(viewModel.perPersonTip.to2Dp)", type: .major)
                                    .padding(.bottom, .Padding.defaultPadding)
                            }
                            .padding(.bottom, .Padding.defaultPadding)
                        }
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(
                        NavigationLink(destination: HistoryView(), isActive: $goToHistory) {
                          EmptyView()
                        }
                    )
                    .toolbar {
                        ToolbarItem(placement: .principal) {
                            Image.from(.tipjarLogo)
                        }
                    }
                    .toolbar {
                        ToolbarItem(placement: .primaryAction) {
                            Button {
                                showHistory()
                            } label: {
                                Image.from(.tipsHistoryIcon)
                                    .padding(.top, .Padding.navItemPadding)
                                    .padding(.bottom, .Padding.navItemPadding)
                                    .padding(.leading, .Padding.navItemExtraSpace)
                            }
                        }
                    }
                }
                .frame(maxHeight: .infinity)
                .navigationViewStyle(.stack)
                .navigationBarTitleDisplayMode(.inline)
                .onTapGesture {
                    UIApplication.shared.endEditing()
                }
                
                VStack(alignment: .leading){
                    HStack {
                        CheckBox(checked: $viewModel.takeReceiptOfPhoto)
                        SectionLabelView(title: AppStrings.takePhoto.localized)
                            .padding(.leading, .Padding.defaultPadding)
                    }
                    
                    SaveButtonView()
                }
            }
            .padding(.Padding.sidePadding)
        }
    }
    
    func showHistory() {
        goToHistory = true
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

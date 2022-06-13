//
//  HomeView.swift
//  tipjar
//
//  Created by Victor Idongesit on 11/06/2022.
//

import SwiftUI

struct HomeView: View {
    @StateObject var viewModel: ViewModel = ViewModel()
    @State private var goToHistory = false
    @State var openCamera: Bool = false
    
    var history: [HistoryItem] = []
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \TipEntry.date, ascending: true)]) var savedEntries: FetchedResults<TipEntry>
    @Environment(\.managedObjectContext) var context
    
    
    var body: some View {
        NavigationView {
            VStack {
                ScrollView(showsIndicators: false) {
                    VStack(alignment: .leading) {
                        LabelView(title: AppStrings.enterAmount.localized)

                        BorderedInputView(inputValue: $viewModel.amount, inputString: $viewModel.amountString, validateInput: $viewModel.showValidationErrors, leftLabel: {
                            LabelView(title: viewModel.currency.symbol, type: .major)
                        })
                        .onReceive(viewModel.$amount, perform: { _ in
                            viewModel.computeTotal()
                        })
                        .padding(.bottom, .Padding.defaultPadding)
                        
                        LabelView(title: AppStrings.howManyPeople.localized)
                        
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
                        
                        BorderedInputView(inputValue: $viewModel.percentTip, inputString: $viewModel.percentTipString, placeHolder: AppStrings.ten, validateInput: $viewModel.showValidationErrors, rightLabel: {
                            LabelView(title: AppStrings.percentSign, type: .major)
                        })
                        .padding(.bottom, .Padding.defaultPadding)
                        .onReceive(viewModel.$percentTip, perform: { _ in
                            viewModel.computeTotal()
                        })
                        
                        VStack {
                            HStack {
                                LabelView(title: AppStrings.totalTip.localized)
                                    Spacer()
                                LabelView(title: "\(viewModel.currency.symbol)\(viewModel.totalTip.to2Dp)")
                                        .padding(.bottom, .Padding.defaultPadding)
                            }
                            HStack {
                                LabelView(title: AppStrings.perPerson.localized, type: .major)
                                    .padding(.bottom, .Padding.defaultPadding)
                                    Spacer()
                                LabelView(title: "\(viewModel.currency.symbol)\(viewModel.perPersonTip.to2Dp)", type: .major)
                                    .padding(.bottom, .Padding.defaultPadding)
                            }
                            .padding(.bottom, .Padding.defaultPadding)
                        }
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(
                        NavigationLink(destination: HistoryView(historyItems: savedEntries), isActive: $goToHistory) {
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
                    .toolbar {
                        ToolbarItem(placement: .navigationBarLeading) {
                            Button {
                                viewModel.changeCurrency = true
                            } label: {
                                Menu {
                                    Picker(selection: $viewModel.currency) {
                                        ForEach(Currency.allCases, id: \.self) {
                                            LabelView(title: $0.rawValue.capitalized, type: .major)
                                                .padding(.top, .Padding.navItemPadding)
                                                .padding(.bottom, .Padding.navItemPadding)
                                                .padding(.trailing, .Padding.navItemExtraSpace)
                                        }
                                    } label: {}
                                } label: {
                                    Text(viewModel.currency.symbol)
                                        .font(Font.custom(from: .robotoMedium, size: .FontSize.homeMainLabel))
                                        .foregroundColor(Color.from(.saveButtonGradientStop))
                                }
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
                
                ZStack {
                    VStack(alignment: .leading){
                        HStack {
                            CheckBox(checked: $viewModel.takeReceiptOfPhoto)
                            LabelView(title: AppStrings.takePhoto.localized)
                                .padding(.leading, .Padding.defaultPadding)
                        }
                        
                        SaveButtonView(saveAction: saveReceipt)
                    }
                }
            }
            .padding(.Padding.sidePadding)
            .sheet(isPresented: $openCamera) {
                imagePicker
            }
            .onAppear {
                viewModel.context = context
            }
        }
    }
    
    func showHistory() {
        goToHistory = true
    }
    
    func saveReceipt() {
        if(!viewModel.validateInputs()) {
            viewModel.showValidationErrors = true
            return
        }
        if(viewModel.takeReceiptOfPhoto) {
            openCamera = true
        } else {
            self.viewModel.addHistoryItem()
            showHistory()
        }
    }
    
    var imagePicker: some View {
        ImagePickerView(sourceType: .camera) {image in
            self.viewModel.imageData = image.jpegData(compressionQuality: .Conversions.imageCompression)
            self.viewModel.addHistoryItem()
            showHistory()
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

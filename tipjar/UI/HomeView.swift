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
    @State var takePicture: Bool = false
    @State var receiptImage: UIImage?
    
    var history: [HistoryItem] = []
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \TipEntry.date, ascending: true)]) var savedEntries: FetchedResults<TipEntry>
    @Environment(\.managedObjectContext) var context
    
    
    var body: some View {
        NavigationView {
            VStack {
                ScrollView(showsIndicators: false) {
                    VStack(alignment: .leading) {
                        SectionLabelView(title: AppStrings.enterAmount.localized)
                        
                        BorderedInputView(inputValue: $viewModel.amount, inputString: $viewModel.amountString, leftLabel: {
                            SectionLabelView(title: AppStrings.dollarSign, type: .major)
                        })
                        .onReceive(viewModel.$amount, perform: { _ in
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
                        
                        BorderedInputView(inputValue: $viewModel.percentTip, inputString: $viewModel.percentTipString, placeHolder: AppStrings.ten, rightLabel: {
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
                    
                    SaveButtonView(saveAction: saveReceipt)
                }
            }
            .padding(.Padding.sidePadding)
            .sheet(isPresented: $takePicture) {
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
        if(viewModel.takeReceiptOfPhoto) {
            takePicture = true
        } else {
            self.viewModel.addHistoryItem()
            showHistory()
        }
    }
    
    var imagePicker: some View {
        ImagePickerView(sourceType: .camera) {image in
            self.viewModel.imageData = image.jpegData(compressionQuality: .Conversions.imageCompression)
            self.receiptImage = image
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

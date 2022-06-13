//
//  tipjarUITests.swift
//  tipjarUITests
//
//  Created by Victor Idongesit on 10/06/2022.
//

import XCTest

class tipjarUITests: XCTestCase {
    func testCanAddTipItem() throws {
        let app = XCUIApplication()
        app.launch()
        let amountTextField = app.textFields["100.00"]
        let incrementButton = app.buttons["+"]
        let decrementButton = app.buttons["-"]
        let scrollViewsQuery = XCUIApplication().scrollViews
        let savePaymentButton = app.buttons["Save Payment"]
        let tipPercentText = scrollViewsQuery.otherElements.textFields["10"]
        let totalTipText = scrollViewsQuery.otherElements.children(matching: .staticText).matching(identifier: "$60.0").element
        let perPersonTipText = scrollViewsQuery.otherElements.children(matching: .staticText).matching(identifier: "$20.0").element
        let tipLabel = scrollViewsQuery.otherElements.children(matching: .staticText).matching(identifier: "Tip: $60.0").element
        let enterAmountElement = scrollViewsQuery.otherElements.containing(.staticText, identifier:"Enter Amount").element
        
        amountTextField.tap()
        amountTextField.typeText("200")
        
        incrementButton.tap()
        incrementButton.tap()
        incrementButton.tap()
        
        decrementButton.tap()
        
        enterAmountElement.tap()
        
        tipPercentText.tap()
        app.clearTextOnElement(tipPercentText)
        tipPercentText.typeText("10")
        
        sleep(1)
        enterAmountElement.tap()
        
        
        XCTAssertTrue(totalTipText.waitForExistence(timeout: 1))
        XCTAssertTrue(perPersonTipText.waitForExistence(timeout: 1))
        
        sleep(1)
        
        savePaymentButton.tap()
        
        XCTAssertTrue(tipLabel.waitForExistence(timeout: 2)) // Visible on next page
        
    }
}

extension XCUIApplication {
    func clearTextOnElement(_ element: XCUIElement) {
        element.doubleTap()
        menuItems["Cut"].tap()
    }
}

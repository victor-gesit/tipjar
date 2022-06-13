//
//  tipjarTests.swift
//  tipjarTests
//
//  Created by Victor Idongesit on 10/06/2022.
//

import XCTest
@testable import tipjar

class tipjarTests: XCTestCase {
    @MainActor func testHomeViewViewModelCorrectInputs() throws {
        let sut = HomeView.ViewModel()
        sut.percentTip = 10
        sut.percentTipString = "10"
        sut.amount = 20
        sut.amountString = "20"
        sut.numberOfPeople = 5
        sut.computeTotal()
        XCTAssertTrue(sut.validateInputs())
        XCTAssert(sut.totalTip == 10)
    }
    
    @MainActor func testHomeViewViewModelIncorrectInputs() throws {
        let sut = HomeView.ViewModel()
        sut.percentTip = 10
        sut.amount = 0
        sut.numberOfPeople = 5
        sut.computeTotal()
        XCTAssertFalse(sut.validateInputs())
        XCTAssert(sut.totalTip == 0)
    }
}

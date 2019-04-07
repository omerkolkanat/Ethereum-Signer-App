//
//  EthereumSignerUITests.swift
//  EthereumSignerUITests
//
//  Created by OMER YASIN KOLKANAT on 3.04.2019.
//  Copyright © 2019 Omer Kolkanat. All rights reserved.
//

import XCTest

class EthereumSignerUITests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testSetup() {
        let app = XCUIApplication()
        let privateKeyTextField = app.textFields["Private Key"]
        if privateKeyTextField.exists { //Check setup screen passed
            privateKeyTextField.tap()
            privateKeyTextField.typeText("0x85f2f20a9db5c18a656480a99d4cb1feef5e7eba7c9dff1213fb52aed60881dc")
            app.buttons["Done"].tap()
            sleep(5)
            XCTAssert(app.staticTexts["address"].exists)
            XCTAssert(app.staticTexts["balance"].exists)
        }
    }
    
    func testSigning() {
        let app = XCUIApplication()
        app.buttons["Sign"].tap()
        let messageTextField = app.textFields["Message"]
        messageTextField.tap()
        messageTextField.typeText("hello")
        app.buttons["Sign Message"].tap()
        
        XCTAssert(app.images["QR Code Image View"].exists)
    }
    
    func testValidation() {
        let app = XCUIApplication()
        app.buttons["Validate"].tap()
        let messageTextField = app.textFields["Message"]
        messageTextField.tap()
        messageTextField.typeText("hello")
        app.buttons["Validate Message"].tap()
    }
}

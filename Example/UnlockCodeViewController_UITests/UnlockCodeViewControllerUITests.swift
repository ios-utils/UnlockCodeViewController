//
//  UnlockCodeViewControllerUITests.swift
//
//  Created by Reece Como on 8/1/19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import XCTest

class UnlockCodeViewControllerUITests: XCTestCase {
    
    /// XCUIApplication shortcut
    private var app: XCUIApplication {
        return XCUIApplication()
    }

    /// Setup the tests
    override func setUp() {
        continueAfterFailure = false
        app.launch()
    }

    /// Enter the code wrong once, then right
    func testEnteringTheCodeUI() {
        // Get it wrong first
        app.keys["1"].tap()
        app.keys["2"].tap()
        app.keys["3"].tap()
        app.keys["4"].tap()
        app.keys["5"].tap()
        app.keys["5"].tap()
        sleep(1)
        
        // Lets get it right this time
        app.keys["1"].tap()
        app.keys["2"].tap()
        app.keys["3"].tap()
        app.keys["4"].tap()
        app.keys["5"].tap()
        app.keys["6"].tap()
        sleep(1)
    }
    
    /// Enter the code too many times
    func testMaxAttemptsReached() {
        // WRONG
        app.keys["1"].tap()
        app.keys["2"].tap()
        app.keys["3"].tap()
        app.keys["4"].tap()
        app.keys["5"].tap()
        app.keys["5"].tap()
        sleep(1)
        
        // WRONG
        app.keys["1"].tap()
        app.keys["2"].tap()
        app.keys["3"].tap()
        app.keys["4"].tap()
        app.keys["5"].tap()
        app.keys["5"].tap()
        sleep(1)
        // WRONG
        app.keys["1"].tap()
        app.keys["2"].tap()
        app.keys["3"].tap()
        app.keys["4"].tap()
        app.keys["5"].tap()
        app.keys["5"].tap()
        sleep(1)
    }

}

//
//  FlappyBirdUITests.swift
//  FlappyBirdUITests
//
//  Created by bys on 22/08/2017.
//  Copyright © 2017 Fullstack.io. All rights reserved.
//

import XCTest
import AppCenterXCUITestExtensions
class FlappyBirdUITests: XCTestCase {
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        //continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        //XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
        //self.continueAfterFailure = true
        ACTLaunch.launch();
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
         //XCUIApplication().terminate()
    }
    
    func testExample() {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        //MCLabel.labelStep("Flappy")
       ACTLabel.labelStep("Given the app has launched")
       ACTLabel.labelStep("Then I %@ the %@ button %@ times",
                           args: getVaList(["touch", "red", "3"]))
        XCTAssert(true, "This test should always pass");
    }
    
}

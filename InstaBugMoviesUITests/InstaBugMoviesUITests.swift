//
//  InstaBugMoviesUITests.swift
//  InstaBugMoviesUITests
//
//  Created by Ahmed Rezik on 5/19/20.
//  Copyright © 2020 Ahmed Rezik. All rights reserved.
//

import XCTest



class InstaBugMoviesUITests: XCTestCase {
var app: XCUIApplication!
   
 
   
    override  func setUp() {
          continueAfterFailure = false
              app = XCUIApplication()
        app.launch()
    }
   
    
  
    func testIntialScreenLoadsCorrectly(){
        XCTAssertTrue(app.tables["DiscoverTableView"].exists)
    }

   
    func testDetailViewSegue(){
        let cellCount = app.tables.cells.count
        XCTAssertTrue(cellCount > 0)
        let firstCell = app.tables.cells.element(boundBy: 0)
        XCTAssertTrue(firstCell.exists)
        firstCell.tap()
    
        XCTAssertTrue(app.staticTexts["Overview"].exists)
            
    }
    
    
    func testUSerAddedMoviePopulatesTableView(){
        
        
        app.navigationBars["Discover"].buttons["Add"].tap()
        
        let enterMovieTitleTextField = app.textFields["Enter movie title"]
        enterMovieTitleTextField.tap()
        enterMovieTitleTextField.typeText("Test")
        app.pickerWheels["1970"].press(forDuration: 1.0);
        app/*@START_MENU_TOKEN@*/.buttons["Return"]/*[[".keyboards",".buttons[\"return\"]",".buttons[\"Return\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        app/*@START_MENU_TOKEN@*/.staticTexts["Choose photo"]/*[[".buttons[\"Choose photo\"].staticTexts[\"Choose photo\"]",".staticTexts[\"Choose photo\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
               app.collectionViews["PhotosGridView"].cells["Photo, Landscape, March 13, 2011, 2:17 AM"].children(matching: .other).element.tap()
        app/*@START_MENU_TOKEN@*/.staticTexts["Save"]/*[[".buttons[\"Save\"].staticTexts[\"Save\"]",".staticTexts[\"Save\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        XCTAssertTrue(app.tables["DiscoverTableView"].staticTexts["Test - 1970"].exists)
        
        
        
        
       
        
    }
    func testFailedResponse(){
        XCUIDevice.shared.siriService.activate(voiceRecognitionText: "Turn off wifi")
        XCUIDevice.shared.press(XCUIDevice.Button.home)
        app.launch()
    }
   

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTOSSignpostMetric.applicationLaunch]) {
                XCUIApplication().launch()
            }
        }
    }
}




//
//  AddMovieTests.swift
//  InstaBugMoviesTests
//
//  Created by Ahmed Rezik on 5/20/20.
//  Copyright © 2020 Ahmed Rezik. All rights reserved.
//

import XCTest
@testable import InstaBugMovies

class AddMovieTests: XCTestCase {

    var sut:AddMovieVC!
    
 
    override func setUp() {
         let storyboard = UIStoryboard(name: "Main", bundle: nil)
               let vc: AddMovieVC = storyboard.instantiateViewController(withIdentifier: "AddMovieVC") as! AddMovieVC
        sut = vc
       _ = vc.view
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
         sut = nil
   
    }
    
    func testImagePickerisNotNil(){
        XCTAssertNotNil(sut.imagePicker)
        
    }
    func testValuesInsidePickerViewComponent(){
        
        XCTAssertEqual(sut.numberOfComponents(in: sut.YearPicker), 1)
        
    }
    func testRowsInsidePickerComponent(){
        XCTAssertEqual(sut.pickerView(sut.YearPicker, numberOfRowsInComponent: 1), 61)
    }

    func testOverViewBorderWidth(){
        XCTAssertEqual(sut.overviewField.layer.borderWidth, 1.5)
    }
    func testOverViewCornerRadius(){
           XCTAssertEqual(sut.overviewField.layer.cornerRadius, 10)
       }
    
    func testPickerViewtitleForRow(){
        XCTAssertEqual(sut.pickerView(sut.YearPicker, titleForRow: 0, forComponent: 0), "1970")
    }
    
  

    
    

}

//
//  CustomMovieTests.swift
//  InstaBugMoviesTests
//
//  Created by Ahmed Rezik on 5/20/20.
//  Copyright © 2020 Ahmed Rezik. All rights reserved.
//

import XCTest
@testable import InstaBugMovies

class CustomMovieTests: XCTestCase {
    var sut: CustomMovie!
    override func setUp() {
        super.setUp()
        
    }
    override  func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func testStructIntializer(){
        let customMovie = CustomMovie(title: "", releaseYear: "", posterImage: UIImage(), overview: "")
    
        XCTAssertNotNil(customMovie)
    }
    

}

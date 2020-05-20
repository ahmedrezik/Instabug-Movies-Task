//
//  InstaBugMoviesTests.swift
//  InstaBugMoviesTests
//
//  Created by Ahmed Rezik on 5/19/20.
//  Copyright © 2020 Ahmed Rezik. All rights reserved.
//

import XCTest
@testable import InstaBugMovies

class APIClientTests: XCTestCase {

        
    func testMovieDownload(){
        let exp = expectation(description: "Loading Movies")
        TMDBClient.getMoviePopular(pageNumber: 1) { (data, _) in
            XCTAssertNotNil(data)
                   exp.fulfill()
               }
               waitForExpectations(timeout: 3)
               XCTAssertGreaterThan(ClassesModel.searchList.count, 0, "We should have loaded movies")
    }
    
    func testMovieError(){
        let exp = expectation(description: "Error Loading")
        TMDBClient.getMoviePopular(pageNumber: -1) { (_, error) in
            exp.fulfill()
            XCTAssertNotNil(error)
        }
        waitForExpectations(timeout: 5)
        
    }
   
    func testPosterDownload(){
        let exp = expectation(description: "Image Loading")
        TMDBClient.downloadPosterImage(path: "6") { (data, error) in
            XCTAssertNotNil(data)
            exp.fulfill()
            
        }
        waitForExpectations(timeout: 5)
        
    }

    
    


 

}

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
    var sut: DiscoverVC!
    //var sut2: TMDBClient!
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        try? super.setUpWithError()
        sut = DiscoverVC()
        

    }
    override func setUp() {
          super.setUp()
        
    
       
        
    }
    
//    func testSelectedIndexisEqualSelectedCell(){
//        performSelector(onMainThread: #selector(selectcell), with: .none, waitUntilDone: true)
//        XCTAssertEqual(sut.selectedIndex, 3, "They should be equal")
//    }
    
    
//    @objc func selectcell(){
//        sut.discoverTableView.selectRow(at: IndexPath(row: 3, section: 1), animated: true, scrollPosition: .none)
//    }
    
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

    
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        sut = nil
        super.tearDown()
    }

 

}

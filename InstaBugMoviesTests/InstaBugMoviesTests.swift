//
//  InstaBugMoviesTests.swift
//  InstaBugMoviesTests
//
//  Created by Ahmed Rezik on 5/19/20.
//  Copyright © 2020 Ahmed Rezik. All rights reserved.
//

import XCTest
@testable import InstaBugMovies

class InstaBugMoviesTests: XCTestCase {
    var sut: DiscoverVC!
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        try? super.setUpWithError()
      sut = UIStoryboard(name: "Main", bundle: nil)
      .instantiateInitialViewController() as? DiscoverVC
    }
    override class func setUp() {
          super.setUp()
          
        
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        sut = nil
        super.tearDown()
    }

 

}

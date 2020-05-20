//
//  DiscoveVCTests.swift
//  InstaBugMoviesTests
//
//  Created by Ahmed Rezik on 5/20/20.
//  Copyright © 2020 Ahmed Rezik. All rights reserved.
//

import XCTest
@testable import InstaBugMovies
class DiscoverVCTests: XCTestCase {
    var sut: DiscoverVC!
    
    override func setUp() {
        super.setUp()
          let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let vc: DiscoverVC = storyboard.instantiateViewController(withIdentifier: "DiscoverVC") as! DiscoverVC
         sut = vc
        _ = vc.view
        
    }
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func testSelectedIndexisEqualSelectedCellRow(){
        sut.tableView(sut.discoverTableView, didSelectRowAt: IndexPath(row: 0, section: 1))
        XCTAssertEqual(sut.selectedIndex, 0)
        
    }
   
    func testSelectedSectionisEqualSelectedCellSection(){
        sut.tableView(sut.discoverTableView, didSelectRowAt: IndexPath(row: 0, section: 1))
        XCTAssertEqual(sut.selectedSection, 1)
        
    }
    func testReloadingTableViewSection1(){
        sut.reloadTableView()
       let count =  sut.tableView(sut.discoverTableView, numberOfRowsInSection: 1)
        XCTAssertEqual(count, ClassesModel.searchList.count)
    }
    func testReloadingTableViewSection0(){
          sut.reloadTableView()
         let count =  sut.tableView(sut.discoverTableView, numberOfRowsInSection: 0)
        XCTAssertEqual(count, ClassesModel.userMovies.count)
      }
    
    
    
    

    
    

}

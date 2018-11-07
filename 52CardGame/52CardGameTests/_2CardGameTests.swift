//
//  _2CardGameTests.swift
//  52CardGameTests
//
//  Created by Administrator on 31/10/2018.
//  Copyright © 2018 mahesh lad. All rights reserved.
//

import XCTest
@testable import _2CardGame
var viewController : ViewController?
class _2CardGameTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        viewController = ViewController()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        viewController = nil
        
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testFourIsHigherThanAce() {
        if let vc = viewController {
          let isHigher = vc.NextCardIsHigher(firstValue: "A", secondValue: "4")
          XCTAssertTrue(isHigher, "4 is Higher than A")
        }
    }
    
    func testQueenIsHigherThanKing() {
        if let vc = viewController {
            let isHigher = vc.NextCardIsHigher(firstValue: "K", secondValue: "Q")
            XCTAssertTrue(isHigher, "Queen is Higher than King")
        }
    }

    func testSuitValueForSpades() {
         if let vc = viewController {
           let suitValue = vc.suitValue(suit: "spades")
            XCTAssertEqual("S", suitValue, "spades suit value is incorrect")
        }
    }
    
    func testSuitValueForHearts() {
        if let vc = viewController {
            let suitValue = vc.suitValue(suit: "hearts")
            XCTAssertEqual("H", suitValue, "hearts suit value is incorrect")
        }
    }
    
    func testSuitValueForClubs() {
        if let vc = viewController {
            let suitValue = vc.suitValue(suit: "clubs")
            XCTAssertEqual("C", suitValue, "clubs suit value is incorrect")
        }
    }
    
    func testSuitValueForDiamonds() {
        if let vc = viewController {
            let suitValue = vc.suitValue(suit: "diamonds")
            XCTAssertEqual("D", suitValue, "diamonds suit value is incorrect")
        }
    }
}

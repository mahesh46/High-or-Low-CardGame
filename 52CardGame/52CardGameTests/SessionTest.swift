//
//  SessionTest.swift
//  52CardGameTests
//
//  Created by Administrator on 01/11/2018.
//  Copyright © 2018 mahesh lad. All rights reserved.
//

import XCTest
@testable import _2CardGame

class SessionTest: XCTestCase {
var sessionUnderTest: URLSession!
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        sessionUnderTest = URLSession(configuration: URLSessionConfiguration.default)
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        sessionUnderTest = nil
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

    func testValidCallToHTTPStatusCode200() {
        // given
        let url = URL(string: "http://cards.davidneal.io/api/cards")
        // 1
        let promise = expectation(description: "Status code: 200")
        // when
        let dataTask = sessionUnderTest.dataTask(with: url!) { data, response, error in
            // then
            if let error = error {
                XCTFail("Error: \(error.localizedDescription)")
                return
            } else if let statusCode = (response as? HTTPURLResponse)?.statusCode {
                if statusCode == 200 {
                    // 2
                    promise.fulfill()
                } else {
                    XCTFail("Status code: \(statusCode)")
                }
            } }
        dataTask.resume()
        // 3
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testCallToiAPICompletes() {
        // given
        let url = URL(string: "http://cards.davidneal.io/api/cards")
        // 1
        let promise = expectation(description: "Completion handler invoked")
        var statusCode: Int?
        var responseError: Error?
        // when
        let dataTask = sessionUnderTest.dataTask(with: url!) { data, response, error in
            statusCode = (response as? HTTPURLResponse)?.statusCode
            responseError = error
            // 2
            promise.fulfill()
        }
        dataTask.resume()
        // 3
        waitForExpectations(timeout: 5, handler: nil)
        // then
        XCTAssertNil(responseError)
        XCTAssertEqual(statusCode, 200)
    }
}

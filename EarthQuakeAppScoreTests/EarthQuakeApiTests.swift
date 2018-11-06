//
//  EarthQuakeApiTests.swift
//  EarthQuakeAppScoreTests
//
//  Created by Soan Saini on 6/11/18.
//  Copyright © 2018 Soan Saini. All rights reserved.
//

import XCTest

class EarthQuakeApiTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testEarthQuakeValidFetch() {
        let apiClient = EarthquakeApiClient.init()
        let expectn = expectation(description: "Earth Quakes are fetched and Are parsed")
        apiClient.fetchFeed(completionHandler: { (result) in
            switch result {
            case .response(let data):
                XCTAssertTrue(!data.isEmpty)
                break
            case .error(error: let error):
                XCTFail("Error occured with Fetching Data\(error.localizedDescription)")
                break
            }
            expectn.fulfill()
        })
        // 3. Wait for the expectation to be fulfilled
        waitForExpectations(timeout: 4) { error in
            if let error = error {
                XCTFail("Time Out Occured while fetching and parsing data: \(error)")
            }
        }
    }
}

//
//  TMDB_KitabisaTests.swift
//  TMDB KitabisaTests
//
//  Created by Azmi Muhammad on 22/02/20.
//  Copyright © 2020 Azmi Muhammad. All rights reserved.
//

import XCTest
@testable import TMDB_Kitabisa

class TMDB_KitabisaTests: XCTestCase {
    
    var env: APIEnvironment!
    var bodyRequest: GetMoviesBodyRequest!
    let apiKey: String = "44755119354772a89e87cfd9ccef85f3"

    override func setUp() {
        bodyRequest = GetMoviesBodyRequest(apiKey: apiKey, page: 1)
        env = TMDBEnvironment()
    }

    override func tearDown() {
        bodyRequest = nil
        env = nil
    }

    func testExample() {
        let e = expectation(description: "Alamofire")
        let repo: MovieRepository = MovieRepository()
        repo.getMovies(withCategory: .nowPlaying, request: bodyRequest, onSuccess: { (output) in
            XCTAssertNotNil(output, "We got the response! \(output)")
            e.fulfill()
        }) { (err) in
            XCTAssertNil(err, "Whoops, error \(err)")
            e.fulfill()
        }
        waitForExpectations(timeout: 5.0, handler: nil)
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }

}

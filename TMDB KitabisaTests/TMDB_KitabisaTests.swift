//
//  TMDB_KitabisaTests.swift
//  TMDB KitabisaTests
//
//  Created by Azmi Muhammad on 22/02/20.
//  Copyright © 2020 Azmi Muhammad. All rights reserved.
//

import XCTest
import CoreData
@testable import TMDB_Kitabisa

class TMDB_KitabisaTests: XCTestCase {
    
    var env: APIEnvironment!
    var bodyRequest: GetMoviesBodyRequest!
    var reviewRequest: GetMovieReviewsBodyRequest!
    var context: NSManagedObjectContext!
    var localDB: LocalDBService<FavoriteMovie, MoviesOutput>!
    let apiKey: String = "44755119354772a89e87cfd9ccef85f3"
    let repo: MovieRepository = MovieRepository()

    override func setUp() {
        context = setUpInMemoryManagedObjectContext()
//        localDB = FavoriteMovieLocalDB(context: context)
        bodyRequest = GetMoviesBodyRequest(apiKey: apiKey, page: 1)
        reviewRequest = GetMovieReviewsBodyRequest(apiKey: apiKey, movieId: 123)
        env = TMDBEnvironment()
    }
    
    func setUpInMemoryManagedObjectContext() -> NSManagedObjectContext? {
        let moduleName = "TMDB_Kitabisa"

        // Create a new managed object model with updated entity class names
        var newEntities = [] as [NSEntityDescription]
        for (_, entity) in newEntities.enumerated() {
            let newEntity = entity.copy() as! NSEntityDescription
            newEntity.managedObjectClassName = "\(moduleName).\(entity.name)"
            newEntities.append(newEntity)
        }
        let newManagedObjectModel = NSManagedObjectModel()
        newManagedObjectModel.entities = newEntities

        let persistentStoreCoordinator = NSPersistentStoreCoordinator(managedObjectModel: newManagedObjectModel)
        do {
            try persistentStoreCoordinator.addPersistentStore(ofType: NSInMemoryStoreType, configurationName: nil, at: nil, options: nil)
            let managedObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
            managedObjectContext.persistentStoreCoordinator = persistentStoreCoordinator
            return managedObjectContext
        } catch {
            return nil
        }
    }

    override func tearDown() {
        bodyRequest = nil
        env = nil
        localDB = nil
    }

    func testExample() {
        let e = expectation(description: "Alamofire")
        repo.getMovies(withCategory: .nowPlaying, request: bodyRequest, onSuccess: { (output) in
            XCTAssertNotNil(output, "We got the response! \(output)")
            e.fulfill()
        }) { (err) in
            XCTAssertNil(err, "Whoops, error \(err)")
            e.fulfill()
        }
        waitForExpectations(timeout: 5.0, handler: nil)
    }
    
    func testGetReviews() {
        let e = expectation(description: "Alamofire")
        repo.getReviews(request: reviewRequest, onSuccess: { (output) in
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

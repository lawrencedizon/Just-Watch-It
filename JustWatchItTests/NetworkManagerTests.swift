//
//  NetworkManagerTests.swift
//  JustWatchItTests
//
//  Created by Lawrence Dizon on 5/18/21.
//

import XCTest
@testable import JustWatchIt

class NetworkManagerTests: XCTestCase {
    private var sut: NetworkManager!
    
    override func setUp() {
        super.setUp()
        sut = NetworkManager()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    //MARK: - Properties
    
    func test_domainURLString_shouldNotBeNil(){
        XCTAssertNotEqual(sut.domainURLString, nil)
    }
    
    //MARK: - Functions
    
    func test_fetchMovies_typeListpopular_shouldReturnSomething(){
        //sut.fetchMovies(type: .popular)
        //XCTAssertEqual(sut.fetchedMovies.count, 10) //Fetched should have some movies in it
    }
    
    func test_fetchMovies_typeListnowPlaying_shouldReturnSomething(){
        //sut.fetchMovies(type: .nowPlaying)
        
    }
    
    func test_fetchMovies_typeListupcoming_shouldReturnSomething(){
        //sut.fetchMovies(type: .upcoming)
        
    }
    
    func test_fetchMovies_typeListtopRated_shouldReturnSomething(){
        //sut.fetchMovies(type: .topRated)
        
    }
    
    func test_fetchMovies_queryemptyStringtypeListsearch_shouldReturnSomething(){
        //sut.fetchMovies(type: .search)
    }
    
}

//
//  SearchPresenterTests.swift
//  kakaobank_leehanwe_homeworkTests
//
//  Created by hanwe on 2021/03/21.
//

import XCTest
@testable import kakaobank_leehanwe_homework

class SearchPresenterTests: XCTestCase {
    
    let presenter: SearchPresenter = SearchPresenter(service: StubSearchService())
    
    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
    }
    
    
    func testGetAutoCompleteHistoryData() throws {
        let foo = self.presenter.getAutoCompleteHistoryData(keyword: "mov")
        XCTAssertEqual(foo.count, 2)
        var existValueSet: Set<String> = ["movie", "fun movie"]
        for i in 0..<foo.count {
            let searchedText: String = foo[i].searchText
            XCTAssertTrue(existValueSet.contains(searchedText))
            existValueSet.remove(searchedText)
        }
        XCTAssertFalse(existValueSet.count > 0)
    }
    
}

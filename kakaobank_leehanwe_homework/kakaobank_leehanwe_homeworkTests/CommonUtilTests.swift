//
//  CommonUtilTests.swift
//  kakaobank_leehanwe_homeworkTests
//
//  Created by hanwe on 2021/03/20.
//

import XCTest
@testable import kakaobank_leehanwe_homework

class CommonUtilTests: XCTestCase {
    
    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
    }
    
    func testConvertUtil() throws {
        let converted1: String = CommonUtil.over10000Convertor(originValue: 21000, keyword: "만")
        XCTAssertEqual(converted1, "2.1만")
        let converted2: String = CommonUtil.over10000Convertor(originValue: 20000, keyword: "만")
        XCTAssertEqual(converted2, "2만")
        let converted3: String = CommonUtil.over10000Convertor(originValue: 10001000, keyword: "만")
        XCTAssertEqual(converted3, "1000만")
    }

}

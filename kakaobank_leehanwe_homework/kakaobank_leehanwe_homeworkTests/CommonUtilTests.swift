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

    
    func testGetMBFromByte() throws {
        XCTAssertEqual(CommonUtil.getMBFromByte(byte: 366142464), "349.2")
        XCTAssertEqual(CommonUtil.getMBFromByte(byte: 366099825), "349.1")
    }
    
    func testIsUsableAppFromVersion() throws {
        XCTAssertFalse(CommonUtil.isUsableAppFromVersion(mySystemVersion: "10.9", requiredVersion: "11.5"))
        XCTAssertTrue(CommonUtil.isUsableAppFromVersion(mySystemVersion: "11.5", requiredVersion: "11.5"))
        XCTAssertTrue(CommonUtil.isUsableAppFromVersion(mySystemVersion: "11.5", requiredVersion: "11.4"))
        XCTAssertFalse(CommonUtil.isUsableAppFromVersion(mySystemVersion: "11.1", requiredVersion: "11.1.2"))
        XCTAssertTrue(CommonUtil.isUsableAppFromVersion(mySystemVersion: "11.1.1", requiredVersion: "11.1.1.0"))
    }
    
    @available(iOS 11.0, *)
    func testGetWhenReleaseDateKor() throws {
        
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withInternetDateTime]
        
        let testDate1Str: String = "2021-03-22T12:00:00Z"
        if let testDate1: Date = formatter.date(from: testDate1Str) {
            XCTAssertEqual(CommonUtil.getWhenReleaseDateKor(currentDate:testDate1,releaseDate: "2021-03-12T00:00:28Z"), "1주 전")
        }
        
        
        let testDate2Str: String = "2021-03-12T11:00:28Z"
        if let testDate2: Date = formatter.date(from: testDate2Str) {
            XCTAssertEqual(CommonUtil.getWhenReleaseDateKor(currentDate:testDate2,releaseDate: "2021-03-12T00:00:28Z"), "11시간 전")
        }
        
        let testDate3Str: String = "2023-03-13T00:00:28Z"
        if let testDate3: Date = formatter.date(from: testDate3Str) {
            XCTAssertEqual(CommonUtil.getWhenReleaseDateKor(currentDate:testDate3,releaseDate: "2021-03-12T00:00:28Z"), "2년 전")
        }
        
    }
}

//
//  StubSearchService.swift
//  kakaobank_leehanwe_homeworkTests
//
//  Created by hanwe on 2021/03/21.
//

@testable import kakaobank_leehanwe_homework
import UIKit
import SwiftyJSON


class StubSearchService: SearchServiceProtocol {
    func getData(keyword: String, page: UInt, limit: UInt, completeHandler: @escaping ([SearchData]) -> (), failureHandler: @escaping (Error) -> ()) {
        if let path = Bundle.main.path(forResource: "SaerchDummyData", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                print("작업해야해~!!!!! :\(jsonResult)")
            } catch {
                print("테스트 파일 읽기 오류")
            }
        }
    }
    
    func appendSearchHistory(searchedText: String) {
        //todo
    }
    
    func getSearchHistorys() -> Array<SearchHistoryData> {
        var returnArr: Array<SearchHistoryData> = []
        let item1: SearchHistoryData = SearchHistoryData()
        item1.searchText = "game"
        returnArr.append(item1)
        let item2: SearchHistoryData = SearchHistoryData()
        item2.searchText = "movie"
        returnArr.append(item2)
        let item3: SearchHistoryData = SearchHistoryData()
        item3.searchText = "fun movie"
        returnArr.append(item3)
        
        return returnArr
    }
    
    func deleteSearchHistroy(key: String, completeHandler: @escaping () -> (), failureHandler: @escaping (Error) -> ()) {
        //todo
    }
    

}

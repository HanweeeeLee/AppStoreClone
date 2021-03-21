//
//  SearchPresenter.swift
//  kakaobank_leehanwe_homework
//
//  Created by hanwe on 2021/03/19.
//

import UIKit

protocol SearchPresenterProtocol {
    func search(keyword: String, completeHandler: @escaping ([SearchData]) -> (), failureHandler: @escaping (Error) -> ())
    func getNextPageData(completeHandler: @escaping ([SearchData]) -> (), failureHandler: @escaping (Error) -> ())
    func getSearchHistorys() -> Array<SearchHistoryData>
    func deleteSearchHistroy(key: String, completeHandler: @escaping () -> (), failureHandler: @escaping (Error) -> ())
    func getAutoCompleteHistoryData(keyword: String) -> Array<SearchHistoryData>
}

class SearchPresenter: SearchPresenterProtocol {
    
    //MARK: IBOutlet
    
    //MARK: property
    
    let service: SearchServiceProtocol // MVP에서의 Model
    
    var currentSearchKeyword: String = ""
    var currentSearchPage: UInt = 1
    let limit: UInt = 10
    
    var isQuerying: Bool = false
    
    //MARK: lifeCycle
    
    init(service: SearchServiceProtocol) {
        self.service = service
    }
    
    //MARK: function
    func search(keyword: String, completeHandler: @escaping ([SearchData]) -> (), failureHandler: @escaping (Error) -> ()) {
        self.currentSearchPage = 1
        appendHistory(searched: keyword)
        self.currentSearchKeyword = keyword
        self.service.getData(keyword: self.currentSearchKeyword, page: self.currentSearchPage, limit: self.limit, completeHandler: { response in
            self.currentSearchPage += 1
            completeHandler(response)
        }, failureHandler: { err in
            failureHandler(err)
        })
    }
    
    func getNextPageData(completeHandler: @escaping ([SearchData]) -> (), failureHandler: @escaping (Error) -> ()) {
        if !isQuerying {
            self.isQuerying = true
            search(keyword: self.currentSearchKeyword) { [weak self] (response) in
                completeHandler(response)
                self?.isQuerying = false
            } failureHandler: { [weak self] (err) in
                failureHandler(err)
                self?.isQuerying = false
            }
        }
    }
    
    func getSearchHistorys() -> Array<SearchHistoryData> {
        return self.service.getSearchHistorys()
    }
    
    func deleteSearchHistroy(key: String, completeHandler: @escaping () -> (), failureHandler: @escaping (Error) -> ()) {
        self.service.deleteSearchHistroy(key: key, completeHandler: {
            completeHandler()
        }, failureHandler: { err in
            failureHandler(err)
        })
    }
    
    func getAutoCompleteHistoryData(keyword: String) -> Array<SearchHistoryData> {
        var returnArr: [SearchHistoryData] = []
        let currentSavedSearchHistoryData = self.service.getSearchHistorys()
        for i in 0..<currentSavedSearchHistoryData.count {
            let item = currentSavedSearchHistoryData[i]
            if item.searchText.contains(keyword) {
                returnArr.append(item)
            }
        }
        return returnArr
    }
    
    //MARK: private function
    
    private func appendHistory(searched: String) {
        self.service.appendSearchHistory(searchedText: searched)
    }
    
    //MARK: action
    
}

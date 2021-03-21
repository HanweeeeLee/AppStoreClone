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
}

class SearchPresenter: SearchPresenterProtocol {
    
    //MARK: IBOutlet
    
    //MARK: property
    
    let service: SearchService = SearchService() // MVP에서의 Model
    
    var currentSearchKeyword: String = ""
    var currentSearchPage: UInt = 1
    let limit: UInt = 10
    
    var isQuerying: Bool = false
    
    //MARK: lifeCycle
    
    //MARK: function
    func search(keyword: String, completeHandler: @escaping ([SearchData]) -> (), failureHandler: @escaping (Error) -> ()) {
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
            
        }
        else { //이미 쿼리중이라면
            
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
    
    //MARK: private function
    
    private func appendHistory(searched: String) {
        self.service.appendSearchHistory(searchedText: searched)
    }
    
    //MARK: action
    
}

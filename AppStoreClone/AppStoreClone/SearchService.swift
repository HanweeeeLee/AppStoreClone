//
//  SearchService.swift
//  AppStoreClone
//
//  Created by hanwe on 2021/03/20.
//

import UIKit
import SwiftyJSON
import RealmSwift

protocol SearchServiceProtocol {
    func getData(keyword: String, page: UInt, limit: UInt, completeHandler: @escaping ([SearchData]) -> (), failureHandler: @escaping (Error) -> ())
    func appendSearchHistory(searchedText: String)
    func getSearchHistorys() -> Array<SearchHistoryData>
    func deleteSearchHistroy(key: String, completeHandler: @escaping () -> (), failureHandler: @escaping (Error) -> ())
}

class SearchService: SearchServiceProtocol {
    
    //MARK: property
    var realm:Realm = try! Realm()
    var searchHistoryArr: Results<SearchHistoryData>?
    
    //MARK: lifeCycle
    
    init() {
        initRealm()
    }
    
    func initRealm() {
        self.searchHistoryArr = self.realm.objects(SearchHistoryData.self)
    }
    
    //MARK: function
    
    func getData(keyword: String, page: UInt, limit: UInt, completeHandler: @escaping ([SearchData]) -> (), failureHandler: @escaping (Error) -> ()) {
        ApiManager.query(url: APIDefine.simpleAPIURL(keyword: keyword, page: page, limit: limit), function: .get, header: nil, param: nil, requestType: .json, responseType: .json, completeHanlder: { response in
            let responseJson: JSON = JSON(response)
            let items: JSON = responseJson["results"]
            var modelArr: [SearchData] = []
            for i in 0..<items.count {
                let item = items[i]
                let itemData = item.rawString()?.data(using: .utf8)
                if let model: SearchData = SearchData.fromJson(jsonData: itemData, object: SearchData()) {
                    modelArr.append(model)
                }
            }
            completeHandler(modelArr)
        }, failureHandler: { err in
            failureHandler(err)
        })
    }
    
    func appendSearchHistory(searchedText: String) {
        try! realm.write {
            let item = SearchHistoryData()
            item.searchText = searchedText
            self.realm.add(item, update: .modified)
        }
    }
    
    func getSearchHistorys() -> Array<SearchHistoryData> {
        return Array(realm.objects(SearchHistoryData.self)).sorted(by: { $0.savedDate > $1.savedDate})
    }
    
    func deleteSearchHistroy(key: String, completeHandler: @escaping () -> (), failureHandler: @escaping (Error) -> ()) {
        do {
            try realm.write {
                guard let obj = self.realm.object(ofType: SearchHistoryData.self, forPrimaryKey: key) else {
                    return
                }
                self.realm.delete(obj)
                completeHandler()
            }
        } catch {
            print("Error")
        }
    }
    
    //MARK: private function
    
}

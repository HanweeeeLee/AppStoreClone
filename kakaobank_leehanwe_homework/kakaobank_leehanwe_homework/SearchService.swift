//
//  SearchService.swift
//  kakaobank_leehanwe_homework
//
//  Created by hanwe on 2021/03/20.
//

import UIKit
import SwiftyJSON

protocol SearchServiceProtocol {
    func getData(keyword: String, page: UInt, limit: UInt, completeHandler: @escaping ([SearchData]) -> (), failureHandler: @escaping (Error) -> ())
}

class SearchService: SearchServiceProtocol {
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
}

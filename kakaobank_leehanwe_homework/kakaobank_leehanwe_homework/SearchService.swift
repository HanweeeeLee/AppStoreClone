//
//  SearchService.swift
//  kakaobank_leehanwe_homework
//
//  Created by hanwe on 2021/03/20.
//

import UIKit

protocol SearchServiceProtocol {
    func getData(keyword: String, page: UInt, limit: UInt, completeHandler: @escaping ([SearchData]) -> (), failureHandler: @escaping (Error) -> ())
}

class SearchService: SearchServiceProtocol {
    func getData(keyword: String, page: UInt, limit: UInt, completeHandler: @escaping ([SearchData]) -> (), failureHandler: @escaping (Error) -> ()) {
        ApiManager.query(url: <#T##String#>, function: <#T##ApiManagerRequestFunction#>, header: <#T##[String : Any]?#>, param: <#T##[String : Any]?#>, requestType: <#T##ApiManagerType#>, responseType: <#T##ApiManagerType#>, completeHanlder: <#T##(Data) -> ()#>, failureHandler: <#T##(Error) -> ()#>)
    }
}

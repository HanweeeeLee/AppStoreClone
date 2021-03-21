//
//  APIDefine.swift
//  kakaobank_leehanwe_homework
//
//  Created by hanwe on 2021/03/20.
//

class APIDefine {
//    https://itunes.apple.com/search?term=배달&entity=software&limit=10
    static let baseURL: String = "https://itunes.apple.com/search"
    static let api: String = "/search?"
    static let keywordParamKey: String = "term="
    static let themeParam: String = "entity=software"
    static let limitParam: String = "limit="
    static let pageParamKey: String = "offset="
    
    static func simpleAPIURL(keyword: String, page: UInt, limit: UInt) -> String {
        return self.baseURL + self.api + self.keywordParamKey + keyword + "&" + themeParam + "&" + limitParam + "\(limit)" + "&" + pageParamKey + "\(page*limit + 1)"
    }

}

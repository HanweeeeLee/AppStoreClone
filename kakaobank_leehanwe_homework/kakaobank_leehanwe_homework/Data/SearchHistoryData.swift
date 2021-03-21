//
//  SearchHistoryData.swift
//  kakaobank_leehanwe_homework
//
//  Created by hanwe on 2021/03/21.
//

import UIKit
import SwiftyJSON
import RealmSwift

class SearchHistoryData: Object {
    @objc dynamic var searchText: String = ""
    @objc dynamic var savedDate: Date = Date()
    
    override class func primaryKey() -> String? {
        return "searchText"
    }
}

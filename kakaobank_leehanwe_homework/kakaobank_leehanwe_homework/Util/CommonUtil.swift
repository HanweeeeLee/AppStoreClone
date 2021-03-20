//
//  CommonUtil.swift
//  kakaobank_leehanwe_homework
//
//  Created by hanwe on 2021/03/20.
//

import UIKit

class CommonUtil: NSObject {
    static func over10000Convertor(originValue: UInt, keyword: String) -> String {
        var returnValue: String = ""
        if originValue >= 10000 {
            let divied = originValue/10000
            returnValue = "\(divied)"
            if 1000000 > originValue {
                let rest = originValue%10000
                if rest >= 1000 {
                    let restStringArr = Array("\(rest)")
                    returnValue = returnValue + "." + "\(restStringArr[0])"
                }
            }
            returnValue = returnValue + keyword
        }
        else {
            returnValue = "\(originValue)"
        }
        return returnValue
    }
}

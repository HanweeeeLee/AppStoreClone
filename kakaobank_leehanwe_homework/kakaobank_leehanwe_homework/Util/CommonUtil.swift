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
    
    static func getMBFromByte(byte: Int) -> String {
        return String(format: "%.1f", Float(Float(byte) / 1024 / 1024))
    }
    
    static func isUsableAppFromVersion(mySystemVersion: String, requiredVersion: String) -> Bool {
        var returnResult: Bool = false

        let splitMySystemVersion = mySystemVersion.split(separator: ".")
        let splitRequiredVersion = requiredVersion.split(separator: ".")
        let sorterCnt = splitMySystemVersion.count < splitRequiredVersion.count ? splitMySystemVersion.count : splitRequiredVersion.count
        for i in 0..<sorterCnt {
            guard let myVersionInt = Int(splitMySystemVersion[i]) else { returnResult = false ; break }
            guard let requiredVersionInt = Int(splitRequiredVersion[i]) else { returnResult = false ; break }
            if myVersionInt > requiredVersionInt {
                returnResult = true
            }
            else if myVersionInt == requiredVersionInt {
                if i == sorterCnt - 1 {
                    if splitRequiredVersion.count > splitMySystemVersion.count {
                        if let lastVersion = Int(splitRequiredVersion.last ?? "error") {
                            if lastVersion == 0 {
                                returnResult = true
                            }
                            else {
                                returnResult = false
                            }
                        }
                        else {
                            returnResult = false
                        }
                    }
                    else {
                        returnResult = true
                    }
                }
                else {
                    returnResult = true
                }
            }
            else {
                returnResult = false
                break
            }
        }
        return returnResult
    }
    
    @available(iOS 11.0, *)
    static func getWhenReleaseDateKor(currentDate:Date,releaseDate: String) -> String {
        var returnValue: String = ""
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withInternetDateTime]
        guard let date: Date = formatter.date(from: releaseDate) else {
            return ""
        }
        let offset = currentDate.timeIntervalSinceReferenceDate - date.timeIntervalSinceReferenceDate
        
        let minute: Int = Int(offset/(86400/24/60))
        let hour: Int = Int(offset/(86400/24))
        let days: Int = Int(offset/86400)
        let week: Int = Int(offset/(86400 * 7))
        let month: Int = Int(offset/(86400 * 31))
        let year: Int = Int(offset/(86400 * 365))
        
        if year != 0 {
            returnValue = "\(year)년 전"
        }
        else if month != 0 {
            returnValue = "\(month)달 전"
        }
        else if week != 0 {
            returnValue = "\(week)주 전"
        }
        else if days != 0 {
            returnValue = "\(days)일 전"
        }
        else if hour != 0 {
            returnValue = "\(hour)시간 전"
        }
        else {
            returnValue = "\(minute)분 전"
        }
        
        return returnValue
    }
}

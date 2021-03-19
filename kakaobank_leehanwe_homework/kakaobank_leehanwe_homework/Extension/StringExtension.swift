//
//  StringExtension.swift
//  kakaobank_leehanwe_homework
//
//  Created by hanwe on 2021/03/19.
//
import UIKit

extension String {
    var localized: String {
        
        UserDefaults.standard.set(NSLocale.current.languageCode, forKey: "i18n_language")
        let lang = UserDefaults.standard.string(forKey: "i18n_language")
        
        let path = Bundle.main.path(forResource: lang, ofType: "lproj")
        let bundle = Bundle(path: path!)
        
        return NSLocalizedString(self, tableName: nil, bundle: bundle!, value: "", comment: "")
    }
}

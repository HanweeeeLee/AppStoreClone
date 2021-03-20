//
//  ImageCacheManager.swift
//  kakaobank_leehanwe_homework
//
//  Created by hanwe on 2021/03/20.
//

import UIKit

class ImageCacheManager: NSObject {
    let cache = NSCache<NSString, UIImage>()
    static let shared: ImageCacheManager = {
        let instance = ImageCacheManager()
        return instance
    }()
}

//
//  UIImageViewExtension.swift
//  kakaobank_leehanwe_homework
//
//  Created by hanwe on 2021/03/20.
//
import UIKit

extension UIImageView {
    func downloadOrCachedImage(urlString: String) {
        DispatchQueue.global(qos: .default).async {
            if let cachedImage = ImageCacheManager.shared.cache.object(forKey: urlString as NSString) {
                DispatchQueue.main.async { [weak self] in
                    self?.image = cachedImage
                }
            } else {
                if let url = URL(string: urlString) {
                    URLSession.shared.dataTask(with: url) { data, response, error in
                        guard let data = data else { return }
                        if let image = UIImage(data: data) {
                            DispatchQueue.main.async { [weak self] in
                                ImageCacheManager.shared.cache.setObject(image, forKey: urlString as NSString)
                                self?.image = image
                            }
                        }
                    }.resume()
                }
            }
        }
    }
}

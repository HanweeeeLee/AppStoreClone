//
//  DetailPreViewCollectionViewCell.swift
//  kakaobank_leehanwe_homework
//
//  Created by hanwe on 2021/03/21.
//

import UIKit
import FSPagerView

class DetailPreViewCollectionViewCell: FSPagerViewCell {

    enum CellType {
        case phone
        case pad
    }
    
    //MARK: IBOutlet
    
    @IBOutlet weak var mainContainerView: UIView!
    @IBOutlet weak var imgView: UIImageView!
    
    //MARK: property
    
    var type: CellType = .phone {
        didSet {
            switch self.type {
            case .phone:
                break
            case .pad:
                break
            }
        }
    }
    
    var infoData: String? = nil {
        didSet {
            guard let info = infoData else { return }
            self.imageView?.downloadOrCachedImage(urlString: info)
        }
    }
    
    //MARK: lifeCycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        initUI()
    }
    
    //MARK: function
    
    func initUI() {
    }
    
    //MARK: action
    
    
    

}

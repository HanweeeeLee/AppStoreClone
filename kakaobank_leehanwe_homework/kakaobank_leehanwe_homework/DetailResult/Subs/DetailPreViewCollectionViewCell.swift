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
                self.mainContainerView.layer.cornerRadius = 30
                break
            case .pad:
                self.mainContainerView.layer.cornerRadius = 10
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
        self.mainContainerView.layer.cornerRadius = 30
        self.mainContainerView.layer.masksToBounds = true
        self.mainContainerView.clipsToBounds = true
    }
    
    //MARK: action
    
    
    

}

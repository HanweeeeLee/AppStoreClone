//
//  DetailInfoCollectionViewCell.swift
//  AppStoreClone
//
//  Created by hanwe on 2021/03/21.
//

import UIKit

class DetailInfoCollectionViewCell: UICollectionViewCell {

    
    enum CellType {
        case rating
        case image
        case string
    }
    
    //MARK: IBOutlet
    @IBOutlet weak var mainContainerView: UIView!
    @IBOutlet weak var lineView: UIView!
    @IBOutlet weak var lineViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var topLabel: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var centerLabel: UILabel!
    @IBOutlet weak var bottomLabel: UILabel!
    @IBOutlet weak var starContainerView: UIView!
    @IBOutlet weak var start1ImgView: UIImageView!
    @IBOutlet weak var start2ImgView: UIImageView!
    @IBOutlet weak var start3ImgView: UIImageView!
    @IBOutlet weak var start4ImgView: UIImageView!
    @IBOutlet weak var start5ImgView: UIImageView!
    
    //MARK: property
    
    var type: CellType = .string {
        didSet {
            switch self.type {
            case .rating:
                self.imgView.isHidden = true
                self.centerLabel.isHidden = false
                self.bottomLabel.isHidden = true
                self.starContainerView.isHidden = false
                break
            case .image:
                self.imgView.isHidden = false
                self.centerLabel.isHidden = true
                self.bottomLabel.isHidden = false
                self.starContainerView.isHidden = true
                break
            case .string:
                self.imgView.isHidden = true
                self.centerLabel.isHidden = false
                self.bottomLabel.isHidden = false
                self.starContainerView.isHidden = true
                break
            }
        }
    }
    
    //MARK: lifeCycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        initUI()
    }
    
    //MARK: function
    func initUI() {
        self.mainContainerView.backgroundColor = .white
        self.topLabel.font = UIFont(name: CommonDefine.FontLightKey, size: 10)
        self.topLabel.textColor = .lightGray
        self.centerLabel.font = UIFont(name: CommonDefine.FontBoldKey, size: 30)
        self.centerLabel.textColor = .lightGray
        self.bottomLabel.font = UIFont(name: CommonDefine.FontLightKey, size: 10)
        self.bottomLabel.textColor = .lightGray
        self.starContainerView.backgroundColor = .clear
        self.lineViewHeightConstraint.constant = 45
    }
    
    //MARK: action

}

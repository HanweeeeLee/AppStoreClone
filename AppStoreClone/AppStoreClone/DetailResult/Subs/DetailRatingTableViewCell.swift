//
//  DetailRatingTableViewCell.swift
//  AppStoreClone
//
//  Created by hanwe on 2021/03/21.
//

import UIKit

class DetailRatingTableViewCell: UITableViewCell {


    //MARK: IBOutlet
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var bestLabel: UILabel!
    @IBOutlet weak var allViewBtn: UIButton!
    @IBOutlet weak var starContainerView: UIView!
    @IBOutlet weak var progress1: UIProgressView!
    @IBOutlet weak var progress2: UIProgressView!
    @IBOutlet weak var progress3: UIProgressView!
    @IBOutlet weak var progress4: UIProgressView!
    @IBOutlet weak var progress5: UIProgressView!
    @IBOutlet weak var ratingTitleLabel: UILabel!
    
    //MARK: property
    
    var infoData: SearchData? = nil {
        didSet {
            guard let info = self.infoData else { return }
            self.ratingLabel.text = String(format: "%.1f",  info.averageUserRating)
            self.ratingTitleLabel.text = String(format: LocalizedMap.RATING_COUNT.localized, info.userRatingCount.withCommas())
        }
    }
    
    //MARK: lifeCycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        initUI()
    }
    
    //MARK: function
    
    func initUI() {
        self.titleLabel.font = UIFont(name: CommonDefine.FontBoldKey, size: 20)
        self.titleLabel.text = LocalizedMap.RATING_AND_REVIEW.localized
        self.ratingLabel.font = UIFont(name: CommonDefine.FontBoldKey, size: 40)
        self.bestLabel.text = LocalizedMap.MAX_RATING.localized
        self.bestLabel.textColor = .lightGray
        self.bestLabel.font = UIFont(name: CommonDefine.FontMediumKey, size: 15)
        self.allViewBtn.setTitle(LocalizedMap.SHOW_ALL_REVIEW.localized, for: .normal)
        self.starContainerView.backgroundColor = .clear
        self.ratingTitleLabel.font = UIFont(name: CommonDefine.FontMediumKey, size: 15)
        self.ratingTitleLabel.textColor = .lightGray
        self.ratingTitleLabel.text = String(format: LocalizedMap.RATING_COUNT.localized, "0")
    }
    
    //MARK: action
    @IBAction func allViewBtnAction(_ sender: Any) {
        print("리뷰 모두보기 클릭")
    }
    
    
}

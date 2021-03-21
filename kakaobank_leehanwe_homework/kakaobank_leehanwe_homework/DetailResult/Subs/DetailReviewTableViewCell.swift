//
//  DetailReviewTableViewCell.swift
//  kakaobank_leehanwe_homework
//
//  Created by hanwe on 2021/03/21.
//

import UIKit

class DetailReviewTableViewCell: UITableViewCell {

    //MARK: IBOutlet
    @IBOutlet weak var ratingTitleLabel: UILabel!
    @IBOutlet weak var star1Btn: UIButton!
    @IBOutlet weak var star2Btn: UIButton!
    @IBOutlet weak var star3Btn: UIButton!
    @IBOutlet weak var star4Btn: UIButton!
    @IBOutlet weak var star5Btn: UIButton!
    @IBOutlet weak var bubleView: UIView!
    @IBOutlet weak var commentNameLabel: UILabel!
    @IBOutlet weak var ratedStar1ImgVie: UIImageView!
    @IBOutlet weak var ratedStar2ImgVie: UIImageView!
    @IBOutlet weak var ratedStar3ImgVie: UIImageView!
    @IBOutlet weak var ratedStar4ImgVie: UIImageView!
    @IBOutlet weak var ratedStar5ImgVie: UIImageView!
    @IBOutlet weak var commentLabel: UILabel!
    @IBOutlet weak var writeReviewTitleLabel: UILabel!
    @IBOutlet weak var helpTitleLabel: UILabel!
    //MARK: property
    //MARK: lifeCycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        initUI()
    }
    
    //MARK: function
    
    func initUI() {
        
    }
    
    //MARK: action
    @IBAction func writeReViewAction(_ sender: Any) {
    }
    @IBAction func helpAction(_ sender: Any) {
    }
    
    
}

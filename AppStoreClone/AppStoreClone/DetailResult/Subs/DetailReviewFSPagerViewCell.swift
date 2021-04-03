//
//  DetailReviewFSPagerViewCell.swift
//  AppStoreClone
//
//  Created by hanwe on 2021/03/21.
//

import UIKit
import FSPagerView

class DetailReviewFSPagerViewCell: FSPagerViewCell {

    //MARK: IBOutlet
    @IBOutlet weak var commentNameLabel: UILabel!
    @IBOutlet weak var ratedStar1ImgVie: UIImageView!
    @IBOutlet weak var ratedStar2ImgVie: UIImageView!
    @IBOutlet weak var ratedStar3ImgVie: UIImageView!
    @IBOutlet weak var ratedStar4ImgVie: UIImageView!
    @IBOutlet weak var ratedStar5ImgVie: UIImageView!
    @IBOutlet weak var commentLabel: UILabel!
    
    //MARK: property
    
    //MARK: lifeCycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        initUI()
    }
    
    //MARK: function
    
    func initUI() {
        self.backgroundColor = UIColor(red: 220/255, green: 220/255, blue: 220/255, alpha: 1)
        self.layer.cornerRadius = 10
        self.commentNameLabel.font = UIFont(name: CommonDefine.FontBoldKey, size: 12)
        self.commentNameLabel.text = "이곳이 리뷰 제목이 올라오는곳!"
        self.commentLabel.numberOfLines = 30
        self.commentLabel.text = "이곳은 바로 리뷰를 쓰는곳입니다. 데이터를 받아올 수 있다면 넣었을텐데.."
    }
    
    //MARK: action

}

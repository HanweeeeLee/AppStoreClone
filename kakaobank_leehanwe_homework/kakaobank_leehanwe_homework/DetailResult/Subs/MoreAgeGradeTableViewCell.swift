//
//  MoreAgeGradeTableViewCell.swift
//  kakaobank_leehanwe_homework
//
//  Created by hanwe on 2021/03/23.
//

import UIKit

class MoreAgeGradeTableViewCell: UITableViewCell {
    
    //MARK: IBOutlet
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var moreInfoLabel: UILabel!
    //MARK: property
    
    //MARK: lifeCycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        initUI()
    }
    
    //MARK: function
    
    func initUI() {
        self.titleLabel.text = "연령 등급"
        self.moreInfoLabel.text = "더 알아보기"
    }
    
    //MARK: action
    
}

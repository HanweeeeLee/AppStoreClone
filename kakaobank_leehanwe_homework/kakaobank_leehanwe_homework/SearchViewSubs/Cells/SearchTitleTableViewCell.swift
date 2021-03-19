//
//  SearchTitleTableViewCell.swift
//  kakaobank_leehanwe_homework
//
//  Created by hanwe on 2021/03/19.
//

import UIKit

class SearchTitleTableViewCell: UITableViewCell {
    
    //MARK: IBOutlet
    @IBOutlet weak var titleLabel: UILabel!
    
    //MARK: property
    
    //MARK: lifeCycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        initUI()
    }
    
    //MARK: function
    
    func initUI() {
        self.titleLabel.font = UIFont(name: CommonDefine.FontBoldKey, size: CommonDefine.FontTitleSize)
        self.titleLabel.text = LocalizedMap.TITLE_SEARCH_VIEW_CONTROLLER.localized
    }
    
    //MARK: action
    @IBAction func profileAction(_ sender: Any) {
        print("프로필도 띄워줘야하나?")
    }
    
    
}

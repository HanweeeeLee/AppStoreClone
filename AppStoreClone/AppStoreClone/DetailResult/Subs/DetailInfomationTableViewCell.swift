//
//  DetailInfomationTableViewCell.swift
//  AppStoreClone
//
//  Created by hanwe on 2021/03/21.
//

import UIKit

class DetailInfomationTableViewCell: UITableViewCell {
    
    //MARK: IBOutlet
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contentsTitleLabel: UILabel!
    @IBOutlet weak var infoLabel: UILabel!
    //MARK: property
    
    //MARK: lifeCycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        initUI()
    }
    
    //MARK: function
    
    func initUI() {
        self.titleLabel.font = UIFont(name: CommonDefine.FontBoldKey, size: 25)
        self.titleLabel.text = "정보"
        self.contentsTitleLabel.textColor = .lightGray
    }
    
    //MARK: action
    
    
}

//
//  MoreCompatibilityTableViewCell.swift
//  kakaobank_leehanwe_homework
//
//  Created by hanwe on 2021/03/23.
//

import UIKit

class MoreCompatibilityTableViewCell: UITableViewCell {

    //MARK: IBOutlet
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var osLabel: UILabel!
    //MARK: property
    
    //MARK: lifeCycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        initUI()
    }
    
    //MARK: function
    
    func initUI() {
        self.titleLabel.text = "호환성"
        self.nameLabel.text = "iPhone"
    }
    
    //MARK: action
    
}

//
//  DetailInfomationTableViewCell.swift
//  kakaobank_leehanwe_homework
//
//  Created by hanwe on 2021/03/21.
//

import UIKit

class DetailInfomationTableViewCell: UITableViewCell {

    enum CellType {
        case top
        case normal
        case buttonWith
        case blue
    }
    
    //MARK: IBOutlet
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contentsTitleLabel: UILabel!
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var button: UIButton!
    //MARK: property
    
    var type: CellType = .normal {
        didSet {
            switch self.type {
            case .normal:
                break
            case .buttonWith:
                break
            case .top:
                break
            case .blue:
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
        self.titleLabel.font = UIFont(name: CommonDefine.FontBoldKey, size: 15)
        self.titleLabel.text = "정보"
//        self.titleLabel.isHidden = true
        self.contentsTitleLabel.textColor = .lightGray
//        self.button.isHidden = true
    }
    
    //MARK: action
    
    
}

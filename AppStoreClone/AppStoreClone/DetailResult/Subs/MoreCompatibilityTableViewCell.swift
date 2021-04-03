//
//  MoreCompatibilityTableViewCell.swift
//  AppStoreClone
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
    
    var supportedDevice: [String]? = nil
    var minVersion: String = ""
    
    //MARK: function
    
    func initUI() {
        self.titleLabel.text = "호환성"
        self.nameLabel.text = "iPhone"
        self.osLabel.numberOfLines = 200
    }
    
    func refreshUI() {
        var appendString: String = ""
        if let supported = self.supportedDevice {
            if supported.count > 0 {
                appendString = "\n\n"
                for i in 0..<supported.count {
                    appendString = appendString + "· \(supported[i])" + "\n"
                }
            }
        }
        self.osLabel.text = "iOS " + self.minVersion + " 이상 필요." + appendString
    }
    
    //MARK: action
    
}

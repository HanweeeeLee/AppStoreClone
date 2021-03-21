//
//  DetailContentsTableViewCell.swift
//  kakaobank_leehanwe_homework
//
//  Created by hanwe on 2021/03/21.
//

import UIKit

class DetailContentsTableViewCell: UITableViewCell {

    
    //MARK: IBOutlet
    @IBOutlet weak var contentsLabel: UILabel!
    @IBOutlet weak var moreBtn: UIButton!
    @IBOutlet weak var companyLabel: UILabel!
    @IBOutlet weak var developLabel: UILabel!
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
    
    @IBAction func moreAction(_ sender: Any) {
    }
    @IBAction func devAction(_ sender: Any) {
    }
}

//
//  DetailReleaseNoteTableViewCell.swift
//  kakaobank_leehanwe_homework
//
//  Created by hanwe on 2021/03/21.
//

import UIKit

class DetailReleaseNoteTableViewCell: UITableViewCell {

    //MARK: IBOutlet
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var versionLabel: UILabel!
    @IBOutlet weak var contentsLabel: UILabel!
    @IBOutlet weak var versionRecordBtn: UIButton!
    @IBOutlet weak var latestUpdateDateLabel: UILabel!
    
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
    @IBAction func versionRecordAction(_ sender: Any) {
    }
    
    
}

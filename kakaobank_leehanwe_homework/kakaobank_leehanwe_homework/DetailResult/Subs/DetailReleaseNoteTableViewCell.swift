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
    
    var infoData: SearchData? = nil {
        didSet {
            guard let info = self.infoData else { return }
            self.versionLabel.text = info.version
            self.contentsLabel.text = info.releaseNotes
//            latestUpdateDateLabel.text = todo 
        }
    }
    
    //MARK: lifeCycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        initUI()
    }
    
    //MARK: function
    
    func initUI() {
        self.titleLabel.font = UIFont(name: CommonDefine.FontBoldKey, size: 30)
        self.titleLabel.text = LocalizedMap.NEW_FUNCTION.localized
        self.versionRecordBtn.setTitle(LocalizedMap.VERSION_HISTORY.localized, for: .normal)
        self.latestUpdateDateLabel.textColor = .lightGray
    }
    
    //MARK: action
    @IBAction func versionRecordAction(_ sender: Any) {
        print("버전 기록 누름")
    }
    
    
}

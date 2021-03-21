//
//  DetailHeaderTableViewCell.swift
//  kakaobank_leehanwe_homework
//
//  Created by hanwe on 2021/03/21.
//

import UIKit

class DetailHeaderTableViewCell: UITableViewCell {

    //MARK: IBOutlet
    @IBOutlet weak var mainContainerView: UIView!
    @IBOutlet weak var iconImgView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!
    @IBOutlet weak var downloadBtnView: UIView!
    @IBOutlet weak var downloadLabel: UILabel!
    
    //MARK: property
    
    var infoData: SearchData? = nil {
        didSet {
            guard let info = self.infoData else { return }
            self.iconImgView.downloadOrCachedImage(urlString: info.icon100)
            self.titleLabel.text = info.trackName
            self.subTitleLabel.text = info.trackCensoredName
        }
    }
    
    //MARK: lifeCycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        initUI()
    }
    
    //MARK: function
    
    func initUI() {
        self.mainContainerView.backgroundColor = .clear
        self.iconImgView.layer.cornerRadius = 15
        self.titleLabel.font = UIFont(name: CommonDefine.FontMediumKey, size: 20)
        self.titleLabel.textColor = .black
        
        self.subTitleLabel.font = UIFont(name: CommonDefine.FontLightKey, size: 10)
        self.subTitleLabel.textColor = .lightGray
        
        self.downloadBtnView.layer.cornerRadius = 10
        self.downloadBtnView.backgroundColor = UIColor(red: 51, green: 51, blue: 255, alpha: 1)
        
        self.downloadLabel.font =  UIFont(name: CommonDefine.FontMediumKey, size: 12)
        self.downloadLabel.textColor = .white
        self.downloadLabel.text = LocalizedMap.DOWNLOAD_SEARCH_RESULT_TABLE_VIEW_CELL.localized
        
    }
    //MARK: action
    @IBAction func downloadAction(_ sender: Any) {
        print("앱 다운로드 버튼 눌림")
    }
    @IBAction func shareAction(_ sender: Any) {
        print("앱 공유 버튼 눌림")
    }
}

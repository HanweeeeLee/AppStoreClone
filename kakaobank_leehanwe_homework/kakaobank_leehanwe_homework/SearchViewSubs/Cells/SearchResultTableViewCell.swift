//
//  SearchResultTableViewCell.swift
//  kakaobank_leehanwe_homework
//
//  Created by hanwe on 2021/03/20.
//

import UIKit

class SearchResultTableViewCell: UITableViewCell {
    //MARK: IBOutlet
    @IBOutlet weak var mainContainerView: UIView!
    @IBOutlet weak var iconImgView: UIImageView!
    @IBOutlet weak var downloadBtnView: UIView!
    @IBOutlet weak var downloadBtn: UIButton!
    @IBOutlet weak var topContainerView: UIView!
    @IBOutlet weak var appNameLabel: UILabel!
    @IBOutlet weak var appSubTitleLabel: UILabel!
    @IBOutlet weak var starContainerView: UIView!
    @IBOutlet weak var starImgView1: UIImageView!
    @IBOutlet weak var starImgView2: UIImageView!
    @IBOutlet weak var starImgView3: UIImageView!
    @IBOutlet weak var starImgView4: UIImageView!
    @IBOutlet weak var starImgView5: UIImageView!
    @IBOutlet weak var downloadCntLabel: UILabel!
    @IBOutlet weak var screenShotImgView1: UIImageView!
    @IBOutlet weak var screenShotImgView2: UIImageView!
    @IBOutlet weak var screenShotImgView3: UIImageView!
    
    //MARK: property
    
    var infoData: SearchData? {
        didSet {
            guard let info = self.infoData else { return }
            print("info:\(info)")
            
        }
    }
    //MARK: lifeCycle
    override func awakeFromNib() {
        super.awakeFromNib()
        initUI()
    }
    //MARK: function
    
    func initUI() {
        self.mainContainerView.backgroundColor = .white
        self.downloadBtnView.layer.cornerRadius = 15
        self.downloadBtnView.backgroundColor = .lightGray
        self.downloadBtn.setTitle(LocalizedMap.DOWNLOAD_SEARCH_RESULT_TABLE_VIEW_CELL.localized, for: .normal)
        self.topContainerView.backgroundColor = .clear
//        self.appNameLabel.font =
//        self.appNameLabel.text =
//        self.appNameLabel.textColor =
        
        //        self.appSubTitleLabel.font =
        //        self.appSubTitleLabel.text =
        //        self.appSubTitleLabel.textColor =
        
        self.starContainerView.backgroundColor = .clear
        
//        self.downloadCntLabel.font =
        //        self.downloadCntLabel.text =
        //        self.downloadCntLabel.textColor =
    }
    
    //MARK: action
    @IBAction func downloadAction(_ sender: Any) {
    }
    

    
}

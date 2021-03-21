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
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var topViewHeightConstraint: NSLayoutConstraint!
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
            DispatchQueue.main.async { [weak self] in
                self?.iconImgView.downloadOrCachedImage(urlString: info.icon60)
                for i in 0..<info.screenshotUrls.count {
                    if i == 0 {
                        self?.screenShotImgView1.downloadOrCachedImage(urlString: info.screenshotUrls[i])
                    }
                    else if i == 1 {
                        self?.screenShotImgView2.downloadOrCachedImage(urlString: info.screenshotUrls[i])
                    }
                    else if i == 2 {
                        self?.screenShotImgView3.downloadOrCachedImage(urlString: info.screenshotUrls[i])
                    }
                    else {
                        break
                    }
                }
                self?.appNameLabel.text = info.trackName
                self?.appSubTitleLabel.text = info.trackCensoredName
                self?.makeStartImg(rating: info.averageUserRating)
                self?.downloadCntLabel.text = CommonUtil.over10000Convertor(originValue: UInt(info.userRatingCount), keyword: "만")
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
        self.mainContainerView.backgroundColor = .white
        self.downloadBtnView.layer.cornerRadius = 10
        self.topView.backgroundColor = .clear
        self.downloadBtnView.backgroundColor = .lightGray
        self.downloadBtn.setTitle(LocalizedMap.DOWNLOAD_SEARCH_RESULT_TABLE_VIEW_CELL.localized, for: .normal)
        self.topContainerView.backgroundColor = .clear
        self.iconImgView.layer.cornerRadius = 10
        self.screenShotImgView1.layer.cornerRadius = 10
        self.screenShotImgView2.layer.cornerRadius = 10
        self.screenShotImgView3.layer.cornerRadius = 10
        self.appNameLabel.font = UIFont(name: CommonDefine.FontMediumKey, size: 15)
        self.appNameLabel.textColor = .black
        
        self.appSubTitleLabel.font = UIFont(name: CommonDefine.FontLightKey, size: 10)
        self.appSubTitleLabel.textColor = .lightGray
        
        self.starContainerView.backgroundColor = .clear
        
        self.downloadCntLabel.font = UIFont(name: CommonDefine.FontLightKey, size: 10)
        self.downloadCntLabel.textColor = UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 1)
    }
    
    private func makeStartImg(rating: Float) {
        if rating == 5 {
            self.starImgView1.image = UIImage(systemName: "star.fill")
            self.starImgView2.image = UIImage(systemName: "star.fill")
            self.starImgView3.image = UIImage(systemName: "star.fill")
            self.starImgView4.image = UIImage(systemName: "star.fill")
            self.starImgView5.image = UIImage(systemName: "star.fill")
        }
        else if rating >= 4.5 {
            self.starImgView1.image = UIImage(systemName: "star.fill")
            self.starImgView2.image = UIImage(systemName: "star.fill")
            self.starImgView3.image = UIImage(systemName: "star.fill")
            self.starImgView4.image = UIImage(systemName: "star.fill")
            self.starImgView5.image = UIImage(systemName: "star.leadinghalf.fill")
        }
        else if rating >= 4 {
            self.starImgView1.image = UIImage(systemName: "star.fill")
            self.starImgView2.image = UIImage(systemName: "star.fill")
            self.starImgView3.image = UIImage(systemName: "star.fill")
            self.starImgView4.image = UIImage(systemName: "star.fill")
            self.starImgView5.image = UIImage(systemName: "star")
        }
        else if rating >= 3.5 {
            self.starImgView1.image = UIImage(systemName: "star.fill")
            self.starImgView2.image = UIImage(systemName: "star.fill")
            self.starImgView3.image = UIImage(systemName: "star.fill")
            self.starImgView4.image = UIImage(systemName: "star.leadinghalf.fill")
            self.starImgView5.image = UIImage(systemName: "star")
        }
        else if rating >= 3 {
            self.starImgView1.image = UIImage(systemName: "star.fill")
            self.starImgView2.image = UIImage(systemName: "star.fill")
            self.starImgView3.image = UIImage(systemName: "star.fill")
            self.starImgView4.image = UIImage(systemName: "star")
            self.starImgView5.image = UIImage(systemName: "star")
        }
        else if rating >= 2.5 {
            self.starImgView1.image = UIImage(systemName: "star.fill")
            self.starImgView2.image = UIImage(systemName: "star.fill")
            self.starImgView3.image = UIImage(systemName: "star.leadinghalf.fill")
            self.starImgView4.image = UIImage(systemName: "star")
            self.starImgView5.image = UIImage(systemName: "star")
        }
        else if rating >= 2 {
            self.starImgView1.image = UIImage(systemName: "star.fill")
            self.starImgView2.image = UIImage(systemName: "star.fill")
            self.starImgView3.image = UIImage(systemName: "star")
            self.starImgView4.image = UIImage(systemName: "star")
            self.starImgView5.image = UIImage(systemName: "star")
        }
        else if rating >= 1.5 {
            self.starImgView1.image = UIImage(systemName: "star.fill")
            self.starImgView2.image = UIImage(systemName: "star.leadinghalf.fill")
            self.starImgView3.image = UIImage(systemName: "star")
            self.starImgView4.image = UIImage(systemName: "star")
            self.starImgView5.image = UIImage(systemName: "star")
        }
        else if rating >= 1 {
            self.starImgView1.image = UIImage(systemName: "star.fill")
            self.starImgView2.image = UIImage(systemName: "star")
            self.starImgView3.image = UIImage(systemName: "star")
            self.starImgView4.image = UIImage(systemName: "star")
            self.starImgView5.image = UIImage(systemName: "star")
        }
        else {
            self.starImgView1.image = UIImage(systemName: "star.leadinghalf.fill")
            self.starImgView2.image = UIImage(systemName: "star")
            self.starImgView3.image = UIImage(systemName: "star")
            self.starImgView4.image = UIImage(systemName: "star")
            self.starImgView5.image = UIImage(systemName: "star")
        }
    }
    //MARK: action
    @IBAction func downloadAction(_ sender: Any) {
        print("다운로드 클릭")
    }
    

    
}

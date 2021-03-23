//
//  DetailPreViewTableViewCell.swift
//  kakaobank_leehanwe_homework
//
//  Created by hanwe on 2021/03/21.
//

import UIKit
import FSPagerView

protocol DetaiPhonePreViewTableViewCellDelegate: DetailViewCommonProtocol{
    func switchPreviewMode()
}

class DetaiPhonePreViewTableViewCell: UITableViewCell {
    
    

    //MARK: IBOutlet
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var iPhonePreviewPagerView: FSPagerView!
    @IBOutlet weak var iPhoneConainerView: UIView!
    @IBOutlet weak var iPhoneContentsLabel: UILabel!
    @IBOutlet weak var iPadContainerView: UIView!
    @IBOutlet weak var iPadContentsLabel: UILabel!
    
    //MARK: property
    
    var isMoreMode: Bool = false
    
    var originIPadPreviewHeightConstraint: CGFloat = 0
    
    var infoData: SearchData? = nil {
        didSet {
            guard let info = self.infoData else { return }
            if info.ipadScreenshotUrls.count > 0 {
                self.iPadContainerView.isHidden = false
                self.iPhoneConainerView.isHidden = true
            }
        }
    }
    
    weak var delegate: DetaiPhonePreViewTableViewCellDelegate?
    
    var indexPath: IndexPath? = nil
    
    //MARK: lifeCycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        initUI()
    }
    
    //MARK: function
    func initUI() {
        self.titleLabel.font = UIFont(name: CommonDefine.FontBoldKey, size: 25)
        self.titleLabel.text = "미리보기"
        self.iPhonePreviewPagerView.delegate = self
        self.iPhonePreviewPagerView.dataSource = self
        self.iPhonePreviewPagerView.backgroundColor = .clear
        self.iPhonePreviewPagerView.register(UINib(nibName: "DetailPreViewCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "DetailPreViewCollectionViewCell")
        self.iPhonePreviewPagerView.interitemSpacing = 10
        self.iPhonePreviewPagerView.itemSize = self.iPhonePreviewPagerView.frame.size.applying(CGAffineTransform(scaleX: 0.7, y: 0.9));
        self.iPhoneContentsLabel.text = "iPhone"
        self.iPadContentsLabel.text = "iPhone, iPad"
        self.iPadContainerView.isHidden = true
    }
    
    //MARK: action
    @IBAction func showIPadPreviewAction(_ sender: Any) {
        self.delegate?.switchPreviewMode()
        guard let path = self.indexPath else {
            return
        }
        self.delegate?.reloadTableView(indexPath: path)
    }
    
}

extension DetaiPhonePreViewTableViewCell: FSPagerViewDelegate, FSPagerViewDataSource {
    func numberOfItems(in pagerView: FSPagerView) -> Int {
        var returnValue: Int = 0
        if pagerView == self.iPhonePreviewPagerView {
            returnValue = self.infoData?.screenshotUrls.count ?? 0
        }
        else {
            returnValue = self.infoData?.ipadScreenshotUrls.count ?? 0
        }
        return returnValue
    }
    
    func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell: DetailPreViewCollectionViewCell = pagerView.dequeueReusableCell(withReuseIdentifier: "DetailPreViewCollectionViewCell", at: index) as! DetailPreViewCollectionViewCell
        if pagerView == self.iPhonePreviewPagerView {
            cell.type = .phone
            cell.infoData = self.infoData?.screenshotUrls[index] ?? ""
            cell.layer.cornerRadius = 25
            cell.layer.masksToBounds = true
        }
        else {
            cell.type = .pad
            cell.infoData = self.infoData?.ipadScreenshotUrls[index] ?? ""
            cell.layer.cornerRadius = 10
            cell.layer.masksToBounds = true
        }
        return cell
    }
    
}

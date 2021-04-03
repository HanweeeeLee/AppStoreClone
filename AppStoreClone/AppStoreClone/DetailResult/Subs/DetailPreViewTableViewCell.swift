//
//  DetailPreViewTableViewCell.swift
//  AppStoreClone
//
//  Created by hanwe on 2021/03/21.
//

import UIKit
import FSPagerView

class DetailPreViewTableViewCell: UITableViewCell {
    
    

    //MARK: IBOutlet
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var iPhonePreviewPagerView: FSPagerView!
    @IBOutlet weak var iPhoneConainerView: UIView!
    @IBOutlet weak var iPhoneContentsLabel: UILabel!
    @IBOutlet weak var iPadPreviewPagerView: FSPagerView!
    @IBOutlet weak var iPadPreviewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var onlyIPadLabel: UILabel!
    @IBOutlet weak var onlyiPadContainerView: UIView!
    
    //MARK: property
    
    var isMoreMode: Bool = false
    
    var originIPadPreviewHeightConstraint: CGFloat = 0
    
    var infoData: SearchData? = nil
    
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
        self.iPadPreviewPagerView.delegate = self
        self.iPadPreviewPagerView.dataSource = self
        self.iPadPreviewPagerView.backgroundColor = .clear
        self.iPadPreviewPagerView.register(UINib(nibName: "DetailPreViewCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "DetailPreViewCollectionViewCell")
        self.iPadPreviewPagerView.interitemSpacing = 10
        self.iPadPreviewPagerView.itemSize = self.iPadPreviewPagerView.frame.size.applying(CGAffineTransform(scaleX: 0.7, y: 0.9));
        self.originIPadPreviewHeightConstraint = self.iPadPreviewHeightConstraint.constant
        self.onlyIPadLabel.text = "iPad"
    }
    
    //MARK: action
    
}

extension DetailPreViewTableViewCell: FSPagerViewDelegate, FSPagerViewDataSource {
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

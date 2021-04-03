//
//  DetailReviewTableViewCell.swift
//  AppStoreClone
//
//  Created by hanwe on 2021/03/21.
//

import UIKit
import FSPagerView

class DetailReviewTableViewCell: UITableViewCell {

    //MARK: IBOutlet
    @IBOutlet weak var ratingTitleLabel: UILabel!
    @IBOutlet weak var star1Btn: UIButton!
    @IBOutlet weak var star2Btn: UIButton!
    @IBOutlet weak var star3Btn: UIButton!
    @IBOutlet weak var star4Btn: UIButton!
    @IBOutlet weak var star5Btn: UIButton!
    @IBOutlet weak var bubleView: FSPagerView!
    @IBOutlet weak var writeReviewTitleLabel: UILabel!
    @IBOutlet weak var helpTitleLabel: UILabel!
    
    //MARK: property
    //MARK: lifeCycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        initUI()
    }
    
    //MARK: function
    
    func initUI() {
        self.bubleView.backgroundColor = .clear
        self.bubleView.delegate = self
        self.bubleView.dataSource = self
        self.bubleView.register(UINib(nibName: "DetailReviewFSPagerViewCell", bundle: nil), forCellWithReuseIdentifier: "DetailReviewFSPagerViewCell")
        self.ratingTitleLabel.font = UIFont(name: CommonDefine.FontMediumKey, size: 15)
        self.ratingTitleLabel.textColor = UIColor(red: 220/255, green: 220/255, blue: 220/255, alpha: 1)
        self.ratingTitleLabel.text = LocalizedMap.RATING_TAP.localized
        self.writeReviewTitleLabel.text = LocalizedMap.WRITE_REVIEW.localized
        self.helpTitleLabel.text = LocalizedMap.HEL_APP.localized
        self.bubleView.interitemSpacing = 10
        self.bubleView.itemSize = self.bubleView.frame.size.applying(CGAffineTransform(scaleX: 0.7, y: 0.9));
        
    }
    
    //MARK: action
    @IBAction func writeReViewAction(_ sender: Any) {
        print("리뷰 작성 눌림")
    }
    @IBAction func helpAction(_ sender: Any) {
        print("도움 눌림")
    }
    
    
}


extension DetailReviewTableViewCell: FSPagerViewDelegate, FSPagerViewDataSource {
    func numberOfItems(in pagerView: FSPagerView) -> Int {
        return 2
    }
    
    func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "DetailReviewFSPagerViewCell", at: index)
        return cell
    }
    
    
}

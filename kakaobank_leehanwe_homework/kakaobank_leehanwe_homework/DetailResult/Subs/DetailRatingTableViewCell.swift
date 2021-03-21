//
//  DetailRatingTableViewCell.swift
//  kakaobank_leehanwe_homework
//
//  Created by hanwe on 2021/03/21.
//

import UIKit

class DetailRatingTableViewCell: UITableViewCell {


    //MARK: IBOutlet
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var bestLabel: UILabel!
    @IBOutlet weak var allViewBtn: UIButton!
    @IBOutlet weak var starContainerView: UIView!
    @IBOutlet weak var progress1: UIProgressView!
    @IBOutlet weak var progress2: UIProgressView!
    @IBOutlet weak var progress3: UIProgressView!
    @IBOutlet weak var progress4: UIProgressView!
    @IBOutlet weak var progress5: UIProgressView!
    @IBOutlet weak var ratingTitleLabel: UILabel!
    
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
    @IBAction func allViewBtnAction(_ sender: Any) {
    }
    
    
}

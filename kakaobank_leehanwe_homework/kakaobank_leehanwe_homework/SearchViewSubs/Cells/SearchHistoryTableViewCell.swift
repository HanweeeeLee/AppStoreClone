//
//  SearchHistoryTableViewCell.swift
//  kakaobank_leehanwe_homework
//
//  Created by hanwe on 2021/03/19.
//

import UIKit

class SearchHistoryTableViewCell: UITableViewCell {
    
    //MARK: IBOutlet
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var searchHistoryLabel: UILabel!
    
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
    
    @IBAction func deleteSearchHistory(_ sender: Any) {
        
    }
    
    
    
    
}

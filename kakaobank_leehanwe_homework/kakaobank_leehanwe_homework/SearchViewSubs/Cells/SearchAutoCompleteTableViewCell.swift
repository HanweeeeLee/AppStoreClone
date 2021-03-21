//
//  SearchAutoCompleteTableViewCell.swift
//  kakaobank_leehanwe_homework
//
//  Created by hanwe on 2021/03/19.
//

import UIKit

class SearchAutoCompleteTableViewCell: UITableViewCell {
    
    //MARK: IBOutlet
    
    @IBOutlet weak var titleLabel: UILabel!
    
    //MARK: property
    
    var infoData: SearchHistoryData? = nil {
        didSet {
            guard let info = self.infoData else { return }
            self.titleLabel.text = info.searchText
        }
    }
    //MARK: lifeCycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    //MARK: function
    //MARK: action
    
}

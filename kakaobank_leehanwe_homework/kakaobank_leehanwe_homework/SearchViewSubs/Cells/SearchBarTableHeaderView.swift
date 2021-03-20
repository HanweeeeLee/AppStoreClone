//
//  SearchBarTableHeaderView.swift
//  kakaobank_leehanwe_homework
//
//  Created by hanwe on 2021/03/19.
//

import UIKit
import SnapKit

protocol SearchBarTableHeaderViewDelegate: class {
    func searchBarTextDidBeginEditing(_ view: SearchBarTableHeaderView)
    func searchBarTextDidEndEditing(_ view: SearchBarTableHeaderView)
}

class SearchBarTableHeaderView: UITableViewHeaderFooterView {

    //MARK: IBOutlet
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var colorView: UIView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var searchBarTraillingConstraint: NSLayoutConstraint!
    @IBOutlet weak var cancelBtn: UIButton!
    @IBOutlet weak var cancelBtnTraillingConstraint: NSLayoutConstraint!
    @IBOutlet weak var lineView: UIView!
    
    //MARK: property
    var currentState: SearchViewController.SearchBarState = .history {
        didSet {
            switch self.currentState {
            case .history:
                hideCancelBtn()
                break
            case .autoComplete:
                showCancelBtn()
                break
            case .searched:
                break
            }
        }
    }
    weak var delegate: SearchBarTableHeaderViewDelegate?
    
    var originSearchBarTraillingConstraint: CGFloat = 0
    var originCancelBtnTraillingConstraint: CGFloat = 0
    
    //MARK: lifeCycle
    
    override func awakeFromNib() {
        initUI()
        self.searchBar.delegate = self
    }
    
    //MARK: function
    
    func initUI() {
        self.searchBar.setBackgroundImage(UIImage(), for: .any, barMetrics: UIBarMetrics.default)
        self.colorView.backgroundColor = UIColor(red: 245/255, green: 245/255, blue: 245/255, alpha: 0)
        self.lineView.backgroundColor = UIColor(red: 220/255, green: 220/255, blue: 220/255, alpha: 0)
        self.cancelBtn.setTitle(LocalizedMap.CANCEL.localized, for: .normal)
        self.originSearchBarTraillingConstraint = searchBarTraillingConstraint.constant
        self.originCancelBtnTraillingConstraint = cancelBtnTraillingConstraint.constant
    }
    
    func setColorEffect(percent: CGFloat) {
        self.colorView.backgroundColor = UIColor(red: 245/255, green: 245/255, blue: 245/255, alpha: percent)
        self.lineView.backgroundColor = UIColor(red: 220/255, green: 220/255, blue: 220/255, alpha: percent)
    }
    
    private func hideCancelBtn() {
        self.searchBarTraillingConstraint.constant = self.originSearchBarTraillingConstraint
        self.cancelBtnTraillingConstraint.constant = self.originCancelBtnTraillingConstraint - 10
        UIView.animate(withDuration: 0.2, animations: { [weak self] in
            self?.layoutIfNeeded()
            self?.cancelBtn.alpha = 0
        }, completion: { [weak self] _ in
            self?.cancelBtn.isHidden = true
        })
    }
    
    private func showCancelBtn() {
        self.cancelBtn.isHidden = false
        self.searchBarTraillingConstraint.constant = self.cancelBtn.frame.width + 5
        self.cancelBtnTraillingConstraint.constant = self.originCancelBtnTraillingConstraint
        UIView.animate(withDuration: 0.2, animations: { [weak self] in
            self?.layoutIfNeeded()
            self?.cancelBtn.alpha = 1
        }, completion: { _ in
        })
    }
    
    func resignTextInput() {
        self.searchBar.endEditing(true)
    }
    
    //MARK: action
    @IBAction func cancelAction(_ sender: Any) {
    }

}

extension SearchBarTableHeaderView: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        self.delegate?.searchBarTextDidBeginEditing(self)
        print("searchBarTextDidBeginEditing")
        showCancelBtn()
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        self.delegate?.searchBarTextDidEndEditing(self)
        print("searchBarTextDidEndEditing")
        hideCancelBtn()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//        print("searchText:\(searchText)") //자동완성할때 쓴다.
    }
}

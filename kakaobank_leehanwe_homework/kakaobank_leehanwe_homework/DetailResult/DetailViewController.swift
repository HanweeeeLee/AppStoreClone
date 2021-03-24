//
//  DetailViewController.swift
//  kakaobank_leehanwe_homework
//
//  Created by hanwe on 2021/03/21.
//

import UIKit

protocol DetailViewCommonProtocol: class {
    func reloadTableView(indexPath: IndexPath)
    func reloadTableView()
    func moveTo(indexPath: IndexPath)
    func shareUrl(message: String, url: String)
}

protocol DetailViewControllerDelegate: class {
    func viewPoped()
}

class DetailViewController: UIViewController, MVPViewControllerProtocol {
    typealias MVPPresenterClassType = DetailPresenter
    typealias SelfType = DetailViewController
    
    enum PreviewMode {
        case iPhone
        case iPad
    }
    
    //MARK: IBOutlet
    @IBOutlet weak var mainContainerView: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: property
    var presenter: DetailPresenter!
    var searchResultData: SearchData!
    
    var iconImg: UIImage? = nil
    
    var previewMode: PreviewMode = .iPhone
    var isMoreCompatibility: Bool = false
    var isMoreAgeGrade: Bool = false
    var isMoreContentsMode: Bool = false
    
    weak var delegate: DetailViewControllerDelegate?
    
    //MARK: lifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        hideLargeTitle()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if self.isMovingFromParent {
            showLargeTitle()
            self.navigationController?.setNavigationBarHidden(true, animated: false)
            self.delegate?.viewPoped()
        }
    }
    
    //MARK: function
    
    static func makeViewController(presenter: DetailPresenter, infoData: SearchData) -> DetailViewController? {
        if let vc = DetailViewController.makeViewController(presenter: presenter) {
            vc.searchResultData = infoData
            return vc
        }
        return nil
    }
    
    static func makeViewController(presenter: DetailPresenter) -> DetailViewController? {
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        if let viewController = storyboard.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController {
            viewController.presenter = presenter
            return viewController
        }
        return nil
    }
    
    func initUI() {
        self.mainContainerView.backgroundColor = .clear
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.tableView.register(UINib(nibName: "DetailHeaderTableViewCell", bundle: nil), forCellReuseIdentifier: "DetailHeaderTableViewCell")
        self.tableView.register(UINib(nibName: "DetailInfoCollectionTableViewCell", bundle: nil), forCellReuseIdentifier: "DetailInfoCollectionTableViewCell")
        self.tableView.register(UINib(nibName: "DetailPreViewTableViewCell", bundle: nil), forCellReuseIdentifier: "DetailPreViewTableViewCell")
        self.tableView.register(UINib(nibName: "DetaiPhonePreViewTableViewCell", bundle: nil), forCellReuseIdentifier: "DetaiPhonePreViewTableViewCell")
        self.tableView.register(UINib(nibName: "DetailReleaseNoteTableViewCell", bundle: nil), forCellReuseIdentifier: "DetailReleaseNoteTableViewCell")
        self.tableView.register(UINib(nibName: "DetailContentsTableViewCell", bundle: nil), forCellReuseIdentifier: "DetailContentsTableViewCell")
        self.tableView.register(UINib(nibName: "DetailRatingTableViewCell", bundle: nil), forCellReuseIdentifier: "DetailRatingTableViewCell")
        self.tableView.register(UINib(nibName: "DetailReviewTableViewCell", bundle: nil), forCellReuseIdentifier: "DetailReviewTableViewCell")
        self.tableView.register(UINib(nibName: "DetailInfomationTableViewCell", bundle: nil), forCellReuseIdentifier: "DetailInfomationTableViewCell")
        self.tableView.register(UINib(nibName: "DetailInfomation2TableViewCell", bundle: nil), forCellReuseIdentifier: "DetailInfomation2TableViewCell")
        self.tableView.register(UINib(nibName: "DetailInfomation3TableViewCell", bundle: nil), forCellReuseIdentifier: "DetailInfomation3TableViewCell")
        self.tableView.register(UINib(nibName: "DetailInfomation4TableViewCell", bundle: nil), forCellReuseIdentifier: "DetailInfomation4TableViewCell")
        self.tableView.register(UINib(nibName: "MoreAgeGradeTableViewCell", bundle: nil), forCellReuseIdentifier: "MoreAgeGradeTableViewCell")
        self.tableView.register(UINib(nibName: "MoreCompatibilityTableViewCell", bundle: nil), forCellReuseIdentifier: "MoreCompatibilityTableViewCell")
        
    }
    
    func showLargeTitle() {
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.title = LocalizedMap.TITLE_SEARCH_VIEW_CONTROLLER.localized
        self.navigationItem.largeTitleDisplayMode = .automatic
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    func hideLargeTitle() {
        navigationItem.largeTitleDisplayMode = .never
        self.navigationController?.navigationBar.removeAllSubview()
    }
    
    func showNavigationIcons() {
        
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        imageView.contentMode = .scaleAspectFit
        imageView.downloadOrCachedImage(urlString: self.searchResultData.icon60)
        imageView.layer.cornerRadius = 5
        imageView.layer.masksToBounds = true
        navigationItem.titleView = imageView
        imageView.slidePush(direction: .fromTop, completeHandler: {
        })
        
        let downloadView = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: 20))
        downloadView.backgroundColor = UIColor(red: 51/255, green: 102/255, blue: 1, alpha: 1)
        downloadView.layer.cornerRadius = 10
        let rightBarBtn = UIBarButtonItem(customView: downloadView)
        let downloadLabel = UILabel()
        downloadView.addSubview(downloadLabel)
        downloadLabel.frame = CGRect(x: downloadView.frame.minX, y: downloadView.frame.minY, width: downloadView.frame.maxX, height: downloadView.frame.maxY)
        downloadLabel.text = "받기"
        downloadLabel.textAlignment = .center
        downloadLabel.textColor = .white
        self.navigationItem.rightBarButtonItem = rightBarBtn
        downloadView.slidePush(direction: .fromTop, completeHandler: {
        })
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.downloadBtnClicked(_:)))
        downloadView.addGestureRecognizer(tapGesture)
    }
    
    func hideNavigationIcons() {
        navigationItem.titleView?.fadeOut(duration: 0.2, completeHandler: { [weak self] in
            self?.navigationItem.titleView = nil
        })
        navigationItem.rightBarButtonItem?.customView?.fadeOut(duration: 0.2, completeHandler: {
            self.navigationItem.rightBarButtonItem?.customView = nil
        })
    }
    
    //MARK: action
    
    @objc func downloadBtnClicked(_ recognizer: UITapGestureRecognizer) {
        print("다운로드 버튼 눌림")
    }
    
   

}


extension DetailViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 8
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 7 {
            return 9
        }
        else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell: DetailHeaderTableViewCell = tableView.dequeueReusableCell(withIdentifier: "DetailHeaderTableViewCell", for: indexPath) as! DetailHeaderTableViewCell
            cell.selectionStyle = .none
            cell.delegate = self
            cell.infoData = self.searchResultData
            return cell
        case 1:
            let cell: DetailInfoCollectionTableViewCell = tableView.dequeueReusableCell(withIdentifier: "DetailInfoCollectionTableViewCell", for: indexPath) as! DetailInfoCollectionTableViewCell
            cell.selectionStyle = .none
            cell.delegate = self
            cell.infoData = self.searchResultData
            return cell
        case 2:
            let cell: DetailContentsTableViewCell = tableView.dequeueReusableCell(withIdentifier: "DetailContentsTableViewCell", for: indexPath) as! DetailContentsTableViewCell
            cell.selectionStyle = .none
            cell.infoData = self.searchResultData
            cell.delegate = self
            if isMoreContentsMode {
                cell.mode = .detail
            }
            else {
                cell.mode = .simple
            }
            return cell
        case 3:
            if previewMode == .iPad {
                let cell: DetailPreViewTableViewCell = tableView.dequeueReusableCell(withIdentifier: "DetailPreViewTableViewCell", for: indexPath) as! DetailPreViewTableViewCell
                cell.selectionStyle = .none
                cell.infoData = self.searchResultData
                return cell
            }
            else {
                let cell: DetaiPhonePreViewTableViewCell = tableView.dequeueReusableCell(withIdentifier: "DetaiPhonePreViewTableViewCell", for: indexPath) as! DetaiPhonePreViewTableViewCell
                cell.indexPath = indexPath
                cell.selectionStyle = .none
                cell.infoData = self.searchResultData
                cell.delegate = self
                return cell
            }
        case 4:
            let cell: DetailRatingTableViewCell = tableView.dequeueReusableCell(withIdentifier: "DetailRatingTableViewCell", for: indexPath) as! DetailRatingTableViewCell
            cell.selectionStyle = .none
            cell.infoData = self.searchResultData
            return cell
        case 5:
            let cell: DetailReviewTableViewCell = tableView.dequeueReusableCell(withIdentifier: "DetailReviewTableViewCell", for: indexPath) as! DetailReviewTableViewCell
            cell.selectionStyle = .none
            return cell
        case 6:
            let cell: DetailReleaseNoteTableViewCell = tableView.dequeueReusableCell(withIdentifier: "DetailReleaseNoteTableViewCell", for: indexPath) as! DetailReleaseNoteTableViewCell
            cell.selectionStyle = .none
            cell.infoData = self.searchResultData
            return cell
        case 7:
            switch indexPath.row {
            case 0:
                let cell: DetailInfomationTableViewCell = tableView.dequeueReusableCell(withIdentifier: "DetailInfomationTableViewCell", for: indexPath) as! DetailInfomationTableViewCell
                cell.contentsTitleLabel.text = "제공자"
                cell.infoLabel.text = self.searchResultData.sellerName
                cell.selectionStyle = .none
                return cell
            case 1:
                let cell: DetailInfomation2TableViewCell = tableView.dequeueReusableCell(withIdentifier: "DetailInfomation2TableViewCell", for: indexPath) as! DetailInfomation2TableViewCell
                cell.titleLabel.text = "크기"
                cell.contentsLabel.text = CommonUtil.getMBFromByte(byte: Int(self.searchResultData.fileSizeBytes) ?? 0) + "MB"
                cell.selectionStyle = .none
                return cell
            case 2:
                let cell: DetailInfomation2TableViewCell = tableView.dequeueReusableCell(withIdentifier: "DetailInfomation2TableViewCell", for: indexPath) as! DetailInfomation2TableViewCell
                cell.selectionStyle = .none
                cell.titleLabel.text = "카테고리"
                cell.contentsLabel.text = self.searchResultData.primaryGenreName
                return cell
            case 3:
                if isMoreCompatibility {
                    let cell: MoreCompatibilityTableViewCell = tableView.dequeueReusableCell(withIdentifier: "MoreCompatibilityTableViewCell", for: indexPath) as! MoreCompatibilityTableViewCell
                    cell.selectionStyle = .none
                    cell.osLabel.text = "iOS " + self.searchResultData.minimumOsVersion + " 이상 필요."
                    return cell
                }
                else {
                    let cell: DetailInfomation3TableViewCell = tableView.dequeueReusableCell(withIdentifier: "DetailInfomation3TableViewCell", for: indexPath) as! DetailInfomation3TableViewCell
                    cell.selectionStyle = .none
                    cell.titleLabel.text = "호환성"
                    if CommonUtil.isUsableAppFromVersion(mySystemVersion: UIDevice.current.systemVersion, requiredVersion: self.searchResultData.minimumOsVersion) {
                        cell.contentsLabel.text = "이 iPhone와(과) 호환"
                    }
                    else {
                        cell.contentsLabel.text = "이 iPhone와(과) 호환불가"
                    }
                    return cell
                }
            case 4:
                let cell: DetailInfomation2TableViewCell = tableView.dequeueReusableCell(withIdentifier: "DetailInfomation2TableViewCell", for: indexPath) as! DetailInfomation2TableViewCell
                cell.selectionStyle = .none
                cell.titleLabel.text = "언어"
                cell.contentsLabel.text = self.searchResultData.languageCodesISO2A[0]
                return cell
            case 5:
                if self.isMoreAgeGrade {
                    let cell: MoreAgeGradeTableViewCell = tableView.dequeueReusableCell(withIdentifier: "MoreAgeGradeTableViewCell", for: indexPath) as! MoreAgeGradeTableViewCell
                    cell.selectionStyle = .none
                    cell.ageLabel.text = self.searchResultData.contentAdvisoryRating
                    return cell
                }
                else {
                    let cell: DetailInfomation3TableViewCell = tableView.dequeueReusableCell(withIdentifier: "DetailInfomation3TableViewCell", for: indexPath) as! DetailInfomation3TableViewCell
                    cell.selectionStyle = .none
                    cell.titleLabel.text = "연령등급"
                    cell.contentsLabel.text = self.searchResultData.contentAdvisoryRating
                    return cell
                }
            case 6:
                let cell: DetailInfomation2TableViewCell = tableView.dequeueReusableCell(withIdentifier: "DetailInfomation2TableViewCell", for: indexPath) as! DetailInfomation2TableViewCell
                cell.selectionStyle = .none
                cell.titleLabel.text = "저작권"
                cell.contentsLabel.text = self.searchResultData.sellerName
                return cell
            case 7:
                let cell: DetailInfomation4TableViewCell = tableView.dequeueReusableCell(withIdentifier: "DetailInfomation4TableViewCell", for: indexPath) as! DetailInfomation4TableViewCell
                cell.selectionStyle = .none
                cell.titleLabel.text = "개발자 웹 사이트"
                cell.imgView.image = UIImage(systemName: "safari")
                return cell
            case 8:
                let cell: DetailInfomation4TableViewCell = tableView.dequeueReusableCell(withIdentifier: "DetailInfomation4TableViewCell", for: indexPath) as! DetailInfomation4TableViewCell
                cell.selectionStyle = .none
                cell.titleLabel.text = "개인정보 처리방침"
                cell.imgView.image = UIImage(systemName: "hand.raised.fill")
                return cell
            default:
                return UITableViewCell()
            }
        default:
            return UITableViewCell()
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 7 {
            if indexPath.row == 5 && !self.isMoreAgeGrade {
                self.isMoreAgeGrade = true
                tableView.reloadRows(at: [indexPath], with: .fade)
            }
            else if indexPath.row == 3 && !self.isMoreCompatibility {
                self.isMoreCompatibility = true
                tableView.reloadRows(at: [indexPath], with: .fade)
            }
            else if indexPath.row == 7 {
                if let url = URL(string: self.searchResultData.sellerUrl ?? "") {
                    UIApplication.shared.open(url, options: [:])
                }
            }
            else if indexPath.row == 8 {
                if let url = URL(string: self.searchResultData.sellerUrl ?? "") {
                    UIApplication.shared.open(url, options: [:])
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.section == 0 && indexPath.row == 0 {
            showNavigationIcons()
        }
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.section == 0 && indexPath.row == 0 {
            hideNavigationIcons()
        }
    }
    
}

extension DetailViewController: DetailViewCommonProtocol {
    func shareUrl(message: String, url: String) {
        let title: String = message
        guard let objectsToShare: URL = URL(string: url) else { return }
        let sharedObjects: [AnyObject] = [objectsToShare as AnyObject, title as AnyObject]
        let activityViewController = UIActivityViewController(activityItems : sharedObjects, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view
        
        activityViewController.excludedActivityTypes = [ UIActivity.ActivityType.airDrop,  UIActivity.ActivityType.postToFacebook, UIActivity.ActivityType.postToTwitter, UIActivity.ActivityType.mail]
        
        self.present(activityViewController, animated: true, completion: nil)
    }
    
    func moveTo(indexPath: IndexPath) {
        self.tableView.scrollToRow(at: indexPath, at: .top, animated: true)
    }
    
    func reloadTableView(indexPath: IndexPath) {
        self.tableView.reloadRows(at: [indexPath], with: .fade)
    }
    
    func reloadTableView() {
        self.tableView.reloadData()
    }
}

extension DetailViewController: DetailContentsTableViewCellDelegate {
    func switchMoreContentsTableViewCellMode() {
        self.isMoreContentsMode = true
    }
    
}

extension DetailViewController: DetaiPhonePreViewTableViewCellDelegate {
    func switchPreviewMode() {
        self.previewMode = .iPad
    }
}


extension DetailViewController: DetailInfoCollectionTableViewCellDelegate {
}
extension DetailViewController: DetailHeaderTableViewCellDelegate {
    
}


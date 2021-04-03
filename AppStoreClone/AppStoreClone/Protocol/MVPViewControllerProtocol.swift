//
//  MVPViewControllerProtocol.swift
//  AppStoreClone
//
//  Created by hanwe on 2021/03/21.
//

import UIKit

protocol MVPViewControllerProtocol: class {
    associatedtype MVPPresenterClassType: PresenterProtocol
    associatedtype SelfType: MVPViewControllerProtocol
    var presenter: MVPPresenterClassType! { get set }
    static func makeViewController(presenter: MVPPresenterClassType) -> SelfType?
}

protocol PresenterProtocol: class {
    
}

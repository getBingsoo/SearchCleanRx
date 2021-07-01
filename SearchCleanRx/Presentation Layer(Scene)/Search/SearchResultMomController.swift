//
//  SearchResultMomController.swift
//  SearchCleanRx
//
//  Created by 60067667 on 2021/06/24.
//

import UIKit

/// Result List, Searcing History List 담는 껍질 VC
class SearchResultMomController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    func display(_ child: UIViewController) {
        addChild(child)
        child.view.frame = view.bounds
        view.addSubview(child.view)
        child.didMove(toParent: self)
    }

    func hide(_ child: UIViewController) {
        child.willMove(toParent: nil)
        child.view.removeFromSuperview()
        child.removeFromParent()
    }

}

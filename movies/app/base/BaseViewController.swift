//
//  BaseViewController.swift
//  movies
//
//  Created by azun on 02/09/2023.
//

import UIKit
import ProgressHUD

class BaseViewController: UIViewController {
    var shouldShowSpinner: Bool = true {
        didSet {
            activateSpinner()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        ProgressHUD.animationType = .lineScaling
        ProgressHUD.colorAnimation = .label
        activateSpinner()
    }
}

// MARK: - Private
private extension BaseViewController {
    func activateSpinner() {
        shouldShowSpinner ? ProgressHUD.show() : ProgressHUD.dismiss()
    }
}

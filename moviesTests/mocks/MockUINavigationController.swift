//
//  MockUINavigationController.swift
//  moviesTests
//
//  Created by azun on 02/09/2023.
//

import UIKit

class MockUINavigationController: UINavigationController {
    private(set) var didCallPushViewController: (viewController: UIViewController, animated: Bool)?
    private(set) var didCallPresentViewController: (viewController: UIViewController, animated: Bool,
                                                    completion: (() -> Void)?)?
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        didCallPushViewController = (viewController, animated)
        super.pushViewController(viewController, animated: false)
    }
    
    override func present(_ viewControllerToPresent: UIViewController,
                          animated flag: Bool,
                          completion: (() -> Void)? = nil) {
        super.present(viewControllerToPresent, animated: false, completion: completion)
        didCallPresentViewController = (viewControllerToPresent, flag, completion)
    }
}

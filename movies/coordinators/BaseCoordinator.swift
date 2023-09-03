//
//  BaseCoordinator.swift
//  movies
//
//  Created by azun on 29/08/2023.
//

import UIKit
import Combine

class BaseCoordinator {
    var disposeBag = Set<AnyCancellable>()
    
    var parentCoordinator: BaseCoordinator?
    var children: [BaseCoordinator] = []
    var navigationController: UINavigationController?
    
    func start() { }
}

//
//  UIButton+Extensions.swift
//  movies
//
//  Created by azun on 02/09/2023.
//

import UIKit

extension UIButton {
    func updateState(normalColor: UIColor? = nil) {
        var config = configuration
        let targetColor: UIColor?
        switch state {
        case .selected, .highlighted, .disabled:
            targetColor = normalColor == nil ? UIColor.label.withAlphaComponent(0.2) : normalColor?.withAlphaComponent(0.5)
        default:
            targetColor = normalColor ?? .white
        }
        config?.background.backgroundColor = targetColor
        configuration = config
    }
}

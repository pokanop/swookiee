//
//  LayoutPosition.swift
//  SWookiee App
//
//  Copyright © 2020 Pokanop Apps LLC. All rights reserved.
//

import UIKit

enum LayoutPosition {
    
    case top, bottom, leading, trailing, center, stretch, width, height
    
    func constraints(for view: UIView, relativeTo other: UIView, padding: CGFloat = 0) -> [NSLayoutConstraint] {
        let topConstraint = view.topAnchor.constraint(equalTo: other.topAnchor, constant: padding)
        let bottomConstraint = view.bottomAnchor.constraint(equalTo: other.bottomAnchor, constant: padding)
        let leadingConstraint = view.leadingAnchor.constraint(equalTo: other.leadingAnchor, constant: padding)
        let trailingConstraint = view.trailingAnchor.constraint(equalTo: other.trailingAnchor, constant: padding)
        let centerXConstraint = view.centerXAnchor.constraint(equalTo: other.centerXAnchor)
        let centerYConstraint = view.centerYAnchor.constraint(equalTo: other.centerYAnchor)
        let widthConstraint = view.widthAnchor.constraint(equalTo: other.widthAnchor, constant: -padding)
        let heightConstraint = view.heightAnchor.constraint(equalTo: other.heightAnchor, constant: -padding)
        
        switch self {
        case .top: return [topConstraint, centerXConstraint]
        case .bottom: return [bottomConstraint, centerXConstraint]
        case .leading: return [leadingConstraint, centerYConstraint]
        case .trailing: return [trailingConstraint, centerYConstraint]
        case .center: return [centerXConstraint, centerYConstraint]
        case .stretch: return [topConstraint, bottomConstraint, leadingConstraint, trailingConstraint]
        case .width: return [widthConstraint]
        case .height: return [heightConstraint]
        }
    }
    
}

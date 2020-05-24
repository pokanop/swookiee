//
//  Loader.swift
//  SWookiee App
//
//  Copyright © 2020 Pokanop Apps LLC. All rights reserved.
//

import UIKit

class Loader: UIView {
    
    private let width: CGFloat = 20.0
    private let padding: CGFloat = 2.0
    private let count: Int = 3
    private var totalWidth: CGFloat { return width * CGFloat(count) + padding * 2 }
    private var totalHeight: CGFloat { return width + padding * 2 }
    
    private lazy var animation: CABasicAnimation = {
        let animation = CABasicAnimation(keyPath: "transform.scale")
        animation.duration = 0.6
        animation.fromValue = 1
        animation.toValue = 0.4
        animation.autoreverses = true
        animation.repeatCount = .infinity
        return animation
    }()

    private lazy var ball: CAShapeLayer = {
        let ball = CAShapeLayer()
        ball.frame.size = CGSize(width: width, height: width)
        ball.path = UIBezierPath(ovalIn: CGRect(x: padding, y: padding, width: width, height: width)).cgPath
        ball.fillColor = UIColor.white.cgColor
        ball.add(animation, forKey: "scale")
        return ball
    }()
    
    private lazy var replicator: CAReplicatorLayer = {
        let replicator = CAReplicatorLayer()
        replicator.frame.size = CGSize(width: totalWidth, height: totalHeight)
        replicator.masksToBounds = true
        replicator.instanceCount = count
        replicator.instanceDelay = TimeInterval(0.2)
        replicator.instanceTransform = CATransform3DMakeTranslation(width, 0, 0)
        replicator.addSublayer(ball)
        return replicator
    }()
    
    init() {
        super.init(frame: .zero)
        
        layer.addSublayer(replicator)
        NSLayoutConstraint.activate([
            widthAnchor.constraint(equalToConstant: totalWidth),
            heightAnchor.constraint(equalToConstant: totalHeight)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

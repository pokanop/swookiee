//
//  StarfieldView.swift
//  SWookiee App
//
//  Copyright © 2020 Pokanop Apps LLC. All rights reserved.
//

import UIKit

class StarfieldView: UIView {
    
    private var emitterLayer: CAEmitterLayer {
        return layer as! CAEmitterLayer
    }
    
    override class var layerClass: AnyClass {
        return CAEmitterLayer.self
    }
    
    init() {
        super.init(frame: .zero)
        
        backgroundColor = .clear
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        emitterLayer.masksToBounds = true
        emitterLayer.emitterShape = .sphere
        emitterLayer.emitterPosition = center
        emitterLayer.emitterSize = bounds.size
        
        let near = makeEmitterCell(color: UIColor.white.withAlphaComponent(0.33), velocity: 10, scale: 0.3)
        let middle = makeEmitterCell(color: UIColor.white.withAlphaComponent(0.66), velocity: 8, scale: 0.2)
        let far = makeEmitterCell(color: .white, velocity: 6, scale: 0.1)
        emitterLayer.emitterCells = [near, middle, far]
    }
    
    private func makeEmitterCell(color: UIColor, velocity: CGFloat, scale: CGFloat) -> CAEmitterCell {
        let cell = CAEmitterCell()
        cell.birthRate = 1
        cell.lifetime = 100
        cell.lifetimeRange = 0
        cell.velocity = velocity
        cell.velocityRange = velocity / 4
        cell.scale = scale
        cell.scaleRange = scale / 3
        cell.emissionRange = 2 * .pi
        let content = Content.shape(.circle, color)
        cell.contents = content.image.cgImage
        cell.color = content.color?.cgColor
        cell.alphaSpeed = -1.0 / cell.lifetime
        return cell
    }
    
}

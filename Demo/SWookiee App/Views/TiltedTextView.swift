//
//  TiltedTextView.swift
//  SWookiee App
//
//  Copyright © 2020 Pokanop Apps LLC. All rights reserved.
//

import UIKit

protocol TiltedTextViewDelegate: AnyObject {
    
    func tiltedTextViewDidFinishScrolling()
    
}

class TiltedTextView: UITextView {
    
    private var timer: Timer?
    weak var scrollDelegate: TiltedTextViewDelegate?

    init() {
        super.init(frame: .zero, textContainer: nil)
        
        isUserInteractionEnabled = false
        isSelectable = false
        isEditable = false
        backgroundColor = .clear
        font = UIFont.starWarsBodyFont
        textAlignment = .center
        textColor = .yellow
        text = """
        Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam neque neque, rhoncus eget augue tincidunt, fringilla commodo nulla. Praesent congue purus nec ornare fermentum. Phasellus nec condimentum felis. Etiam imperdiet mi non velit consectetur tempor. Orci varius natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Morbi eros justo, fringilla et dolor id, convallis auctor libero. Duis sed venenatis libero. In consequat est nec arcu mollis eleifend. Nam nec mattis nulla, a luctus justo. Nulla ut urna vel eros interdum aliquam a eget elit. Vivamus ac diam interdum, pharetra nisl quis, pulvinar metus. Nullam facilisis lectus eget mollis sodales. Praesent sodales risus quis nisi interdum suscipit.
        """
        
        var transform = CATransform3DIdentity
        transform.m34 = -3.0 / 500.0
        transform = CATransform3DRotate(transform, 30.0 * .pi / 180.0, 1.0, 0, 0)
        transform = CATransform3DTranslate(transform, 0, -120.0, 0)
        layer.transform = transform
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func startScrolling() {
        timer = Timer.scheduledTimer(withTimeInterval: 0.2, repeats: true) { [weak self] timer in
            guard let self = self else {
                timer.invalidate()
                return
            }
            
            var offset = self.contentOffset
            
            guard offset.y <= self.contentSize.height else {
                self.stopScrolling()
                return
            }
                
            offset.y += CGFloat(10.0 * timer.timeInterval)
            
            UIView.animate(withDuration: 0.2) {
                self.contentOffset = offset
            }
        }
    }
    
    func stopScrolling() {
        guard let timer = timer else { return }
        timer.invalidate()
        scrollDelegate?.tiltedTextViewDidFinishScrolling()
    }
    
    func reset() {
        contentOffset = CGPoint(x: 0, y: -bounds.size.height)
    }
    
}

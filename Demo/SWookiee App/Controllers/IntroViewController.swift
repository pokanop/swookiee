//
//  IntroViewController.swift
//  SWookiee App
//
//  Copyright © 2020 Pokanop Apps LLC. All rights reserved.
//

import UIKit
import Boing

class IntroViewController: UIViewController {
    
    private lazy var tiltedTextView: TiltedTextView = {
        let view = TiltedTextView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.scrollDelegate = self
        view.text = """
        SWookiee
        
        A Star Wars Story
        
        The galaxy was at rest, in a moment's peace from the destruction of the Imperial forces. In a time where programming languages were aplenty and the cognitive overload high to understand complicated paradigms, there was little hope for salvation.
        
        A light of hope arises from the dusty landscape in the form of Swift, so the world needed yet another library for SWAPI. Wielding a simple API and charming app to demonstrate its functionality, SWookiee emerges to save us from eternal boredom.
        
        Hope you enjoy this as much as I did writing it.
        
        🖖
        """
        return view
    }()
    
    private lazy var skipButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("skip", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(skipTapped), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // TODO: Add star field background, look into `CAEmitterLayer`
        view.backgroundColor = .black
        
        view.addSubview(tiltedTextView)
        LayoutPosition.stretch.constraints(for: tiltedTextView, relativeTo: view).activate()

        view.addSubview(skipButton)
        LayoutPosition.bottom.constraints(for: skipButton, relativeTo: view, padding: -32.0).activate()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        tiltedTextView.reset()
        tiltedTextView.startScrolling()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        tiltedTextView.stopScrolling()
    }
    
    @objc private func skipTapped() {
        guard skipButton.alpha > 0 else { return }
        
        skipButton.zoomOut() {
            self.tiltedTextView.fadeOut() {
                let vc = NavigationController(rootViewController: HomeViewController())
                vc.modalPresentationStyle = .fullScreen
                self.present(vc, animated: true)
            }
        }
    }

}

extension IntroViewController: TiltedTextViewDelegate {
    
    func tiltedTextViewDidFinishScrolling() {
        skipTapped()
    }
    
}

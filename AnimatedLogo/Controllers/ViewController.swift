//
//  ViewController.swift
//  AnimatedLogo
//
//  Created by Marcy Vernon on 3/6/19.
//  Copyright © 2019 Marcy Vernon. All rights reserved.
//

import SpriteKit

class ViewController: UIViewController {
    
    private let scene     = SplashGameScene(fileNamed : K.scene)!
    private let skView    = SKView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        splashLoad()
    }
    
    
    //MARK: Load the scene
    private func splashLoad() {
        if let scene = SplashGameScene(fileNamed: K.scene) {
            let skView = self.view as! SKView
            scene.viewController = self
            scene.scaleMode      = .aspectFill
            skView.presentScene(scene)
            scene.start()
        }
    }
    
    
    //MARK: Rerun the animation
    @IBAction func repeatScene(_ sender: Any) {
        scene.resetSplashBeforeExit()
        splashLoad()
    }
    
    
    override func didReceiveMemoryWarning() {
        presentAlert(title: K.lowMemory, message: K.lowMemoryWarning)
    }
}  // end of ViewController



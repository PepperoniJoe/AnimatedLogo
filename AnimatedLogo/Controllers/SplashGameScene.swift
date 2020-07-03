//
//  SplashGameScene.swift
//  AnimatedLogo
//
//  Created by Marcy Vernon on 3/8/19.
//  Copyright © 2019 Marcy Vernon. All rights reserved.
//

import SpriteKit

let squares = SKNode()
let logo    = SKLabelNode(fontNamed: K.font)

//MARK: Protocol to Hide Repeat Button
protocol EndOfAnimation {
    func splash(isAnimationReady: Bool)
}

class SplashGameScene: SKScene {
    
    var viewController: ViewController!
    var vcDelegate: EndOfAnimation?
    
    private let scatterLength = 10 //8
    private var steps         = 0
    private var squareCount   = 7
    private weak var timer1: Timer?
    private weak var timer2: Timer?
    
    func start() {
        vcDelegate?.splash(isAnimationReady: false)
        resetSplashBeforeExit()
        createLogo()
        createSquares()
        setTimers()
    }
    
    private func createLogo() {
        logo.removeAllChildren()
        let squareSpacing: CGFloat   = CGFloat(squareCount - 2)
        logo.position                = CGPoint(x: self.frame.midX, y: self.frame.midY + (squareSize * squareSpacing))
        logo.horizontalAlignmentMode = .center
        logo.text                    = K.logoText
        logo.fontSize                = K.logoSize
        logo.fontColor               = UIColor.white
        logo.alpha                   = 0
        addChild(logo)
    }
    
    private func displayLogo() {
        let actionFade = SKAction.fadeAlpha(to: 1, duration: 1)
        logo.run(actionFade)
    }
    
    private func createSquares() {
        colorScheme = colorScheme >= 5 ? 0 : colorScheme + 1
        var x = 0
        var y = 0
        
        while y < squareCount {
            x = 0
            while x < squareCount {
                let square = Square(x: x, y: y)
                squares.addChild(square)
                x += 1
            }
            y += 1
        }
        addChild(squares)
        
        squares.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
        squares.alpha = 0
        
        for _ in (1...scatterLength) { scatter() }
    }
    
    private func setTimers() {
        DispatchQueue.main.async {
            if self.timer1 == nil {
                self.timer1 = Timer.scheduledTimer(timeInterval: 0.2, target: self, selector: #selector(self.appear), userInfo: nil, repeats: false)
            }
            DispatchQueue.main.async {
                if self.timer2 == nil {
                    self.timer2 = Timer.scheduledTimer(timeInterval: K.moveInterval, target: self, selector: #selector(self.organize), userInfo: nil, repeats: true)
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 6.0) {
                    self.vcDelegate?.splash(isAnimationReady: true)
                }
            }
        }
    }
    
    
    
    @objc func appear() {
        squares.alpha = 1
        var count = 1
        for case let square as Square in squares.children {
            square.appear(count)
            count += 1
        }
    }
    
    
    @objc func organize() {
        steps += 1
        
        for case let square as Square in squares.children {
            square.comeTogether()
        }
        
        if steps == 8 { displayLogo() }  //10
        if steps == 28 { exit() }  //14
    }
    
    func exit() {
        steps = 0
        squareCount = 7
        DispatchQueue.main.async {
            self.timer1?.invalidate()
            self.timer2?.invalidate()
        }
    }
    
    func resetSplashBeforeExit() {
        exit()
        squares.removeAllChildren()
        squares.removeFromParent()
        logo.removeAllChildren()
        logo.removeFromParent()
    }
    
    private func scatter() {
        for case let square as Square in squares.children {
            square.scatter()
        }
    }
    
} // end of SplashGameScene



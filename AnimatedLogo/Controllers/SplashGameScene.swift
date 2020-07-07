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

class SplashGameScene: SKScene {
    
    var viewController: ViewController!
    
    private let scatterLength = 10
    private var steps         = 0
    private var squareCount   = 7

    
    func start() {
        resetSplashBeforeExit()
        createLogo()
        createSquares()
        fire()
    }
    
    var time = 12
    
    func fire() {

        run(SKAction.sequence([
            SKAction.run( appear ),
            SKAction.wait(forDuration: 0.2)
            ]))
        
         run(SKAction.repeatForever(
            SKAction.sequence([
            SKAction.run( organize ),
            SKAction.wait(forDuration: 0.5)
            ])))
        
        run(SKAction.repeat(
            SKAction.sequence([
            SKAction.wait( forDuration:0.1 ),
            SKAction.run{ self.time -= 1 }]), count: 50
        ))

    }
    
    
    private func createLogo() {
        logo.removeAllChildren()
        let squareSpacing: CGFloat = CGFloat(squareCount - 2)
        logo.position = CGPoint(x : self.frame.midX,
                                y : self.frame.midY + (squareSize * squareSpacing))
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
    
    @objc func appear() {
        squares.alpha = 1
        var count: Double = 1
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
        
        if steps == 12 { displayLogo() }
        if steps == 28 { exit() }
    }
    
    func exit() {
        steps = 0
        squareCount = 7
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


//
//  Square.swift
//  AnimatedLogo
//
//  Created by Marcy Vernon on 3/10/19.
//  Copyright © 2019 Marcy Vernon. All rights reserved.
//

import SpriteKit

let squareSize : CGFloat = 40
var colorScheme          = 0

class Square: SKNode {
    private var sprite              = SKShapeNode()
    private var moves   : [CGPoint] = []
    private let padding : CGFloat   = 3.0
    private var x       : Int       = 0
    private var y       : Int       = 0
    
    
    init(x: Int, y: Int) {
        super.init()
        
        self.x = x
        self.y = y
        
        addSprite()
        recordPosition()
    }
    
    
    // MARK: Add Sprite
    func addSprite() {
        sprite = SKShapeNode(rectOf: CGSize(width: squareSize * K.sizeProportion,
                                            height: squareSize * K.sizeProportion))
        
        let newColor: SKColor = K.colorArray[colorScheme][Int.random(in: 0...2)]
        sprite.fillColor   = newColor
        sprite.strokeColor = .clear
        addChild(sprite)
    }
    
    
    // MARK: Record Positions of Sprite
    func recordPosition() {
        position = CGPoint(x: CGFloat(x) * squareSize - squareSize * padding,
                           y: CGFloat(y) * squareSize - squareSize * padding)
        moves.append(position)
    }
    
    
    // MARK: Enlarge squares
    func appear(_ rank: Double) {

        sprite.run(SKAction.sequence([
            SKAction.scale(to: 0, duration: 0),
            SKAction.wait(forDuration: 0.04 * rank),
            SKAction.scale(to: 1, duration: K.moveInterval)
            ]))
    }
    
    
    // MARK: Record Path
    func scatter() {
        let direction = Direction.random()
        var test_x = 0
        var test_y = 0
        var canMove: Bool = true
        
        switch direction {
            case Direction.right: test_x = 1
            case Direction.left : test_x = -1
            case Direction.up   : test_y = 1
            case Direction.down : test_y = -1
        }
        
        for square in squares.children {
            let square = square as! Square
            if test_x != 0 && square.x == x + test_x && square.y == y { canMove = false }
            if test_y != 0 && square.x == x && square.y == y + test_y { canMove = false }
        }
        
        if canMove == true {
            x = x + test_x
            y = y + test_y
            position = CGPoint(x: CGFloat(x) * squareSize - squareSize * padding,
                               y: CGFloat(y) * squareSize - squareSize * padding)
        }
        moves.append(position)
    }
    
    
    // MARK: ComeTogether
    func comeTogether() {
        guard moves.count >= 1 else { return }
        
        var actionMove = SKAction()
        
        if let last = moves.last {
            actionMove = SKAction.move(to: last, duration: K.moveInterval)
        }
        
        actionMove.timingMode = .easeInEaseOut
        run(actionMove)
        moves.removeLast()
    }
    
    
    // MARK: Default
    required init?(coder aDecoder: NSCoder) {
        fatalError(K.initCoderWarning)
    }
}


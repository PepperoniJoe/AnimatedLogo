//
//  Square.swift
//  AnimatedLogo
//
//  Created by Marcy Vernon on 3/10/19.
//  Copyright © 2019 Marcy Vernon. All rights reserved.
//

import SpriteKit

let squareSize: CGFloat = 40
var colorScheme = 0

class Square: SKNode {
    private var sprite = SKShapeNode()
    private var moves  : [CGPoint] = []
    private let padding: CGFloat = 3.0
    private var x = 0
    private var y = 0
    
    init(x: Int, y: Int) {
        super.init()
        self.x = x
        self.y = y
        
        sprite = SKShapeNode(rectOf: CGSize(width: squareSize * K.sizeProportion, height: squareSize * K.sizeProportion))
        
        let newColor: SKColor = K.colorArray[colorScheme][Int.random(in: 0...2)]
        sprite.fillColor   = newColor
        sprite.strokeColor = newColor
        addChild(sprite)
        
        position = CGPoint(x: Double(x) * Double(squareSize) - Double(squareSize * padding),
                           y: Double(y) * Double(squareSize) - Double(squareSize * padding))
        moves.append(position)
    }
    
    func appear(_ rank: Int) {
        let actionScale0 = SKAction.scale(to: 0, duration: 0)
        let actionWait   = SKAction.wait(forDuration: 0.04 * Double(rank))
        let actionScale1 = SKAction.scale(to: 1, duration: K.moveInterval)
        let sequence     = SKAction.sequence([actionScale0, actionWait, actionScale1])
        self.sprite.run(sequence)
    }
    
    // MARK: ComeTogether
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
            position = CGPoint(x: Double(x) * Double(squareSize) - Double(squareSize * padding),
                               y: Double(y) * Double(squareSize) - Double(squareSize * padding))
        }
        moves.append(position)
    }
    
    // MARK: ComeTogether
    func comeTogether() {
        if moves.count < 1 { return }
        let actionMove = SKAction.move(to: moves.last!, duration: K.moveInterval)
        actionMove.timingMode = .easeInEaseOut
        run(actionMove)
        moves.removeLast()
    }
    
    
    // MARK: Directions
    private enum Direction: Int {
        case up
        case down
        case left
        case right
        
        static func random() -> Direction {
            let random = Int.random(in: 0...3)
            return Direction(rawValue: random) ?? Direction.right
        }
    }
    
    // MARK: Default
    required init?(coder aDecoder: NSCoder) {
        fatalError(K.initCoderWarning)
    }
}


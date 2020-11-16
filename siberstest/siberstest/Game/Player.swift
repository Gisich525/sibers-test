//
//  Player.swift
//  siberstest
//
//  Created by guest1 on 16.11.2020.
//

import Foundation
struct Player {
    enum Direction {
        case up
        case down
        case left
        case right
    }
    
    var stepsCountLeft: Int
    var coordinate: Coordinate
    var items: [Item] = []
    
    
    mutating func move(direction: Direction) {
        guard stepsCountLeft > 0 else { return }
        switch direction {
        case .up:
            coordinate.x -= 1
        case .down:
            coordinate.x += 1
        case .left:
            coordinate.y -= 1
        case .right:
            coordinate.y += 1
        }
        stepsCountLeft -= 1
    }
    
    mutating func add(item: Item) {
        items.append(item)
    }
    
    mutating func remove(item: Item) {
        items.removeAll { playerItem in
            return item == playerItem
        }
    }
    
}

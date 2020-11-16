//
//  Game.swift
//  siberstest
//
//  Created by guest1 on 12.11.2020.
//

import Foundation

protocol GameDelegate: class {
    func showRoom(room: Room)
    func updatePlayerInfo(player: Player)
    func gameDidEnd(state: Bool)
}

struct Coordinate {
    var x: Int
    var y: Int
}

class Game {
    var columnCount: Int
    var rowCount: Int
    var maze: Maze
    var player: Player
    
    weak var delegate: GameDelegate?
    
    init(column: Int, row: Int) {
        self.columnCount = column
        self.rowCount = row
        let size = MazeSize(width: column, height: row)
        self.player = Player(stepsCountLeft: column * row,
                             coordinate: Coordinate(x: Int.random(in: 0...column - 1),
                                                    y: Int.random(in: 0...row - 1)))
        self.maze = Maze(size: size)
    }
    
    func startGame() {
        delegate?.showRoom(room: maze.rooms[0][0])
        delegate?.updatePlayerInfo(player: player)
    }
    
    
    func openDoor (_ sender: Door) {
        guard player.stepsCountLeft > 0 else {
            delegate?.gameDidEnd(state: false)
            return
        }
        switch sender {
        case .right:
            if maze.rooms[player.coordinate.x][player.coordinate.y].doors.contains(.right) {
                player.move(direction: .right)
            }
        case .left:
            if maze.rooms[player.coordinate.x][player.coordinate.y].doors.contains(.left) {
                player.move(direction: .left)
            }
        case .up:
            if maze.rooms[player.coordinate.x][player.coordinate.y].doors.contains(.up) {
                player.move(direction: .up)
            }
        case .down:
            if maze.rooms[player.coordinate.x][player.coordinate.y].doors.contains(.down) {
                player.move(direction: .down)
            }
        }
        delegate?.showRoom(room: maze.rooms[player.coordinate.x][player.coordinate.y])
        delegate?.updatePlayerInfo(player: player)
    }
    
    func dropPlayerItem(item: Item) {
        player.remove(item: item)
        maze.add(item: item, at: player.coordinate)
        let roomItems = maze.rooms[player.coordinate.x][player.coordinate.y].items
        if roomItems.contains(.chest), roomItems.contains(.key) {
            delegate?.gameDidEnd(state: true)
        }
    }
    
    func grabItemFromRoom(item: Item) {
        maze.remove(item: item, at: player.coordinate)
        player.add(item: item)
    }
    
}

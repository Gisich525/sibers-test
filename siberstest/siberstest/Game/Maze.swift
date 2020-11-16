//
//  Maze.swift
//  siberstest
//
//  Created by guest1 on 12.11.2020.
//

import Foundation

enum Door {
    case left, right, up, down
}
enum Item: CaseIterable {
    case key, rock, mushroom, bone, chest
}

struct Room {
    var doors: [Door] = []
    var items: [Item] = []
    var multiplicity: Int = 0
    var num: Int = 0
    
    init(doors: [Door]) {
        self.doors = doors
    }
    init(items: [Item]) {
        self.items = items
    }
}

struct MazeSize {
    let width: Int
    let height: Int
}

class Maze {
    var rooms: [[Room]] = []
    
    private let size: MazeSize
    
    init(size: MazeSize) {
        self.size = size
        self.generateMaze()
    }
    
    func printMaze(rooms: [[Room]]) {
        var startWallString = String(" ")
        let roomsInRow = rooms.first?.count ?? 0
        let roomsInColumn = rooms.count
        for _ in 0..<roomsInRow {
            startWallString.append("_ ")
        }
        print(startWallString)
        for i in 0..<roomsInColumn {
            var line = String("")
            for j in 0..<roomsInRow {
                let haveDownDoor = rooms[i][j].doors.contains(.down)
                let haveLeftDoor = rooms[i][j].doors.contains(.left)
                line.append(!haveLeftDoor ? "|" : " ")
                line.append(!haveDownDoor ? "_" : " ")
            }
            line.append("|")
            print(line)
        }
    }
    
    func remove(item: Item, at coordinate: Coordinate) {
        rooms[coordinate.x][coordinate.y].items.removeAll { roomItem in
            return item == roomItem
        }
    }
    
    func add(item: Item, at coordinate: Coordinate) {
        rooms[coordinate.x][coordinate.y].items.append(item)
    }
}

private extension Maze {
    func addDownDoors(in row: Int) {
        //написать коммент почему
        guard row < size.height - 1, size.height > 1 else { return }
        for i in 0..<size.width {
            if Bool.random() {
                rooms[row][i].doors.append(.down)
            }
        }
        var currentMultiplicity = -1
        var currentPosition = 0
        while currentPosition < size.width {
            if currentMultiplicity != rooms[row][currentPosition].multiplicity {
                currentMultiplicity = rooms[row][currentPosition].multiplicity
                while currentPosition < size.width {
                    if rooms[row][currentPosition].multiplicity != currentMultiplicity {
                        rooms[row][currentPosition - 1].doors.append(.down)
                        currentPosition -= 1
                        break
                    }
                    if rooms[row][currentPosition].doors.contains(.down) {
                        break
                    }
                    if currentPosition == size.width - 1 {
                        rooms[row][currentPosition].doors.append(.down)
                        break
                    }
                    currentPosition += 1
                }
            }
            currentPosition += 1
        }
    }
    
    func addRightDoors(in row: Int) {
        for i in 0..<size.width - 1 {
            if Bool.random() {
                rooms[row][i].doors.append(.right)
                rooms[row][i+1].doors.append(.left)
                rooms[row][i+1].multiplicity = rooms[row][i].multiplicity
            }
        }
    }
    
    func copyNewRow(for column: Int) {
        for i in 0..<size.width {
            rooms[column][i] = rooms[column - 1][i]
            if rooms[column][i].doors.contains(.down) {
                rooms[column][i].multiplicity = -1
            }
            rooms[column][i].doors = []
            if rooms[column - 1][i].doors.contains(.down) {
                rooms[column][i].doors.append(.up)
            }
        }
        var lastMultiplicity = size.width*column
        if rooms[column][0].multiplicity == -1 {
            rooms[column][0].multiplicity = lastMultiplicity
            lastMultiplicity += 1
        }
        for i in 1..<size.width {
            if rooms[column][i].multiplicity == -1 {
                rooms[column][i].multiplicity = lastMultiplicity
                lastMultiplicity += 1
            }
        }
    }
    
    func addItemInRandomRoom() {
        for item in Item.allCases {
            let x = Int.random(in: 0...size.height - 1)
            let y = Int.random(in: 0...size.width - 1)
            rooms[x][y].items.append(item)
        }
    }
    
    func generateMaze() -> Void {
        self.rooms = Array<[Room]>(repeating: Array<Room>(repeating: Room(doors: []), count: size.width), count: size.height)
        for i in 0..<size.height {
            for j in 0..<size.width {
                rooms[i][j] = Room(doors: [])
            }
        }
        for i in 0..<size.width {
            rooms[0][i].multiplicity = i
        }
        addRightDoors(in: 0)
        addDownDoors(in: 0)
        printMaze(rooms: rooms)
        
        guard size.height > 1 else { return }
        for i in 1..<size.height - 1 {
            copyNewRow(for: i)
            addRightDoors(in: i)
            addDownDoors(in: i)
            printMaze(rooms: rooms)
        }
        for i in 0..<size.width - 1 {
            rooms[size.height - 1][i].doors.append(.right)
            rooms[size.height - 1][i + 1].doors.append(.left)
            rooms[size.height - 1][i].doors.append(.up)
        }

        addItemInRandomRoom()
        printMaze(rooms: rooms)
    }
}

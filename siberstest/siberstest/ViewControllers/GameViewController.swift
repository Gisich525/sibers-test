//
//  GameViewController.swift
//  siberstest
//
//  Created by guest1 on 12.11.2020.
//

import UIKit

class GameViewController: UIViewController {
    @IBOutlet weak var topDoorButton: UIButton!
    @IBOutlet weak var leftDoorButton: UIButton!
    @IBOutlet weak var downDoorButton: UIButton!
    @IBOutlet weak var rightDoorButton: UIButton!
    @IBOutlet weak var label: UILabel!
    
    @IBOutlet weak var keyInvButton: UIButton!
    @IBOutlet weak var rockInvButton: UIButton!
    @IBOutlet weak var mushroomInvButton: UIButton!
    @IBOutlet weak var boneInvButton: UIButton!
    
    @IBOutlet weak var keyFieldButton: UIButton!
    @IBOutlet weak var rockFieldButton: UIButton!
    @IBOutlet weak var mushroomFieldButton: UIButton!
    @IBOutlet weak var boneFieldButton: UIButton!
    @IBOutlet weak var chestFieldButton: UIButton!
    
    var game: Game?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        game?.startGame()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func tapOnDoor(_ sender: UIButton) {
        switch sender {
        case topDoorButton:
            game?.openDoor(.up)
        case downDoorButton:
            game?.openDoor(.down)
        case leftDoorButton:
            game?.openDoor(.left)
        case rightDoorButton:
            game?.openDoor(.right)
        default:
            return
        }
    }
    @IBAction func tapOnFieldButton(_ sender: UIButton) {
        switch sender {
        case keyFieldButton:
            game?.grabItemFromRoom(item: .key)
            keyFieldButton.isHidden = true
            keyInvButton.isHidden = false
        case rockFieldButton:
            game?.grabItemFromRoom(item: .rock)
            rockFieldButton.isHidden = true
            rockInvButton.isHidden = false
        case mushroomFieldButton:
            game?.grabItemFromRoom(item: .mushroom)
            mushroomFieldButton.isHidden = true
            mushroomInvButton.isHidden = false
        case boneFieldButton:
            game?.grabItemFromRoom(item: .bone)
            boneFieldButton.isHidden = true
            boneInvButton.isHidden = false
        case chestFieldButton:
            chestFieldButton.isHidden = true
        default:
            return
        }
    }
    
    @IBAction func tapOnInvButton(_ sender: UIButton) {
        switch sender {
        case keyInvButton:
            game?.dropPlayerItem(item: .key)
            keyInvButton.isHidden = true
            keyFieldButton.isHidden = false
        case rockInvButton:
            game?.dropPlayerItem(item: .rock)
            rockInvButton.isHidden = true
            rockFieldButton.isHidden = false
        case mushroomInvButton:
            game?.dropPlayerItem(item: .mushroom)
            mushroomInvButton.isHidden = true
            mushroomFieldButton.isHidden = false
        case boneInvButton:
            game?.dropPlayerItem(item: .bone)
            boneInvButton.isHidden = true
            boneFieldButton.isHidden = false
        default:
            return
        }
    }
}

extension GameViewController: GameDelegate {
    func gameDidEnd(state: Bool) {
        let title = state ? "Поздравляем! Вы выйграли!" : "Вы проиграли!"
        showAlertWith(title: title, actionTitle: "Сыграть снова") {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    func showRoom(room: Room) {
        
        leftDoorButton.isHidden = !room.doors.contains(.left)
        rightDoorButton.isHidden = !room.doors.contains(.right)
        topDoorButton.isHidden = !room.doors.contains(.up)
        downDoorButton.isHidden = !room.doors.contains(.down)
        
        keyFieldButton.isHidden = !room.items.contains(.key)
        rockFieldButton.isHidden = !room.items.contains(.rock)
        mushroomFieldButton.isHidden = !room.items.contains(.mushroom)
        boneFieldButton.isHidden = !room.items.contains(.bone)
        chestFieldButton.isHidden = !room.items.contains(.chest)
    }
    
    func updatePlayerInfo(player: Player) {
        keyInvButton.isHidden = !player.items.contains(.key)
        rockInvButton.isHidden = !player.items.contains(.rock)
        mushroomInvButton.isHidden = !player.items.contains(.mushroom)
        boneInvButton.isHidden = !player.items.contains(.bone)
        label.text = "\(player.stepsCountLeft)"
    }
}


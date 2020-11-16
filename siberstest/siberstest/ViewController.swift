//
//  ViewController.swift
//  siberstest
//
//  Created by guest1 on 12.11.2020.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var rowCount: UITextField!
    @IBOutlet weak var columnCount: UITextField!
    
    var game: Game?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func tapStartGameButton(_ sender: Any) {
        guard let rowString = rowCount.text,
              let columnString = columnCount.text,
              let row = Int(rowString),
              let column = Int(columnString) else {
            
            return
        }
        
        guard row > 1, column > 1 else {
            showAlertWith(title: "Введите количество количество элементов в столбце и строке больше 1!", actionTitle: "ОК", action: {})
            return
        }
        
        game = Game(column: column, row: row)
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)

        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "GameVC") as! GameViewController
        nextViewController.modalPresentationStyle = .overFullScreen
        nextViewController.game = game
        game?.delegate = nextViewController
        self.present(nextViewController, animated: true, completion: nil)

    }
    
}


//
//  ViewController.swift
//  TicTacToeApp
//
//  Created by Alexander Gallorini on 2022-12-03.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var playerNameLbl: UILabel!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var singleBtn: UIButton!
    
    @IBOutlet weak var multiBtn: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    @IBAction func singleBtn(_ sender: UIButton) {
        guard !nameField.text!.trimmingCharacters(in: .whitespaces).isEmpty else {return}
        
        let controller = storyboard?.instantiateViewController(withIdentifier: "singlePlayer") as! SingleViewController
        controller.playerName = nameField.text
        controller.modalTransitionStyle = .flipHorizontal
        controller.modalPresentationStyle = .fullScreen
        self.present(controller, animated: true, completion: nil)
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        nameField.resignFirstResponder()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let controller = segue.destination as? SingleViewController {
            controller.playerName = nameField.text
        }
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if identifier == "SingleViewController" {
            if nameField.text!.trimmingCharacters(in: .whitespaces).isEmpty {
                return false
            }
            
        }
        
        return true
        
    }
}



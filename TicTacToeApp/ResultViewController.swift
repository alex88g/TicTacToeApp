//
//  ResultViewController.swift
//  TicTacToeApp
//
//  Created by Alexander Gallorini on 2022-12-13.
//

import UIKit

class ResultViewController: UIViewController {

    @IBOutlet weak var playerLbl: UILabel!
    @IBOutlet weak var computerLbl: UILabel!
    @IBOutlet weak var multiPlayer1: UILabel!
    @IBOutlet weak var multiPlayer2: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

     
        score()
    }
    
    
    
    

    
    func score() {
        
        var array = UserDefaults.standard.object(forKey:"Score") as? Int

        NSLog("\(array)", CGFloat.pi)
        
        var result : Int = 0
        
        result = array!
        
        
        playerLbl.text = "Player: \(result)"
        
        
        
        
        var array2 = UserDefaults.standard.object(forKey:"ComputerScore") as? Int

        var resultC : Int = 0
        
        resultC = array2!
        
        computerLbl.text = "Computer: \(resultC)"
        
        
        
       
       
       
        var arrayPlayer1 = UserDefaults.standard.object(forKey:"ScorePlayer1") as? Int
        
        var resultPlayer1 : Int = 0
        
        resultPlayer1 = arrayPlayer1!
        
        multiPlayer1.text = "Player1: \(resultPlayer1)"
        
        
        
       
        
        var arrayPlayer2 = UserDefaults.standard.object(forKey:"ScorePlayer2") as? Int
        
        var resultPlayer2 : Int = 0
        
        resultPlayer2 = arrayPlayer2!
        
        multiPlayer2.text = "Player2: \(resultPlayer2)"
        
        
    }
    
    
    @IBAction func exitBtn3(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    
        
       
    
}

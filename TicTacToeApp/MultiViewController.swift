//
//  MultiViewController.swift
//  TicTacToeApp
//
//  Created by Alexander Gallorini on 2022-12-06.
//

import UIKit

class MultiViewController: UIViewController {
    
    // Enum grupp av värden som är relaterade dessutom renare kod
    enum Turn {
        case Nought
        case Cross
    }
    
    
    @IBOutlet weak var player2ScoreLbl: UILabel!
    @IBOutlet weak var player1ScoreLbl: UILabel!
    @IBOutlet weak var turnLabel: UILabel!
    
    @IBOutlet weak var a1: UIButton!
    @IBOutlet weak var a2: UIButton!
    @IBOutlet weak var a3: UIButton!
    @IBOutlet weak var b1: UIButton!
    @IBOutlet weak var b2: UIButton!
    @IBOutlet weak var b3: UIButton!
    @IBOutlet weak var c1: UIButton!
    @IBOutlet weak var c2: UIButton!
    @IBOutlet weak var c3: UIButton!
    
    
    
    
    
    
    
    
    
    var firstTurn = Turn.Cross
    var currentTurn = Turn.Cross
    
    var Nought = "0"
    var Cross = "X"
    var square = [UIButton]()
    
    var noughtsScore = 0
    var crossesScore = 0
    
    var Player1 : Int = 0
    var Player2 : Int = 0
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        initSquare()
        // Do any additional setup after loading the view.
    }
    
    func initSquare()
    {
        square.append(a1)
        square.append(a2)
        square.append(a3)
        square.append(b1)
        square.append(b2)
        square.append(b3)
        square.append(c1)
        square.append(c2)
        square.append(c3)
        
    }
    
    @IBAction func squareClicked(_ sender: UIButton) {
    
    
   
        makeChoice(sender)
        
        if checkWin(Cross) {
            
            crossesScore += 1
            result(title: "Player1 Win!")
            
            player1ScoreLbl.text = String((Int(player1ScoreLbl.text ?? "0") ?? 0) + 1)
            
           
            
            var arrayPlayer1 = UserDefaults.standard.object(forKey:"ScorePlayer1") as? Int
            
            Player1 = arrayPlayer1!
            Player1 = Player1 + 1
                  
                   UserDefaults.standard.set(Player1, forKey: "ScorePlayer1")
                   
                   
                    
                    NSLog("\(arrayPlayer1)", CGFloat.pi)
           
        }
        
        if checkWin(Nought) {
            
            noughtsScore += 1
            result(title: "Player2 Win!")
            
            player2ScoreLbl.text = String((Int(player2ScoreLbl.text ?? "0") ?? 0) + 1)
            
            
            var arrayPlayer2 = UserDefaults.standard.object(forKey:"ScorePlayer2") as? Int
            
            Player2 = arrayPlayer2!
            
            Player2 = Player2 + 1
           
            UserDefaults.standard.set(Player2, forKey: "ScorePlayer2")
            
            
           
            NSLog("\(arrayPlayer2)", CGFloat.pi)
        }
        if(loadSquare()) {
            
            result(title: "Draw")
            
        }
    }
    
    func checkWin(_ s :String) -> Bool {
        
        // Horisontal Victory
        if box(a1, s) && box(a2, s) && box(a3, s) {
            
            return true
    }
        
        if box(b1, s) && box(b2, s) && box(b3, s) {
            
            return true
    }
        
        if box(c1, s) && box(c2, s) && box(c3, s) {
            
            return true
        
    }
    
    // Vertical Victory
    if box(a1, s) && box(b1, s) && box(c1, s) {
        
        return true
}
    
    if box(a2, s) && box(b2, s) && box(c2, s) {
        
        return true
}
    
    if box(a3, s) && box(b3, s) && box(c3, s) {
        
        return true
}
        
        // Diagonal Victory
        if box(a1, s) && box(b2, s) && box(c3, s) {
            
            return true
    }
        
        if box(a3, s) && box(b2, s) && box(c1, s) {
            
            return true

    }
    return false
    
}
    func box(_ button: UIButton, _ symbol: String) -> Bool {
        
        return button.title(for: .normal) == symbol
    }
    
    func result(title: String) {
        
        let message = "\nNoughts" + String(noughtsScore) + "\n\nCrosses " + String(crossesScore)
        let ac = UIAlertController(title: title, message: nil, preferredStyle: .actionSheet)
        ac.addAction(UIAlertAction(title: "Reset", style: .default, handler: { (_) in
            self.resetGame()
            }))
            self.present(ac, animated: true)
        
    }
    
    func resetGame() {
        
        for button in square {
            
            button.setTitle(nil, for: .normal)
            button.isEnabled = true
        }
        if firstTurn == Turn.Nought {
            
            firstTurn = Turn.Cross
            turnLabel.text = Cross
        }
        else if firstTurn == Turn.Cross {
            
            firstTurn = Turn.Nought
            turnLabel.text = Nought
            
        }
    currentTurn = firstTurn
}
 
    func loadSquare() -> Bool {
       
        for button in square {
            
            if button.title(for: .normal) == nil {
                
                return false
            }
        }
        
        return true
}
    
    func makeChoice(_ sender: UIButton) {
        
        if(sender.title(for: .normal) == nil) {
            if(currentTurn == Turn.Nought) {
                
                sender.setTitle(Nought, for: .normal)
                currentTurn = Turn.Cross
                turnLabel.text = Cross
            }
            
            else if(currentTurn == Turn.Cross) {
                
                    sender.setTitle(Cross, for: .normal)
                    currentTurn = Turn.Nought
                    turnLabel.text = Nought                }
                
            }
            
            sender.isEnabled = false
            
        }
    }

        
        


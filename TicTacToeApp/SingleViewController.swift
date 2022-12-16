//
//  GameViewController.swift
//  TicTacToeApp
//
//  Created by Alexander Gallorini on 2022-12-05.
//

import UIKit

class SingleViewController: UIViewController {
    
    
    
    
    @IBOutlet weak var winLbl: UILabel!
    @IBOutlet weak var playerNameLbl: UILabel!
    @IBOutlet weak var playerScoreLbl: UILabel!
    @IBOutlet weak var computerScoreLbl: UILabel!
    
    @IBOutlet weak var box1: UIImageView!
    @IBOutlet weak var box2: UIImageView!
    @IBOutlet weak var box3: UIImageView!
    @IBOutlet weak var box4: UIImageView!
    @IBOutlet weak var box5: UIImageView!
    @IBOutlet weak var box6: UIImageView!
    @IBOutlet weak var box7: UIImageView!
    @IBOutlet weak var box8: UIImageView!
    @IBOutlet weak var box9: UIImageView!
    
    
    var playerName: String!
    var lastValue = "o"
    
    var playerTap: [Box] = []
    var computerTap: [Box] = []
    
    var Player = 0
    var Computer = 0
    
    
    
    
    
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        //Additional settings after the view loads.
        
        
        playerNameLbl.text = playerName + ":"
        
        createTap(on: box1, type: .one)
        createTap(on: box2, type: .two)
        createTap(on: box3, type: .three)
        createTap(on: box4, type: .four)
        createTap(on: box5, type: .five)
        createTap(on: box6, type: .six)
        createTap(on: box7, type: .seven)
        createTap(on: box8, type: .eight)
        createTap(on: box9, type: .nine)
        
        
        
    }
    
    
    
    

    
   
    enum Box: String, CaseIterable {
        case one, two, three, four, five, six, seven,eight, nine
       
    }

    func createTap(on imageView: UIImageView, type box: Box) {
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.squareClicked(_:)))
        tap.name = box.rawValue
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(tap)
        
        //NSLog makes sure that code is visible while operating program
       //NSLog("\(Player)", CGFloat.pi)
       
    }
    
    @objc func squareClicked(_ sender: UITapGestureRecognizer) {
        
        
        //print("Box: \(sender.name) was clicked")
        let selectedBox = getBox(from: sender.name ?? "")
        makeChoice(selectedBox)
        playerTap.append(Box(rawValue: sender.name!)!)
        //Here you call the function if user has made a choise
        checkWin()
        
        //shows speed in 0.5 seconds
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            //When the user select the last available location, this metod vill be triggered and vill immediately crash if we do not use the guard metod
            self.computer()
        }
        
    }
    
    func computer() {
        var availableSpaces = [UIImageView]()
        var availableBoxes = [Box]()
        for name in Box.allCases {
            let box = getBox(from: name.rawValue)
            if box.image == nil {
                availableSpaces.append(box)
                availableBoxes.append(name)
            }
        }
        
        //The guard metod is used here
        guard availableBoxes.count > 0 else { return}
        
        let randIndex = Int.random(in: 0 ..< availableSpaces.count)
        makeChoice(availableSpaces[randIndex])
        computerTap.append(availableBoxes[randIndex])
        //calling when computer has made choice
        checkWin()
        
    }
    
    func makeChoice(_ selectedBox: UIImageView) {
        guard selectedBox.image == nil else { return}
        
        if lastValue == "x" {
            selectedBox.image = #imageLiteral(resourceName: "0-removebg-preview")
            lastValue = "o"
            
        } else {
            selectedBox.image = #imageLiteral(resourceName: "x-removebg-preview")
            lastValue = "x"
        }
        
    }
    //Here we implement the function för random index
    func checkWin() {
        var correct = [[Box]]()
        
        //Implementation of the logic
       
        // Horisontal Victory
        
        let firstRow: [Box] = [.one, .two, .three]
        let secondRow: [Box] = [.four, .five, .six]
        let thirdRow: [Box] = [.seven, .eight, .nine]
      
        // Vertical Victory
        
        let firstCol: [Box] = [.one, .four, .seven]
        let secondCol: [Box] = [.two, .five, .eight]
        let thirdCol: [Box] = [.three, .six, .nine]
        
        // Diagonal Victory
        
        let backwardSlash: [Box] = [.one, .five, .nine]
        let forwardSlash: [Box] = [.three, .five, .seven]
        
        correct.append(firstRow)
        correct.append(secondRow)
        correct.append(thirdRow)
        correct.append(firstCol)
        correct.append(secondCol)
        correct.append(thirdCol)
        correct.append(backwardSlash)
        correct.append(forwardSlash)
        
        
        

        
        //implementation of player and computer
        for valid in correct {
            let userMatch = playerTap.filter {valid.contains($0) }.count
            let computerMatch = computerTap.filter { valid.contains($0) }.count
         
            //Shows if player has won and score
            if userMatch == valid.count {
                //Every time computer wins score increase with one
                playerScoreLbl.text = String((Int(playerScoreLbl.text ?? "0") ?? 0) + 1)
               
               
                winLbl.text = "Player has won!"
               
                //Player.text = computerScoreLbl
                //let array = playerTap.map{$0.rawValue}
                
                //User defaults check and saves the results
                var array = UserDefaults.standard.object(forKey:"Score") as? Int
                
                Player = array!
                
                Player = Player + 1
               
                UserDefaults.standard.set(Player, forKey: "Score")
                
                
                
//                NSLog("\(Player)", CGFloat.pi)
//                NSLog("\(array)", CGFloat.pi)

                //caling the function
                resetGame()
                break
                
                //Shows if computer won and score
                
            } else if computerMatch == valid.count {
                
                //Every time computer wins score increase with one
                computerScoreLbl.text = String((Int(computerScoreLbl.text ?? "0") ?? 0) + 1)
                
                winLbl.text = "Computer has won!"
                
                
                //UserDefaults.standard.set(computerTap, forKey: "Tap")
                //let array = playerTap.map{$0.rawValue}
                //UserDefaults.standard.set(Computer, forKey: "Score")
                
                //User defaults check and saves the results
                var array2 = UserDefaults.standard.object(forKey:"ComputerScore") as? Int
                
                Computer = array2!
                
                Computer = Computer + 1
               
                UserDefaults.standard.set(Computer, forKey: "ComputerScore")
                
                resetGame()
                break
                
                //Shows when it's draw
                
            } else if computerTap.count + playerTap.count == 9 {
                
                winLbl.text = " Draw "
                
                
                
                resetGame()
                break
                
                
                
                
            }
        }
        
    }
    // Implementation where the game is restarted
    func resetGame() {
        for name in Box.allCases {
            let box = getBox(from: name.rawValue)
            box.image = nil
        }
        
        // Restart last value
        lastValue = "o"
        playerTap = []
        computerTap = []
        
    
}
    func getBox(from name: String) -> UIImageView {
        let box = Box(rawValue: name) ?? .one
        
        switch box {
        case .one:
            return box1
        case .two:
            return box2
        case .three:
            return box3
        case .four:
            return box4
        case .five:
            return box5
        case .six:
            return box6
        case .seven:
            return box7
        case .eight:
            return box8
        case .nine:
            return box9
            
        
        }
    }
    //Animationen occours when the user presses the exit button to menu
    @IBAction func exitBtn(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
}



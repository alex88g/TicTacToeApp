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
    
    //var firstTurn = Turn.Cross
    //var currentTurn = Turn.Cross
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        

        // Do any additional setup after loading the view.
        
        
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
    }
    
    @objc func squareClicked(_ sender: UITapGestureRecognizer) {
        //print("Box: \(sender.name) was clicked")
        let selectedBox = getBox(from: sender.name ?? "")
        makeChoice(selectedBox)
        playerTap.append(Box(rawValue: sender.name!)!)
        checkWin()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
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
        
    
        guard availableBoxes.count > 0 else { return}
        
        let randIndex = Int.random(in: 0 ..< availableSpaces.count)
        makeChoice(availableSpaces[randIndex])
        computerTap.append(availableBoxes[randIndex])
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
    
    func checkWin() {
        var correct = [[Box]]()
        let firstRow: [Box] = [.one, .two, .three]
        let secondRow: [Box] = [.four, .five, .six]
        let thirdRow: [Box] = [.seven, .eight, .nine]
        
        let firstCol: [Box] = [.one, .two, .three]
        let secondCol: [Box] = [.four, .five, .six]
        let thirdCol: [Box] = [.seven, .eight, .nine]
        
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
        
        for valid in correct {
            let userMatch = playerTap.filter {valid.contains($0) }.count
            let computerMatch = computerTap.filter { valid.contains($0) }.count
            
            if userMatch == valid.count {
                playerScoreLbl.text = String((Int(playerScoreLbl.text ?? "0") ?? 0) + 1)
               
               
                winLbl.text = "Player has won!"
                
                   resetGame()
                break
            } else if computerMatch == valid.count {
                computerScoreLbl.text = String((Int(computerScoreLbl.text ?? "0") ?? 0) + 1)
                winLbl.text = "Computer has won!"
                
                resetGame()
                break
            } else if computerTap.count + playerTap.count == 9 {
                
                winLbl.text = " Draw! "
                
                resetGame()
                break
                
                
            }
        }
        
    }
    
    func resetGame() {
        for name in Box.allCases {
            let box = getBox(from: name.rawValue)
            box.image = nil
        }
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
    
}


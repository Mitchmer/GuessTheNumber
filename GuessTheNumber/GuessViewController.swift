//
//  GuessViewController.swift
//  GuessTheNumber
//
//  Created by Sam LoBue on 9/4/19.
//  Copyright © 2019 Mitch Merrell. All rights reserved.
//

import UIKit

class GuessViewController: UIViewController {

    // MARK: - Outlets
    
    @IBOutlet weak var heart5ImageView: UIImageView!
    @IBOutlet weak var heart4ImageView: UIImageView!
    @IBOutlet weak var heart3ImageView: UIImageView!
    @IBOutlet weak var heart2ImageView: UIImageView!
    @IBOutlet weak var heart1ImageView: UIImageView!
    @IBOutlet weak var mainStackView: UIStackView!
    @IBOutlet weak var billboardTextField: UILabel!
    @IBOutlet weak var guessTextField: UITextField!
    @IBOutlet weak var confettiImageView: UIImageView!
    @IBOutlet weak var guessButton: UIButton!
    @IBOutlet weak var lowerBoundTextField: UITextField!
    @IBOutlet weak var higherBoundTextField: UITextField!
    @IBOutlet weak var heartContainerStackView: UIStackView!
    
    // MARK: - Properties

    var lives: Int = 5
    var numberToGuess: Int = 0
    var didWin: Bool = false
    var negativeMessages: [String] = [
        "Too low, guess again", "Not high enough", "Aim higher", "Don't give up, it's worth it in the end", "Maybe you should delete this app"
    ]
    var positiveMessages: [String] = [
        "Too high, guess again", "Not low enough", "Aim lower", "You're doing well", "Don't give up, it's worth it in the end"
    ]
    var topRange: Int = 100
    var lowerRange: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        generateNumber()
        
    }
    
    // MARK: - Actions
    
    @IBAction func guessButtonTapped(_ sender: Any) {
//        animateConfetti()
        guard let guess = guessTextField.text, let num = Int(guess) else { return }
        if !didWin {
            guessedNumberScreenInteration(from: num)
            updateHearts()
            if lives == 0 {
                billboardTextField.text = "YOU LOST"
                guessButton.setTitle("Reset?", for: .normal)
                didWin.toggle()
            }
        } else {
            resetGame()
        }
    }
    @IBAction func setButtonTapped(_ sender: Any) {
        guard let lowRange = lowerBoundTextField.text, let highRange = higherBoundTextField.text else { return }
        lowerRange = Int(lowRange) ?? 0
        topRange = Int(highRange) ?? 100
        resetHearts()
        generateNumber()
        print("\(lowerRange) to \(topRange)")
    }
    
    // MARK: - Functions
    
    func generateNumber() {
        numberToGuess = Int.random(in: lowerRange..<topRange)
    }
    
    func guessedNumberScreenInteration(from guess: Int) {
        if guess == numberToGuess {
//            animateConfetti()
            self.billboardTextField.text = "You got it"
            didWin.toggle()
            guessButton.setTitle("Reset?", for: .normal)
            
        } else if guess > numberToGuess {
            let randomSubscript = Int.random(in: 0..<4)
            self.billboardTextField.text = positiveMessages[randomSubscript]
        } else if guess < numberToGuess {
            let randomSubscript = Int.random(in: 0..<4)
            self.billboardTextField.text = negativeMessages[randomSubscript]
        }
    }
    
    func resetGame() {
        didWin.toggle()
        numberToGuess = Int.random(in: 1..<5)
        guessButton.setTitle("Guess!", for: .normal)
        billboardTextField.text = "GUESS \nTHE \nNUMBER"
        guessTextField.text = ""
        resetHearts()
    }
    
    func resetHearts() {
        lives = 5
        heart1ImageView.image = UIImage(named: "liveheart")
        heart2ImageView.image = UIImage(named: "liveheart")
        heart3ImageView.image = UIImage(named: "liveheart")
        heart4ImageView.image = UIImage(named: "liveheart")
        heart5ImageView.image = UIImage(named: "liveheart")
    }
    
    func animateConfetti() {
        self.confettiImageView.center.y -= self.view.bounds.height
        UIView.animate(withDuration: 8, delay: 0, options: [.repeat], animations: { self.confettiImageView.center.y += 3 * self.view.bounds.height}, completion: nil)
    }
    
    func updateHearts() {
        lives -= 1
        
        switch lives {
        case 4:
            heart5ImageView.image = UIImage(named: "deadheart")
        case 3:
            heart4ImageView.image = UIImage(named: "deadheart")
        case 2:
            heart3ImageView.image = UIImage(named: "deadheart")
        case 1:
            heart2ImageView.image = UIImage(named: "deadheart")
        case 0:
            heart1ImageView.image = UIImage(named: "deadheart")
        default:
            return
        }
    }
}

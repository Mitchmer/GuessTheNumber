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
    @IBOutlet weak var billboardTextField: UILabel!
    
    @IBOutlet weak var guessTextField: UITextField!
    
    @IBOutlet weak var confettiImageView: UIImageView!
    
    @IBOutlet weak var guessButton: UIButton!
    
    
    // MARK: - Properties

    var numberToGuess: Int = 0
    var didWin: Bool = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        numberToGuess = Int.random(in: 1..<5)
        
    }
    
    // MARK: - Actions
    @IBAction func guessButtonTapped(_ sender: Any) {
        guard let guess = guessTextField.text, let num = Int(guess) else { return }
        if !didWin {
            guessedNumberScreenInteration(from: num)
        } else {
            resetGame()
        }
        
        
    }
    
    // MARK: - Functions

    
    func guessedNumberScreenInteration(from guess: Int) {
        
        if guess == numberToGuess {
            self.billboardTextField.text = "You got it"
            didWin.toggle()
            guessButton.setTitle("Reset?", for: .normal)
        } else if guess > numberToGuess {
            self.billboardTextField.text = "A little high, try again"
        } else if guess < numberToGuess {
            billboardTextField.text = "A little low, try again"
        }
    }
    
    func resetGame() {
        didWin.toggle()
        numberToGuess = Int.random(in: 1..<5)
        guessButton.setTitle("Guess", for: .normal)
        billboardTextField.text = "Guess \nThe \nNumber"
        guessTextField.text = ""
    }
    
    func animateConfetti() {
        
        self.confettiImageView.center.y -= self.view.bounds.width
        
        
        UIView.animate(withDuration: 8, delay: 0, options: [.repeat], animations: { self.confettiImageView.center.y += 4 * self.view.bounds.height}, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

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
    
    // MARK: - Properties

    var numberToGuess: Int = 0
   
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        numberToGuess = Int.random(in: 1..<5)
        
    }
    
    // MARK: - Actions
    @IBAction func guessButtonTapped(_ sender: Any) {
        
        guard let guess = guessTextField.text, let num = Int(guess) else { return }
        
        compareNumbers(num: num) { (num) in
            guessedNumberScreenInteration(from: num)
        }
        
    }
    
    // MARK: - Functions
    
    func compareNumbers(num: Int, completion: (Int) -> Void) {
        if num > numberToGuess {
            
            let distanceFromGuessedNumber = num - numberToGuess
            print("guess number: \(num) random number: \(numberToGuess) distance \(distanceFromGuessedNumber)")
            completion(distanceFromGuessedNumber)
            return
            
        } else {
            
            let distanceFromGuessedNumber =  numberToGuess - num
            print("guess number: \(num) random number: \(numberToGuess) distance \(distanceFromGuessedNumber)")
            return
        }
    }
    
    func guessedNumberScreenInteration(from guess: Int) {
        
        if guess == numberToGuess {
            self.billboardTextField.text = "You got it"
        } else if guess > numberToGuess {
            self.billboardTextField.text = "A little high, try again"
        } else if guess < numberToGuess {
            self.billboardTextField.text = "A little low, try again"
        }
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

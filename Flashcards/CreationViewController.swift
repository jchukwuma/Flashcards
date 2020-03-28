//
//  CreationViewController.swift
//  Flashcards
//
//  Created by jchukwuma18 on 3/6/20.
//  Copyright © 2020 jchukwuma18. All rights reserved.
//

import UIKit

class CreationViewController: UIViewController {

    var flashcardsController: ViewController!
    
    @IBOutlet weak var questionTextField: UITextField!
    @IBOutlet weak var answerTextField: UITextField!
    @IBOutlet weak var extraAnswerOne: UITextField!
    @IBOutlet weak var extraAnswerTwo: UITextField!
    
    var initialQuestion: String?
    var initialAnswer: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        questionTextField.text = initialQuestion
        answerTextField.text = initialAnswer
    }
    
    @IBAction func didTaponCancel(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @IBAction func didTaponDone(_ sender: Any) {
        // Get the text in the question text box
               let questionText = questionTextField.text
               
               // Get the text in the answer text box
               let answerText = answerTextField.text
        if questionText == nil || answerText == nil || questionText!.isEmpty || answerText!.isEmpty {
            let alert = UIAlertController(title: "Missing text", message: "You need to enter both a question and an answer", preferredStyle: UIAlertController.Style .alert)
            let okAction = UIAlertAction(title: "Ok", style: .default)
            alert.addAction(okAction)
            present(alert, animated: true)
        } else {
        
        
              // call the update flashcards function
            var isExisting = false
            if (initialQuestion != nil) {
                isExisting = true
            }
            flashcardsController.updateFlashcard(question: questionText!, answer: answerText!, extraAnswerOne: extraAnswerOne.text, extraAnswerTwo: extraAnswerTwo.text, isExisting: isExisting)
               
               // dismiss screen
               dismiss(animated:true);
        }
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    */
    
    

}

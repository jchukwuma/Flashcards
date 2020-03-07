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
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func didTaponCancel(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @IBAction func didTaponDone(_ sender: Any) {
        // Get the text in the question text box
               let questionText = questionTextField.text
               
               // Get the text in the answer text box
               let answerText = answerTextField.text
               
              // call the update flashcards function
               flashcardsController.updateFlashcard(question: questionText!, answer: answerText!)
               
               // dismiss screen
               dismiss(animated:true);
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    */
    
    

}

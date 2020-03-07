//
//  ViewController.swift
//  Flashcards
//
//  Created by jchukwuma18 on 2/21/20.
//  Copyright © 2020 jchukwuma18. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var backLabel: UILabel!
    @IBOutlet weak var frontLabel: UILabel!
    @IBOutlet weak var questionTextField: UITextField!
    @IBOutlet weak var answerTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func didTaponFlashcard(_ sender: Any) {
        frontLabel.isHidden = true
    }
    
    func updateFlashcard(question: String, answer: String){
        questionTextField.text = question
        answerTextField.text = answer
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
           // Get the new view controller using segue.destination.
           let navigationController = segue.destination as! UINavigationController
           // Pass the selected object to the new view controller.
           let creationController = navigationController.topViewController as! CreationViewController
           creationController.flashcardsController = self
        
       }
    
}


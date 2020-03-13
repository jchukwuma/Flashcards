//
//  ViewController.swift
//  Flashcards
//
//  Created by jchukwuma18 on 2/21/20.
//  Copyright © 2020 jchukwuma18. All rights reserved.
//

import UIKit

struct Flashcards {
    var question: String
    var answer: String
}

class ViewController: UIViewController {

    @IBOutlet weak var backLabel: UILabel!
    @IBOutlet weak var frontLabel: UILabel!
    // @IBOutlet weak var questionTextField: UITextField!
    // @IBOutlet weak var answerTextField: UITextField!
    @IBOutlet weak var prevButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    
    
    //Array to hold our flashcards
    var flashcards = [Flashcards]()
    
    //index in array flashcards
    var currentIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        

        // read saved flashcards
        readSavedFlashcards()
        
        //Adding initial flashcard in necessary
        if flashcards.count == 0 {
            updateFlashcard(question: "Who  is the first black president of the United States of America", answer: "Barack Hussein Obama II")
        } else {
            updateLabels()
            updateNextPrevButtons()
        }
    }

    @IBAction func didTaponFlashcard(_ sender: Any) {
        frontLabel.isHidden = !frontLabel.isHidden
    }
    
    @IBAction func didTaponPrev(_ sender: Any) {
        // decrease current index
        currentIndex = currentIndex - 1
        // update labels
        updateLabels()
        // update buttons
        updateNextPrevButtons()
    }
    
    @IBAction func didTaponNext(_ sender: Any) {
        // increase current index
        currentIndex = currentIndex + 1
        // update labels
        updateLabels()
        // update buttons
        updateNextPrevButtons()
    }
    
    func updateFlashcard(question: String, answer: String){
        let flashcard = Flashcards(question: question, answer: answer)
        
        flashcards.append(flashcard)
        
        // Logging onto console
        print("Added new flashcard")
        print("We now have \(flashcards.count) flashcard(s)")
        
        // update current index
        currentIndex = flashcards.count - 1
        print("Our current index is \(currentIndex)")
        
        // update buttons
        updateNextPrevButtons()
        
        // update labels
        updateLabels()
        
        // save flashcards
        saveAllFlashcardsToDisk()
    }
    func updateNextPrevButtons(){
        // Disable nextButton if at end
        if currentIndex == flashcards.count - 1 {
            nextButton.isEnabled = false
        } else {
            nextButton.isEnabled = true
        }
        // Disable prevButton if at beginning
        if currentIndex == 0 {
            prevButton.isEnabled = false
        } else {
            prevButton.isEnabled = true
        }
    }
    func updateLabels(){
        // Get current flashcard
        let currentFlashcard = flashcards[currentIndex]
        
        // Update labels
        frontLabel.text = currentFlashcard.question
        backLabel.text = currentFlashcard.answer
    }
    func saveAllFlashcardsToDisk(){
        // from flashcard array to dictionary array
        let dictionaryArray = flashcards.map { (card) -> [String: String] in return ["question": card.question, "answer": card.answer]
        }
        // save array on disk using UserDefaults
        UserDefaults.standard.set(dictionaryArray, forKey: "flashcards")
        // Log it
        print("Flashcards saved to UserDefaults")
    }
    func readSavedFlashcards(){
        //read dictionary array from disk if any
        if let dictionaryArray = UserDefaults.standard.array(forKey: "flashcards") as? [[String: String]] {
            // code to run if we have a dictionary array
            let savedCards = dictionaryArray.map {dictionary -> Flashcards in return Flashcards(question: dictionary["question"]!, answer: dictionary["answer"]!)
            }
            // Put all these cards in flashcards array
            flashcards.append(contentsOf: savedCards)
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
           // Get the new view controller using segue.destination.
           let navigationController = segue.destination as! UINavigationController
           // Pass the selected object to the new view controller.
           let creationController = navigationController.topViewController as! CreationViewController
           creationController.flashcardsController = self
        
       }
    
}


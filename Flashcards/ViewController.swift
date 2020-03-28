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
    @IBOutlet weak var prevButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var card: UIView!
    @IBOutlet weak var btnOptionOne: UIButton!
    @IBOutlet weak var btnOptionTwo: UIButton!
    @IBOutlet weak var btnOptionThree: UIButton!
    
    //Array to hold our flashcards
    var flashcards = [Flashcards]()
    
    //index in array flashcards
    var currentIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        card.layer.cornerRadius = 20.0
        backLabel.layer.cornerRadius = 20.0
        frontLabel.layer.cornerRadius = 20.0
        frontLabel.clipsToBounds = true
        backLabel.clipsToBounds = true
        card.layer.shadowRadius = 15.0
        card.layer.shadowOpacity = 0.2
        
        btnOptionOne.layer.borderWidth = 3.0
        btnOptionTwo.layer.borderWidth = 3.0
        btnOptionThree.layer.borderWidth = 3.0
        btnOptionOne.layer.borderColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
        btnOptionTwo.layer.borderColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
        btnOptionThree.layer.borderColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
        
        // read saved flashcards
        readSavedFlashcards()
        
        //Adding initial flashcard in necessary
        if flashcards.count == 0 {
            updateFlashcard(question: "Who is the first black president of the United States of America", answer: "Barack Hussein Obama II", extraAnswerOne: "Denzel Washington", extraAnswerTwo: "Terry Crews", isExisting: false)
        } else {
            updateLabels()
            updateNextPrevButtons()
        }
    }

    @IBAction func didTaponFlashcard(_ sender: Any) {
        flipFlashcard()
    }
    func flipFlashcard(){
        frontLabel.isHidden = !frontLabel.isHidden
        UIView.transition(with: card, duration: 0.3, options: .transitionFlipFromRight, animations: {
            self.frontLabel.isHidden = !self.frontLabel.isHidden
        })
    }
    
    @IBAction func didTaponPrev(_ sender: Any) {
        // decrease current index
        currentIndex = currentIndex - 1
        // update labels
        updateLabels()
        // update buttons
        updateNextPrevButtons()
        animateCardOutPrev()
    }
    
    @IBAction func didTaponNext(_ sender: Any) {
        // increase current index
        currentIndex = currentIndex + 1
        // update buttons
        updateNextPrevButtons()
        animateCardOutNext()
    }
    
    @IBAction func didTapBtnOne(_ sender: Any) {
        btnOptionOne.isHidden = true
    }
    
    @IBAction func didTapBtnTwo(_ sender: Any) {
        frontLabel.isHidden = true
    }
    
    @IBAction func didTapBtnThree(_ sender: Any) {
        btnOptionThree.isHidden = true
    }
    @IBAction func didTapOnDelete(_ sender: Any) {
        let alert = UIAlertController(title: "Delete flashcard", message: "Are you sure you want to  delete it", preferredStyle: .actionSheet)
        let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { (action) in
            self.deleteCurrentFlashcard()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        alert.addAction(deleteAction)
        alert.addAction(cancelAction)
    }
    
    func updateFlashcard(question: String, answer: String, extraAnswerOne: String?, extraAnswerTwo: String?, isExisting: Bool){
            
        let flashcard = Flashcards(question: question, answer: answer)
        if isExisting {
            flashcards[currentIndex] =  flashcard
        } else {
        flashcards.append(flashcard)
        btnOptionOne.setTitle(extraAnswerOne, for: .normal)
        btnOptionTwo.setTitle(answer, for: .normal)
        btnOptionThree.setTitle(extraAnswerTwo, for: .normal)
        
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
    func deleteCurrentFlashcard(){
        // delete current
        if flashcards.count > 0{
            flashcards.remove(at: currentIndex)
        }
        
        // special Case: Check if last card was deleted
        if currentIndex > flashcards.count - 1{
            currentIndex = flashcards.count - 1
        }
        updateNextPrevButtons()
        updateLabels()
        saveAllFlashcardsToDisk()
    }
    func animateCardOutNext(){
        UIView.animate(withDuration: 0.3, animations: {self.card.transform = CGAffineTransform.identity.translatedBy(x: -300.0, y: 0)}, completion: {finished in
            // update labels
            self.updateLabels()
            // run other animation
            self.animateCardInNext()
        })
    }
    func animateCardInNext(){
        
        card.transform = CGAffineTransform.identity.translatedBy(x: 300.0, y:0)
        
        UIView.animate(withDuration: 0.3){
            self.card.transform = CGAffineTransform.identity
        }
    }
    func animateCardOutPrev(){
        UIView.animate(withDuration: 0.3, animations: {self.card.transform = CGAffineTransform.identity.translatedBy(x: 300.0, y: 0)}, completion: {finished in
            //run other animation
            self.animateCardInPrev()
            // update labels
            // self.updateLabels()
        })
    }
        
    func animateCardInPrev() {
        
        card.transform = CGAffineTransform.identity.translatedBy(x: -300.0, y:0)
        self.updateLabels()
        UIView.animate(withDuration: 0.3){
            self.card.transform = CGAffineTransform.identity
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
           // Get the new view controller using segue.destination.
           let navigationController = segue.destination as! UINavigationController
           // Pass the selected object to the new view controller.
           let creationController = navigationController.topViewController as! CreationViewController
           creationController.flashcardsController = self
            
        if segue.identifier == "EditSegue" {
            creationController.initialQuestion = frontLabel.text
            creationController.initialAnswer = backLabel.text
    }
       }
    
}


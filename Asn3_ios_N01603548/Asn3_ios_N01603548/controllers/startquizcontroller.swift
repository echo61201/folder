//
//  startquizcontroller.swift
//  Asn3_ios_N01603548
//
//  Created by Chelsea on 2024-11-04.
//

import UIKit

class startquizcontroller: UIViewController {
    
    @IBOutlet weak var btnSubmit: UIButton!
    
    @IBOutlet weak var lblQuestionText: UILabel!
    
    //all the buttons
    @IBOutlet weak var radioButton1: UIButton!
    
    @IBOutlet weak var radioButton2: UIButton!
    
    @IBOutlet weak var radioButton3: UIButton!
    
    @IBOutlet weak var radioButton4: UIButton!
    
    // all labels
    
    @IBOutlet weak var lblAnswer1: UILabel!
    
    @IBOutlet weak var lblAnwer2: UILabel!
    
    
    @IBOutlet weak var lblAnswer3: UILabel!
    
    
    @IBOutlet weak var lblAnswer4: UILabel!
    
    
    var answerLabels:[UILabel] {
        return [lblAnswer1,lblAnwer2,lblAnswer3,lblAnswer4]
    }
    //the reason why we do an buttons array is because
    //we wanna manage the buttons together
    //if we simply create one outlet action and drag all the buttons into it
    // the user may
    var radioButtons:[UIButton] {
        return [radioButton1,radioButton2,radioButton3,radioButton4]
    }
    
    
    @IBOutlet weak var progressBar: UIProgressView!
    
    
    
    @IBOutlet weak var btnPrevious: UIButton!
    
    
    @IBOutlet weak var btnNext: UIButton!
    
    
    var questions:[Question] {
        return QuestionBank.shared.questions
    }
    var currentQuestionIndex = 0;
    var correctAnswerIndex: Int?
    //2 for not selected, 1 for correct, 0 for false
    //var results:[Int] = []
    var choices:[Choice] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "My quiz"
        if (questions.count == 0) {
            showAlert("ops", "there's nothing here")
            btnPrevious.isEnabled =  false
            btnNext.isEnabled = false
            btnSubmit.isEnabled = false
            return
        }else {
            // Do any additional setup after loading the view.
            for question in questions {
                let shuffledAnswers = [question.correctAnswer,question.false1,question.false2,question.false3].shuffled()
                choices.append(Choice(shuffledAnswers: shuffledAnswers))
            }
            loadQuestion(currentQuestionIndex)
            updateButtonState()
            updateProgressBar()
        }
        
        
        
        
        
        
    }
    
    
    @IBAction func radioButtonClicked(_ sender: UIButton) {
        // if clicked, first deselect all the buttons,
        // that's why we need the radioButtons collection
        // and of course we can deselect them one by one
        // but using a collection make things easier
        // Deselect all buttons
        for button in radioButtons {
            button.setImage(UIImage(systemName: "circle"), for: .normal)
        }
        
        // Select clicked button
        sender.setImage(UIImage(systemName: "circle.fill"), for: .normal)
        
        guard let selectedButtonIndex = radioButtons.firstIndex(of: sender) else { return }
        
        // Update the selected answer index in `Choice`
        let currentChoice = choices[currentQuestionIndex]
        currentChoice.selectedAnswerIndex = selectedButtonIndex
        
        // Update the status for correctness
        if selectedButtonIndex == correctAnswerIndex {
            currentChoice.status = 1  // Correct
        } else {
            currentChoice.status = 0  // Incorrect
        }
        
    }
    
    //!!!important: link the button index to answer index
    
    func loadQuestion(_ index: Int) {
        guard index >= 0 && index < questions.count else { return }
        let question = questions[index]
        
        lblQuestionText.text = question.questionText
        let currentChoice = choices[index]
        
        // Find and store the correct answer index within shuffled answers
        correctAnswerIndex = currentChoice.shuffledAnswers.firstIndex(of: question.correctAnswer)
        
        // Display shuffled answers in labels
        for (i, choiceText) in currentChoice.shuffledAnswers.enumerated() {
            if i < answerLabels.count {
                answerLabels[i].text = choiceText
            }
        }
        
        // Display the selected state for each button
        for (i, button) in radioButtons.enumerated() {
            if i == currentChoice.selectedAnswerIndex {
                button.setImage(UIImage(systemName: "circle.fill"), for: .normal)
            } else {
                button.setImage(UIImage(systemName: "circle"), for: .normal)
            }
        }
    }
    
    
    
    @IBAction func btnPrevious(_ sender: UIButton) {
        currentQuestionIndex -= 1
        loadQuestion(currentQuestionIndex)
        updateProgressBar()
        updateButtonState()
    }
    
    
    
    @IBAction func btnNext(_ sender: UIButton) {
        currentQuestionIndex += 1
        loadQuestion(currentQuestionIndex)
        updateProgressBar()
        updateButtonState()
        
    }
    
    
    
    
    func showAlert(_ title:String, _ msg:String) {
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "ok", style: .default, handler: nil))
        present(alert,animated: true,completion: nil)
    }
    
    
    func updateProgressBar() {
        let progress = Float(currentQuestionIndex + 1) / Float(questions.count)
        progressBar.setProgress(progress, animated: true)
    }
    
    
    func updateButtonState(){
        btnPrevious.isEnabled = true
        btnNext.isEnabled = true
        btnSubmit.isEnabled = false
        if currentQuestionIndex == 0 {btnPrevious.isEnabled = false}
        if currentQuestionIndex == questions.count - 1 {
            btnNext.isEnabled = false
            btnSubmit.isEnabled = true
        }
    }
    
    
    
    @IBAction func btnSubmit(_ sender: UIButton) {
        let notAnsweredCount = choices.filter { $0.status == 2 }.count
        if notAnsweredCount == 0 {
            let alert = UIAlertController(title: "Submit Quiz", message: "Submit?", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            alert.addAction(UIAlertAction(title: "Submit", style: .default, handler: { _ in self.calculateAndShowScore() }))
            present(alert, animated: true)
        } else {
            let alert = UIAlertController(title: "Quiz Incomplete", message: "Missing \(notAnsweredCount) answers. Submit anyway?", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            alert.addAction(UIAlertAction(title: "Submit Anyway", style: .default, handler: { _ in
                self.markUnansweredAsIncorrect()
                self.calculateAndShowScore()
            }))
            present(alert, animated: true)
        }
    }
    
    func calculateAndShowScore() {
        let correctCount = choices.filter { $0.status == 1 }.count
        let score = Float(correctCount) / Float(questions.count) * 100
        showAlert("Score", "Your score: \(Int(score))")
    }
    
    func markUnansweredAsIncorrect() {
        for choice in choices {
            if choice.status == 2 {
                choice.status = 0  // Treat unanswered questions as incorrect
            }
        }
    }
    
    
}

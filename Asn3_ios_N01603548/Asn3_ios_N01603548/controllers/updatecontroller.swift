//
//  updatecontroller.swift
//  Asn3_ios_N01603548
//
//  Created by Chelsea on 2024-11-05.
//

import UIKit

class updatecontroller: UIViewController {
    
    @IBOutlet weak var lblQuestion: UILabel!
    
    @IBOutlet weak var lblCorrect: UILabel!
    
    @IBOutlet weak var lblFalse1: UILabel!
    
    @IBOutlet weak var lblFalse2: UILabel!
    
    @IBOutlet weak var lblFalse3: UILabel!
    
    var question : Question?
    var index : Int? //this is used to update the question
    var questionController : questionsBankController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "update question"
        
        if let questionToEdit = question {
            lblQuestion.text = questionToEdit.questionText
            lblCorrect.text = questionToEdit.correctAnswer
            lblFalse1.text = questionToEdit.false1
            lblFalse2.text = questionToEdit.false2
            lblFalse3.text = questionToEdit.false3
        }
    }
    
    
    
    @IBAction func btnCancel(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func btnSave(_ sender: UIButton) {
        question?.questionText = lblQuestion.text ?? ""
        question?.correctAnswer = lblCorrect.text ?? ""
        question?.false1 = lblFalse1.text ?? ""
        question?.false2 = lblFalse2.text ?? ""
        question?.false3 = lblFalse3.text ?? ""
        
        // now we need to assign this updated question back
        guard let question = question,
              let questionController = questionController,
              let index = index else {
            showAlert("error", "missing data")
            return
        }
        
        questionController.updateQuestion(question, questionController, index)
        navigationController?.popViewController(animated: true)
    }
    /*
    func updateQuestion (_ question : Question, _ controller:questionsBankController, _ index: Int){
        controller.questions[index] = question
        controller.tableView.reloadData()
    }
     */
    
    
    
    @IBAction func btnQuestion(_ sender: UIButton) {
        enterStuff("question", "please update the question", lblQuestion)
    }
    
    
    @IBAction func btnCorrect(_ sender: UIButton) {
        enterStuff("correct", "please enter correct answer", lblCorrect)
    }
    
    
    @IBAction func btnFalse1(_ sender: UIButton) {
        enterStuff("false1", "please enter false1", lblFalse1)
    }
    
    
    @IBAction func btnFalse2(_ sender: UIButton) {
        enterStuff("false2", "please enter false2", lblFalse2)
    }
    
    
    @IBAction func btnFalse3(_ sender: UIButton) {
        enterStuff("false3", "please enter false3", lblFalse3)
    }
    
    
    
    func showAlert(_ title:String, _ msg:String) {
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "ok", style: .default, handler: nil))
        present(alert,animated: true,completion: nil)
    }
    
    func enterStuff(_ title:String,_ msg:String,_ lbl:UILabel) {
        let alertController = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        alertController.addTextField{textFiled in
            textFiled.placeholder = msg
        }
        let okAction = UIAlertAction(title: "ok", style: .default) {_ in
            if let input = alertController.textFields?.first?.text, !input.isEmpty {
                lbl.text = input
            }else {
                self.showAlert("error", "invalid input")
            }
        }
        let cancelAction = UIAlertAction(title: "cancel", style: .default, handler: nil)
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        present(alertController,animated: true)
        
    }
    
    
    

    

}

//
//  questionbuildercontroller.swift
//  Asn3_ios_N01603548
//
//  Created by Chelsea on 2024-11-04.
//

import UIKit

class questionbuildercontroller: UIViewController {

    @IBOutlet weak var lblFalse3: UILabel!
    @IBOutlet weak var lblFalse2: UILabel!
    @IBOutlet weak var lblFalse1: UILabel!
    @IBOutlet weak var lblCorrect: UILabel!
    @IBOutlet weak var lblQuestion: UILabel!
    
    var bankController:questionsBankController?
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "question builder"
        //initialize the labels
        lblFalse1.text = "incorrect1"
        lblFalse2.text = "incorrect2"
        lblFalse3.text = "incorrect3"
        lblCorrect.text = "correctLabel"
        lblQuestion.text = "questionLabel"
        

        // Do any additional setup after loading the view.
    }
    

    @IBAction func btnEnterQuestion(_ sender: UIButton) {
        enterStuff("question", "please enter question", lblQuestion)
    }
    
    @IBAction func btnCorrect(_ sender: UIButton) {
        enterStuff("correct", "please enter correct answer", lblCorrect)
    }
    
    
    @IBAction func btnIncorrect1(_ sender: UIButton) {
        enterStuff("incorrect", "please enter incorrect 1", lblFalse1)
    }
    
    
    @IBAction func btnIncorrect2(_ sender: UIButton) {
        enterStuff("incorrect", "please enter incorrect 2", lblFalse2)
    }
    
    
    @IBAction func btnIncorrect3(_ sender: UIButton) {
        enterStuff("incorrect", "please tner inccorect 3", lblFalse3)
    }
    
    
    @IBAction func btnCancel(_ sender: UIButton) {
        //cancel functions like a clear
        /*
        let questionBankController = storyboard?.instantiateViewController(withIdentifier: "bankbuild") as! questionsBankController
        navigationController?.pushViewController(questionBankController, animated: true)
         */
        navigationController?.popViewController(animated: true)
    }
    
    
    //save button
    //save the data and pass it to bank build
    //first we gonna create  a tableview in bankbuild and of course we can slide down
    //the tableview should have 5 labels
    //question text, correct answer, and all 3 incorrect answers
    
    
    @IBAction func btnSave(_ sender: UIButton) {
        let question = Question(
            questionText: lblQuestion.text ?? "", correctAnswer: lblCorrect.text ?? "", false1: lblFalse1.text ?? "", false2: lblFalse2.text ?? "", false3: lblFalse3.text ?? ""
        )
        bankController?.addQuestion(question)
        print("question added \(question)")
        navigationController?.popViewController(animated: true)
        
        
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

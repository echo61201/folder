//
//  questionsBankController.swift
//  Asn3_ios_N01603548
//
//  Created by Chelsea on 2024-11-04.
//

import UIKit

class questionsBankController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    

    @IBOutlet weak var tableView: UITableView!
    
    //var questions: [Question] = []
    
    var questions:[Question] {
        get {return QuestionBank.shared.questions}
        set {QuestionBank.shared.questions = newValue}
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "question bank"
        tableView.rowHeight = 250 // Set your desired row height
        tableView.dataSource = self
        tableView.delegate = self
        
    }
    

    @IBAction func btnOpenQuestionBuilder(_ sender: UIButton) {
        if let builderController = storyboard?.instantiateViewController(withIdentifier: "questionbuilder") as? questionbuildercontroller {
            // Check if navigationController is available before pushing
            builderController.bankController = self
            if let navigationController = self.navigationController {
                navigationController.pushViewController(builderController, animated: true)
            } else {
                print("NavigationController not found.")
            }
        } else {
            print("questionbuildercontroller could not be instantiated.")
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return questions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "questioncell", for: indexPath) as? QuestionTableViewCell else {
            fatalError("Could not dequeue cell with identifier: questioncell")
        }
        
        let question = questions[indexPath.row]
        cell.lblQuestion.text = question.questionText
        cell.lblCorrectAnswer.text = question.correctAnswer
        cell.lblFalse1.text = question.false1
        cell.lblFalse2.text = question.false2
        cell.lblFalse3.text = question.false3

        print("Configured cell for question: \(question)") // Debugging line
        return cell
    }

    
    func addQuestion(_ question:Question) {
        questions.append(question)
        print("question added\(question)")
        tableView.reloadData()
    }
    
    func updateQuestion (_ question : Question, _ controller:questionsBankController, _ index: Int){
        controller.questions[index] = question
        controller.tableView.reloadData()
    }
    

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedIndex = indexPath.row
        let selectedQuestion = questions[indexPath.row]
        if let updateController = self.storyboard?.instantiateViewController(withIdentifier: "update") as? updatecontroller {
            updateController.questionController = self
            updateController.index = selectedIndex
            updateController.question = selectedQuestion
            self.navigationController?.pushViewController(updateController, animated: true)
            
        }
    }
    

}

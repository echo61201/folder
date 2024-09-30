//
//  ViewController.swift
//  bmiCalculator
//
//  Created by Chelsea on 2024-09-29.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var txtresult: UILabel!
    
    @IBOutlet weak var txtweight: UITextField!
    
    @IBOutlet weak var txtheight: UITextField!
    
    
    @IBOutlet weak var lblmeasure: UILabel!
    
    @IBAction func btncalcualte(_ sender: Any) {
        guard let weightstr = txtweight.text,
              let heightstr = txtheight.text,
              let weight = (Double(weightstr)),
              let height = (Double(heightstr))
        else {
            showError(message: "invalid input detected!")
            return
        }
        
        if weight <= 0 || height <= 0 {
            showError(message: "no input <= 0")
            return
        }
        //initiate the bmi
        let bmi: Double
        let category : String
        if lblmeasure.text == "Metric" {
            bmi = weight / pow(height / 100,2)
        }else {
            bmi = (weight / pow (height / 100,2)) * 703
        }
        //round the number
        txtresult.text = String(format: "BMI: %.2f", bmi)
        
        if bmi < 18.5 {
            category = "Underweight"
        } else if bmi < 24.9 {
            category = "Normal weight"
        } else if bmi < 29.9 {
            category = "Overweight"
        } else {
            category = "Obese"
        }
        
        showResultAlert(bmi: bmi, category: category)
    }
    @IBAction func btnswtich(_ sender: UIButton) {
        if lblmeasure.text == "Imperial" {
            lblmeasure.text = "Metric"
            txtheight.placeholder = "cm"
            txtweight.placeholder = "kg"
        }else {
            lblmeasure.text = "Imperial"
            txtheight.placeholder = "inches"
            txtweight.placeholder = "pounds"
        }

        // Clear previous results
        txtresult.text = ""
        txtweight.text = ""
        txtheight.text = ""
}
    override func viewDidLoad() {
        super.viewDidLoad()
        lblmeasure.text = "Metric"
        txtheight.placeholder = "Height (cm)"
        txtweight.placeholder = "Weight (kg)"
    }
    
    private func showError(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    private func showResultAlert(bmi: Double, category: String) {
        let message = String(format: "Your BMI is: %.2f\nCategory: %@", bmi, category)
        let alert = UIAlertController(title: "BMI Result", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}


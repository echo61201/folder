//
//  ViewController.swift
//  Asn3_ios_N01603548
//
//  Created by Chelsea on 2024-11-04.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "quiz app"
    }

    @IBAction func btnBuild(_ sender: UIButton) {
        let buildController = storyboard?.instantiateViewController(withIdentifier: "bankbuild") as! questionsBankController
        navigationController?.pushViewController(buildController, animated: true)
        
    }
    
    
    @IBAction func btnStartQuiz(_ sender: UIButton) {
        let startQuizController = storyboard?.instantiateViewController(withIdentifier: "startquiz") as! startquizcontroller
        navigationController?.pushViewController(startQuizController, animated: true)
    }
    
    private func navigateToOrInstantiate<T: UIViewController>(identifier: String, viewControllerType: T.Type) {
        // Check if the target view controller already exists in the navigation stack
        if let targetViewController = navigationController?.viewControllers.first(where: { $0 is T }) {
            // If it exists, pop to that view controller
            navigationController?.popToViewController(targetViewController, animated: true)
        } else {
            // Otherwise, instantiate a new instance from the storyboard
            let targetViewController = storyboard?.instantiateViewController(withIdentifier: identifier) as! T
            
            // Set the navigation stack to include the root and the target view controller only
            navigationController?.setViewControllers([navigationController!.viewControllers.first!, targetViewController], animated: true)
        }
    }
    
}


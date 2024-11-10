//
//  Choice.swift
//  Asn3_ios_N01603548
//
//  Created by Chelsea on 2024-11-10.
//

import Foundation

class Choice {
    let shuffledAnswers: [String]  // Stores the shuffled answers
    var selectedAnswerIndex: Int?  // nil if no answer selected
    var status: Int  // 2 for unanswered, 1 for correct, 0 for incorrect

    init(shuffledAnswers: [String]) {
        self.shuffledAnswers = shuffledAnswers
        self.selectedAnswerIndex = nil
        self.status = 2  // Start with unanswered
    }
}

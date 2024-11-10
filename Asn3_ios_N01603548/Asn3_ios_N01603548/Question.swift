//
//  Question.swift
//  Asn3_ios_N01603548
//
//  Created by Chelsea on 2024-11-05.
//

import Foundation

class Question {
    var questionText:String
    var correctAnswer: String
    var false1:String
    var false2:String
    var false3:String
    
    init(questionText:String,correctAnswer:String,false1:String,false2:String,false3:String) {
        self.questionText = questionText
        self.correctAnswer = correctAnswer
        self.false1 = false1
        self.false2 = false2
        self.false3 = false3
    }
}

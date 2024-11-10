//
//  QuestionBank.swift
//  Asn3_ios_N01603548
//
//  Created by Chelsea on 2024-11-10.
//

import Foundation
//singleton method
class QuestionBank {
    static let shared = QuestionBank()
    private init() {}  // in case it is instantialized else where
    var questions:[Question] = []
}

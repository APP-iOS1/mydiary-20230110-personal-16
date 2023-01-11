//
//  Model.swift
//  Diary
//
//  Created by TAEHYOUNG KIM on 2023/01/10.
//

import Foundation

struct Avocado: Hashable, Identifiable {
    var id: String
    var goalCount: Int
    var studyTimePerAvocado: Int
    var breakTimePerAvocado: Int
    var whatToDo: String
    var doneCount: Int?
    var whatToDid: String?
    var whatILearned: String?
    
    var totalStudyTime: Int? {
        (studyTimePerAvocado + breakTimePerAvocado) * doneCount!
    }
}



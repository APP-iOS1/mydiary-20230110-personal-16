//
//  AvocadoStore.swift
//  Diary
//
//  Created by TAEHYOUNG KIM on 2023/01/10.
//

import Foundation
import CoreData


class StudyStore: ObservableObject {
    
    let container: NSPersistentContainer
        
    @Published var savedStudies = [Study]()
    @Published var finishedStudies = [Study]()
    @Published var selectedStudy = Study()
    
    init(){
        container = NSPersistentContainer(name: "StudiesContainer")
        container.loadPersistentStores { description, error in
            if let error = error {
                print("ERROR LOADING CORE DATA")
                print(error.localizedDescription)
            } else {
                print("SUCCESSFULLY LOAD CORE DATA")
            }
        }
        fetchCurrentStudy()
        fetchFinishedStudys()
    }
    
    func fetchCurrentStudy() {
        let request = NSFetchRequest<Study>(entityName: "Study")
        request.predicate = NSPredicate(
            format: "isFinished = %@", false as NSNumber
        )
        do {
            savedStudies = try container.viewContext.fetch(request)
        } catch {
            print("ERROR FETCHING CORE DATA")
            print(error.localizedDescription)
        }
    }
    
    func fetchFinishedStudys() {
        let request = NSFetchRequest<Study>(entityName: "Study")
        request.predicate = NSPredicate(
            format: "isFinished = %@", true as NSNumber
        )
        do {
            finishedStudies = try container.viewContext.fetch(request).sorted(by: {
                $0.createdDate ?? Date() > $1.createdDate ?? Date()
            })
        } catch {
            print("ERROR FETCHING CORE DATA")
            print(error.localizedDescription)
        }
    }
    
    func addStudy(studyTime: Int16, breakTime: Int16, goalCount: Int16, whatToDo: String) {
        let study = Study(context: container.viewContext)
        study.id = UUID().uuidString
        study.isFinished = false
        study.whatToDo = whatToDo
        study.studyTimePerSession = studyTime
        study.breakTimePerSession = breakTime
        study.goalCount = goalCount
        study.doneCount = 0
        study.createdDate = Date()
        saveData()
    }
    func deleteStudy(indexSet: IndexSet) {
        guard let index = indexSet.first else { return }
        let entity = finishedStudies[index]
        container.viewContext.delete(entity)
        saveData()
    }
    
    func deleteAllStudy() {
        for study in savedStudies {
            container.viewContext.delete(study)
        }
        saveData()
    }
    
    func saveData() {
        do {
            try container.viewContext.save()
            fetchCurrentStudy()
            fetchFinishedStudys()
        } catch {
            print("ERROR SAVING CORE DATA")
            print(error.localizedDescription)
        }
    }
    
    func finishStudy(study: Study, did: String, learned: String) {
        study.isFinished = true
        study.whatToDid = did
        study.whatILearned = learned

        saveData()
    }
    
    func doneCount(study: Study, _ countOperator: String) {
        if countOperator == "-" {
            study.doneCount -= 1
        } else {
            study.doneCount += 1
        }
        saveData()
    }
}

//
//  ProgressView.swift
//  Diary
//
//  Created by TAEHYOUNG KIM on 2023/01/14.
//

import SwiftUI

struct ProgressView: View {
    
    @StateObject var studyStore: StudyStore
    var study: Study
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Spacer()

                Text("Avocado")
                Text("\(study.doneCount) / \(study.goalCount) pcs")
                    .font(.headline)
                
                Spacer()
                
                HStack {
                    Button {
                        if study.doneCount > 0 {
                            studyStore.doneCount(study: study, "-")
                        }
                    } label: {
                        Image(systemName: "minus.circle")
                    }
                    
                    Text("🥑")
                    Button {
                        studyStore.doneCount(study: study, "+")
                    } label: {
                        Image(systemName: "plus.circle")
                    }
                    
                }
                .font(.title)
                .buttonStyle(BorderlessButtonStyle())
                .foregroundColor(Color(UIColor.label))
            
            }.frame(maxWidth: .infinity, maxHeight: .infinity)
            
            Spacer()
            
            CircleProgressBar(studyStore: studyStore, study: study, scale: 0.9)
            
        }.frame(height: UIScreen.main.bounds.height * 0.25)
        
    }
}

struct ProgressView_Previews: PreviewProvider {
    static var previews: some View {
        let studyStore = StudyStore()
        let study = Study(context: studyStore.container.viewContext)
        study.whatToDo = ""
        study.doneCount = 4
        study.goalCount = 8
        return ProgressView(studyStore: studyStore, study: study)
    }
}


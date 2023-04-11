//
//  CircleProgressBar.swift
//  Diary
//
//  Created by TAEHYOUNG KIM on 2023/01/13.
//

import SwiftUI

struct CircleProgressBar: View {
    @StateObject var studyStore: StudyStore
    var study: Study

    var circleSize: CGFloat {
        200 * scale
    }
    var lineWidth: CGFloat {
        30 * scale
    }
    var scale: Double = 1
    var progress: Double {
        return Double(study.doneCount) / Double(study.goalCount)
    }
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(Color.accentColor, lineWidth: lineWidth)
                .padding()
            
            Circle()
                .trim(from: 0, to: progress)
                .stroke(progress >= 1 ? Color.mint : Color("progressGreen"), style: StrokeStyle(lineWidth: lineWidth, lineCap: .round))
                .rotationEffect(.degrees(-90))
                .animation(.easeOut, value: progress)
                .padding()
            
            Text("\(progress * 100, specifier: "%.0f")%")
                .font(.title)
                .bold()
                .scaleEffect(scale)
        }
        .frame(width: circleSize, height: circleSize)
        
    }
}

struct CircleProgressBar_Previews: PreviewProvider {
    static var previews: some View {
        let study = Study(context: StudyStore().container.viewContext)
        study.whatToDo = ""
        study.goalCount = 5
        study.doneCount = 4
        return CircleProgressBar(studyStore: StudyStore(), study: study)
    }
}

//
//  ListRow.swift
//  Diary
//
//  Created by TAEHYOUNG KIM on 2023/01/16.
//

import SwiftUI
import CoreLocation

struct ListRow: View {
    var plan: Study
    var body: some View {
        VStack {
                HStack {
                    ScrollView(.horizontal) {

//                        AvocadoCount(count: plan.doneCount )
                }
                    Text("\(plan.doneCount ) / \(plan.goalCount)")
            }
            Text("화요일")
        }
    }
}

//struct ListRow_Previews: PreviewProvider {
//    static var previews: some View {
//        ListRow(plan: Study(id: UUID().uuidString, goalCount: 10, studyTimePerSession: 25, breakTimePerSession: 5, whatToDo: "헬로우다 이자식아", doneCount: 12, whatToDid: "그렇다 이자식아", whatILearned: "먹고 자면 피곤하다.."))
//    }
//}

struct AvocadoCount: View {
    var count: Int
    var body: some View {
        HStack {
            ForEach(0..<count, id: \.self) { _ in
                Image("avocado1")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50, height: 80)
                    .padding(-10)
            }
        }
    }
}

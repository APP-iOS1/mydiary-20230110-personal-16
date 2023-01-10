//
//  FinishView.swift
//  Diary
//
//  Created by TAEHYOUNG KIM on 2023/01/11.
//

import SwiftUI

struct FinishView: View {
    @EnvironmentObject var avocadoStore: AvocadoStore
    @Binding var isFinished: Bool
    @State var whatToDid = ""
    @State var whatILearned = "성장/ 좋았던점/ 고민할지점을 줘서 의미있던 부분"
    var placeholderString: String = "성장/ 좋았던점/ 고민할지점을 줘서 의미있던 부분"

    var body: some View {
        if avocadoStore.currentStudy != nil {
            Form {
                    Text("목표: \(avocadoStore.currentStudy!.goalCount)개")
                Text("달성: \(avocadoStore.currentStudy!.doneCount!)개: \(avocadoStore.currentStudy!.totalStudyTime!)분")
                Text("무엇을 했나요?")
                TextEditor(text: $whatToDid)
                    .onAppear {
                        whatToDid = avocadoStore.currentStudy!.whatToDo
                    }
                    .frame(height: 150)

                Text("무엇을 배웠나요?")
                Text("성장/ 좋았던점/ 고민할지점을 줘서 의미있던 부분")
                TextEditor(text: $whatILearned)
                    .foregroundColor(self.whatILearned == placeholderString ? .gray : .primary)
                    .onTapGesture {
                        if self.whatILearned == placeholderString {
                            self.whatILearned = ""
                        }
                    }
                    .frame(height: 150)
                Section {
                    Button {
                        avocadoStore.updateFinishInfo(whatILearned: whatILearned, whatToDid: whatToDid)
                        avocadoStore.createAvocadoAtList(avocado: avocadoStore.currentStudy!)
                        isFinished.toggle()
                    } label: {
                        Text("마무리")
                    }

                }
            }
        }
    }
}

struct FinishView_Previews: PreviewProvider {
    static var previews: some View {
        FinishView(isFinished: .constant(false))
            .environmentObject(AvocadoStore())

    }
}

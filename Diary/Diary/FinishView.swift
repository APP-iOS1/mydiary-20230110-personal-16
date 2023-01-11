
//  FinishView.swift
//  Diary
//
//  Created by TAEHYOUNG KIM on 2023/01/11.
//

import SwiftUI

struct FinishView: View {
    @EnvironmentObject var avocadoStore: AvocadoStore
    
    var currentStudy: Avocado?
    @Binding var isFinished: Bool
    @State var whatToDid = ""
    @State var whatILearned = "성장/ 좋았던점/ 고민할지점을 줘서 의미있던 부분"
    var placeholderString: String = "성장/ 좋았던점/ 고민할지점을 줘서 의미있던 부분"
    
    var body: some View {
        Form {
            Text("목표: \(currentStudy!.goalCount)개")
            Text("달성: \(currentStudy!.doneCount!)개: \(currentStudy!.totalStudyTime!)분")
            Text("무엇을 했나요?")
            TextEditor(text: $whatToDid)
                .onAppear {
                    whatToDid = currentStudy!.whatToDo
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
                PhotosPickerView()
            }
            Section {
                Button {
                    avocadoStore.createAvocadoAtList(avocado: currentStudy!, whatILearned: whatILearned, whatToDid: whatToDid)
                    isFinished.toggle()
                } label: {
                    Text("마무리")
                }
            }
        }
    }
}

struct FinishView_Previews: PreviewProvider {
    static var previews: some View {
        FinishView(currentStudy: currentStudy, isFinished: .constant(false))
            .environmentObject(AvocadoStore())
        
    }
}

var currentStudy: Avocado = Avocado(id: "1", goalCount: 4, studyTimePerAvocado: 25, breakTimePerAvocado: 5, whatToDo: "아보카드 샌드위치 만들기", doneCount: 6, whatToDid: "샌드위치, 후라이, 성공적", whatILearned: "소금, 후추로도 괜찮네")

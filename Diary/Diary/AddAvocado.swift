//
//  WriteDiaryView.swift
//  Diary
//
//  Created by TAEHYOUNG KIM on 2023/01/10.
//

import SwiftUI

struct AddAvocado: View {
    @EnvironmentObject var avocadoStore: AvocadoStore
    @State var studyTimePerAvocado = 25
    @State var breakTimePerAvocado = 5
    @State var goalCount = 2
    @State var whatToDo: String = ""
    @Binding var addViewShowing: Bool
    @Binding var doneCount: Int
    
    var concentrationTime: [Int] = [5,10,15,20,25,30,35,40,45,50,55,60]
    var restTime: [Int] = [5,10,15,20]
    
    var body: some View {
        
        Form {
            Section {
                HStack {
                    Spacer()
                    Picker(selection: $studyTimePerAvocado) {
                        ForEach(concentrationTime, id: \.self) { min in
                            Text("\(min)분")
                        }
                    } label: {
                        Text("아보카도 하나 당 공부 시간")
                    }
                }
                HStack {
                    Spacer()
                    Picker(selection: $breakTimePerAvocado) {
                        ForEach(restTime, id: \.self) { min in
                            Text("\(min)분")
                        }
                    } label: {
                        Text("아보카도 하나 끝난 후 쉬는 시간")
                    }
                    
                }
                HStack {
                    Spacer()
                    Picker(selection: $goalCount) {
                        ForEach(0..<50) { count in
                            Text("\(count)개")
                        }
                    } label: {
                        Text("목표 아보카도 개수")
                    }
                }
                Text("예시: \(studyTimePerAvocado)분 공부하고 \(breakTimePerAvocado)분 쉬는 것을 \(goalCount)번 한다.")
                    .foregroundColor(.secondary)
            }
            
            Section {
                Text("무엇을 할 예정인가요?")
                TextEditor(text: $whatToDo)
                    .frame(height: 100)
            }
            
            Button {
                let avocado = Avocado(id: UUID().uuidString, goalCount: goalCount, studyTimePerAvocado: studyTimePerAvocado, breakTimePerAvocado: breakTimePerAvocado, whatToDo: whatToDo)
                avocadoStore.createAvocadoPlan(avocado: avocado)
                
                avocadoStore.fetchAvocado()
                
                print("\(avocadoStore.currentStudy?.doneCount ?? 1)")
                if avocadoStore.currentStudy?.doneCount != nil {
                    doneCount = (avocadoStore.currentStudy?.doneCount ?? 0)!
                }
                addViewShowing.toggle()
                
            } label: {
                Text("계획 추가")
            }
        }
    }
}

struct AddAvocado_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            AddAvocado(addViewShowing: .constant(false), doneCount: .constant(0))
                .environmentObject(AvocadoStore())
        }
    }
}

//
//  ListTest.swift
//  Diary
//
//  Created by TAEHYOUNG KIM on 2023/01/16.
//

import SwiftUI
import CoreLocation
struct ListTest: View {
    @EnvironmentObject var avocadoStore: AvocadoStore

    var body: some View {
        List {
            ForEach(avocadoArray) { avocado in
                
                HStack{
                    
                    
                    Text("hello")
                    
                }
            }
        }
        
    }
    
}

struct ListTest_Previews: PreviewProvider {
    static var previews: some View {
        ListTest()
            .environmentObject(AvocadoStore())
    }
}

let avocadoArray: [Avocado] = [
    
    Avocado(id: UUID().uuidString, goalCount: 0, studyTimePerAvocado: 0, breakTimePerAvocado: 0, whatToDo: "asdas", doneCount: 0, whatToDid: "asdas", whatILearned: "asdasd", currentLocation: CLLocationCoordinate2D(latitude: 0, longitude: 0)),
    Avocado(id: UUID().uuidString, goalCount: 0, studyTimePerAvocado: 0, breakTimePerAvocado: 0, whatToDo: "asdas", doneCount: 0, whatToDid: "asdas", whatILearned: "asdasd", currentLocation: CLLocationCoordinate2D(latitude: 0, longitude: 0))

]

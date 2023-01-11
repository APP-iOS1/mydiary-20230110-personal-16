//
//  TestView.swift
//  Diary
//
//  Created by TAEHYOUNG KIM on 2023/01/12.
//

import SwiftUI

struct TestView: View {
    @EnvironmentObject var avocadoStore: AvocadoStore
    var avocado = Avocado(id: "974179E6-8409-4337-8305-A13FF9A9F282", goalCount: 5, studyTimePerAvocado: 5, breakTimePerAvocado: 5, whatToDo: "")
    
    var body: some View {
        VStack {
            
            
            Button {


            } label: {
                Text("패치 스토리지")
            }

        }
       
    }
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
            .environmentObject(AvocadoStore())

    }
}

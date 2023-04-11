//
//  TestView.swift
//  Diary
//
//  Created by TAEHYOUNG KIM on 2023/01/18.
//

import SwiftUI

struct TestView: View {
    @EnvironmentObject var avocadoStore: AvocadoStore
@State var pageNumber = 1
    var body: some View {
        VStack {
            ForEach(avocadoStore.test, id: \.self) { i in
                
                Text(i)
                
            }
            Button {
                avocadoStore.paginaton(page: pageNumber)
                pageNumber += 3
            } label: {
                Text("페이지넘기기: \(pageNumber)")
            }
            
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
        }
    }
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
            .environmentObject(AvocadoStore())

    }
}

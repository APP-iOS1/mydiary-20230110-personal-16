//
//  ContentView.swift
//  Diary
//
//  Created by TAEHYOUNG KIM on 2023/01/10.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var avocadoStore: AvocadoStore
    @State var isNotLogined: Bool = true
    var body: some View {
            TabView{
                OngoingView()
                    .tabItem {
                        Text("avocado")
                    }.tag(1)
                
              AvocadoList()
                    .tabItem {
                        Text("리스트")
                    }.tag(2)
                
            }
            .fullScreenCover(isPresented: $isNotLogined) {
                LoginView(isNotLogined: $isNotLogined)
            }
        
    }
}




    

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(AvocadoStore())
    }
}

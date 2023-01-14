//
//  ProgressView.swift
//  Diary
//
//  Created by TAEHYOUNG KIM on 2023/01/14.
//

import SwiftUI

struct ProgressView: View {
    @StateObject var avocadoStore: AvocadoStore
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("Avocado")
                Text("\(avocadoStore.currentStudy?.doneCount ?? 0) / \(avocadoStore.currentStudy?.goalCount ?? 0) EA")
                    .font(.headline)
                    .bold()
                Spacer()
                HStack {
                    Button {
                        avocadoStore.currentStudy?.doneCount! -= 1
                    } label: {
                        Image(systemName: "minus.circle")
                    }
                    
                    Text("🥑")
                        .font(.title)
                    Button {
                        avocadoStore.currentStudy?.doneCount! += 1
                    } label: {
                        Image(systemName: "plus.circle")
                        
                    }
                    .onChange(of: avocadoStore.currentStudy?.doneCount ?? 0) { count in
                        avocadoStore.updateDoneCount(doneCount: count)
                    }
                    
                }
                .font(.title3)
                .buttonStyle(BorderlessButtonStyle())
                .foregroundColor(Color(hue: 0.259, saturation: 0.869, brightness: 0.373))
                
            }
            Spacer()
            CircleProgressBar(avocadoStore: avocadoStore)
        }
        .padding(EdgeInsets(top: 15, leading: 0, bottom: 15, trailing: 10))
    }
}

struct ProgressView_Previews: PreviewProvider {
    static var previews: some View {
        ProgressView(avocadoStore: AvocadoStore())
    }
}


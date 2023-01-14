//
//  CircleProgressBar.swift
//  Diary
//
//  Created by TAEHYOUNG KIM on 2023/01/13.
//

import SwiftUI

struct CircleProgressBar: View {
    @StateObject var avocadoStore: AvocadoStore
    let circleSize: CGFloat = 150
    
    var progress: Double {
        return Double(avocadoStore.currentStudy?.doneCount ?? 0) / Double(avocadoStore.currentStudy?.goalCount ?? 0)
    }
    
    var body: some View {
        VStack{
            ZStack {
                //                Circle()
                //                    .fill(Color(red: 0.565, green: 0.358, blue: 0.163))
                //                    .frame(width: circleSize - 150, height: circleSize - 150)
                //
                //                Circle()
                //                    .stroke(Color(red: 0.999, green: 0.893, blue: 0.563), lineWidth: 30)
                //                    .frame(width: circleSize - 120, height: circleSize - 120)
                //
                //                Circle()
                //                    .stroke(Color(red: 0.569, green: 0.762, blue: 0.122), lineWidth: 30)
                //                    .frame(width: circleSize - 60, height: circleSize - 60)
                //
                Circle()
                    .stroke(Color(hue: 0.225, saturation: 0.905, brightness: 0.552).opacity(0.5), lineWidth: 30)
                    .frame(width: circleSize, height: circleSize)
                
                Circle()
                    .trim(from: 0, to: progress)
                    .stroke(Color(hue: 0.225, saturation: 0.905, brightness: 0.552), style: StrokeStyle(lineWidth: 30, lineCap: .round))
                    .frame(width: circleSize, height: circleSize)
                    .rotationEffect(.degrees(-90))
                    .animation(.easeOut, value: progress)
                Text("\(progress * 100, specifier: "%.0f")%")
                    .font(.largeTitle)
                    .bold()
            }
        }
    }
}

struct CircleProgressBar_Previews: PreviewProvider {
    static var previews: some View {
        CircleProgressBar(avocadoStore: AvocadoStore())
    }
}

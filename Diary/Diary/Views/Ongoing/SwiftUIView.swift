//
//  SwiftUIView.swift
//  Diary
//
//  Created by TAEHYOUNG KIM on 2023/04/14.
//

import SwiftUI

struct CardView: View {
    @State private var isExpanded = false
    @GestureState private var dragOffset = CGSize.zero
    @State private var startPosition: CGSize = .zero
    @State private var endPosition: CGSize = .zero
    
    var body: some View {
        let dragGesture = DragGesture()
            .updating($dragOffset) { value, state, _ in
                state = value.translation
            }
            .onEnded { value in
                if abs(value.translation.width) > 50 {
                    self.isExpanded = false
                }
                self.startPosition = .zero
                self.endPosition = .zero
            }
        
        return ZStack {
            GeometryReader { geo in
                VStack {
                    Spacer()
                    
                    ZStack {
                        Image("avocado_1")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(height: isExpanded ? geo.size.height : geo.size.height * 0.7)
                            .cornerRadius(isExpanded ? 0 : 16)
                            .padding(.horizontal)
                            .offset(y: isExpanded ? -dragOffset.height/2 : 0)
                            .rotation3DEffect(
                                Angle(degrees: Double(isExpanded ? 0 : 90)),
                                axis: (x: CGFloat(0), y: CGFloat(10), z: CGFloat(0))
                            )
                            .animation(.spring(response: 0.4, dampingFraction: 0.7, blendDuration: 0.2))
                        
                        if isExpanded {
                            Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi eget purus risus. Fusce hendrerit arcu at lectus consequat, ut consequat est malesuada. Suspendisse potenti. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Sed eget mi a quam hendrerit tincidunt ac in velit.")
                                .padding()
                        }
                    }
                    
                    Spacer()
                }
                .frame(width: geo.size.width, height: geo.size.height)
                .background(Color.white)
                .cornerRadius(16)
                .shadow(radius: 16)
                .offset(y: dragOffset.height/2)
                .offset(y: startPosition.height + endPosition.height)
                .gesture(dragGesture)
                .onTapGesture {
                    withAnimation {
                        self.isExpanded.toggle()
                        self.startPosition = dragOffset
                        self.endPosition = .zero
                    }
                }
            }
        }
    }
}

struct TestView: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                ForEach(1...10, id: \.self) { _ in
                    CardView()
                }
            }
            .padding()
        }
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView()
    }
}

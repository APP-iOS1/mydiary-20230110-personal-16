//
//  SignUpView.swift
//  Diary
//
//  Created by TAEHYOUNG KIM on 2023/01/10.
//

import SwiftUI

struct SignUpView_One: View {
    @Binding var navStack: NavigationPath
    @State private var isTermSheetShowing: Bool = false
    @State private var isCheckedTerm: Bool = false
    @State private var isCheckedPrivacy: Bool = false

    var body: some View {
        VStack(alignment: .leading) {
            
            Text("Diary 서비스 이용약관에 동의해주세요.")
            
            Button {
                print("모두 동의")
                isCheckedTerm.toggle()
                isCheckedPrivacy.toggle()
            } label: {
                Label("모두 동의", systemImage: isCheckedPrivacy && isCheckedTerm ? "checkmark.square.fill" : "square")
                    .foregroundColor(.black)
            }
            
            Divider()
            
            HStack {
                Button {
                    print("이용약관 동의 클릭")
                    isCheckedTerm.toggle()
                } label: {
                    Label("[필수] 이용약관 동의", systemImage: "checkmark")
                        .foregroundColor(isCheckedTerm ? .black : .secondary)
                }
                Button {
                    print("이용약관 보기 클릭")
                    isTermSheetShowing.toggle()
                } label: {
                    Text("보기")
                        .underline()
                }
                .sheet(isPresented: $isTermSheetShowing) {
                    PrivacyView(isTermSheetShowing: $isTermSheetShowing)
                }

            }
            
            HStack {
                Button {
                    print("개인정보 수집 및 이용 동의 클릭")
                    isCheckedPrivacy.toggle()
                } label: {
                    Label("[필수] 개인정보 수집 및 이용 동의", systemImage: "checkmark")
                        .foregroundColor(isCheckedPrivacy ? .black : .secondary)
                }
                Button {
                    print("개인정보 수집 및 이용 동의 클릭")
                } label: {
                    Text("보기")
                        .underline()
                }

            }
            
            NavigationLink {
                //버튼 안눌리면 안넘어가기
                //가입하기버튼
                SignUpView_Two(navStack: $navStack)
                
            } label: {
                Text("동의하고 가입하기")
                    .foregroundColor(.white)
                    .padding()
                    .frame(width: 360)
                    .background(.tint)
            }
            .disabled(isCheckedTerm && isCheckedPrivacy ? false : true)
            
            Spacer()
        }
        .navigationTitle("이용약관 동의")
        .padding()

    }
}

struct SignUpView_One_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            NavigationStack {
                SignUpView_One(navStack: .constant(NavigationPath()))
                    .environmentObject(AuthStore())

                
            }
            NavigationStack {
                PrivacyView(isTermSheetShowing: .constant(false))
            }
        }
    }
}

struct PrivacyView: View {
    @Binding var isTermSheetShowing: Bool
    var body: some View {
        NavigationStack {
            VStack {
                ScrollView {
                    VStack {

                        Rectangle()
                            .frame(width: 370, height: 10)
//                            .padding(.horizontal,10)
                        Text(term)
                            .padding(20)
                    }
                }
                .toolbar {
                    Button {
                        print("닫기")
                        isTermSheetShowing.toggle()
                    } label: {
                        Text("닫기")
                    }
                    
                }
                
                Button {
                    print("동의하기")
                    isTermSheetShowing.toggle()
                } label: {
                    Text("동의하기")
                }
                
            }
            .navigationTitle("이용약관")
        }
        
    }
}

////
////  SignUpView_Three.swift
////  Diary
////
////  Created by TAEHYOUNG KIM on 2023/01/10.
////
//
//import SwiftUI
//
//struct SignUpView_Three: View {
//    @StateObject var avocadoStore: AvocadoStore
//
//    @State var textFieldSignUpPW: String = ""
//    @State var textFieldSignUpCheckPW: String = ""
//    @Binding var textFieldSignUpID: String
//    @Binding var textFieldSignUpNickname: String
//
//    @Binding var navStack: NavigationPath
//
//    var body: some View {
//        VStack {
//            Text("비밀번호 입력")
//            TextField(text: $textFieldSignUpPW) {
//                Text("비밀번호 입력")
//            }
//            .padding()
//            .border(.secondary)
//            .textInputAutocapitalization(.never) // 첫 문자 대문자화 막기
//            .disableAutocorrection(true)
//            .padding()
//            
//            HStack {
//                PasswordRuleComponent(string: "대소문자")
//                PasswordRuleComponent(string: "숫자")
//                PasswordRuleComponent(string: "특수문자")
//                PasswordRuleComponent(string: "8-20자 이내")
//            }
//            
//            TextField(text: $textFieldSignUpCheckPW) {
//                Text("비밀번호 확인")
//            }
//            .padding()
//            .border(.secondary)
//            .textInputAutocapitalization(.never) // 첫 문자 대문자화 막기
//            .disableAutocorrection(true)
//            .padding()
//            
//            PasswordRuleComponent(string: "비밀번호 일치")
//            
//            Button {
//                print("가입 완료")
//                Task {
//                    await avocadoStore.signUp(email: textFieldSignUpID, password: textFieldSignUpPW, nickname: textFieldSignUpNickname)
//                }
//                navStack = .init()
//            } label: {
//                Text("가입 완료")
//                    .frame(width: 335, height: 20)
//                    .foregroundColor(.white)
//                    .font(.headline)
//                    .padding()
//                    .background(Color.black)
//                    .padding()
//            }
//            Spacer()
//        }
//    }
//}
//
//struct PasswordRuleComponent: View {
//    var string: String
//    var body: some View {
//        HStack {
//            Text(string)
//            Image(systemName: "checkmark")
//        }
//    }
//}
//
//struct SignUpView_Three_Previews: PreviewProvider {
//    static var previews: some View {
//        SignUpView_Three(textFieldSignUpID: .constant(""), textFieldSignUpNickname: .constant(""), navStack: .constant(NavigationPath()))
//
//    }
//}

//
//  SignUpView_Two.swift
//  Diary
//
//  Created by TAEHYOUNG KIM on 2023/01/10.
//

import SwiftUI

struct SignUpView_Two: View {
    @EnvironmentObject var avocadoStore: AvocadoStore

    @State var textFieldSignUpID: String = ""
    @State var textFieldSignUpNickname: String = ""
    @State var isEmailDuplicated: Bool = false
    @State var isNicknameDuplicated: Bool = false
    @Binding var navStack: NavigationPath
    
    var isEmpty: Bool {
        get {
            return textFieldSignUpNickname.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ? true : false
        }
    }
    
    // MARK: Methods
    // 이메일이 aaa@aaa.aa 형식인지 검사하는 함수입니다.
    func checkEmailRule(string: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}"
        return  NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: string)
    }
//    // 비밀번호 정규표현식을 검사하는 함수입니다.
//    func checkPasswordRule(password : String) -> Bool {
//        let regExp = "^(?=.*[a-zA-Z])(?=.*[0-9])(?=.*[!@#$%^&*()_+=-]).{8,20}$"
//        return password.range(of: regExp, options: .regularExpression) != nil
//    }
//    // 이메일 중복을 검사하는 함수입니다.
//    func checkEmailDuplicated() {
//        Task {
//            if await avocadoStore.isEmailDuplicated(currentUserEmail: textFieldSignUpID) {
//                // 이메일이 중복될 경우
//
//            } else {
//
//            }
//        }
//    }
    var body: some View {
        VStack {
            Text("로그인에 사용할 아이디를 입력해주세요.")
            
            TextField(text: $textFieldSignUpID) {
                Text("아이디 (이메일) 입력")
            }
            .onChange(of: textFieldSignUpID, perform: { email in
                Task {
                    if await avocadoStore.isEmailDuplicated(currentUserEmail: email) {
                        isEmailDuplicated = false
                    } else {
                        isEmailDuplicated = true
                    }
                }
            })
            .padding()
            .border(.secondary)
            .textInputAutocapitalization(.never) // 첫 문자 대문자화 막기
            .disableAutocorrection(true)
            .padding()
           
            TextField(text: $textFieldSignUpNickname) {
                Text("닉네임 입력")
            }
            .onChange(of: textFieldSignUpNickname, perform: { nickname in
                Task {
                    if await avocadoStore.isNicknameDuplicated(currentUserNickname: nickname) {
                        isNicknameDuplicated = false
                    } else {
                        isNicknameDuplicated = true
                    }
                }
            })
            .padding()
            .border(.secondary)
            .textInputAutocapitalization(.never) // 첫 문자 대문자화 막기
            .disableAutocorrection(true)
            .padding()
            
            NavigationLink {
                SignUpView_Three(textFieldSignUpID: $textFieldSignUpID, textFieldSignUpNickname: $textFieldSignUpNickname, navStack: $navStack)
            } label: {
                Text("다음")
                    .frame(width: 335, height: 20)
//                    .foregroundColor(.white)
                    .font(.headline)
                    .padding()
//                    .background(Color.black)
                    .padding()
            }
            .disabled(
                
                // 이메일 중복, 이메일 형식, 닉네임 중복, 빈칸 아닐 경우
                isEmailDuplicated == false && checkEmailRule(string: textFieldSignUpID) == true && isNicknameDuplicated == false && isEmpty == false ? false : true
            )
            
            Spacer()
        }
    }
}

struct SignUpView_Two_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            SignUpView_Two(navStack: .constant(NavigationPath()))
                .environmentObject(AvocadoStore())

        }
    }
}

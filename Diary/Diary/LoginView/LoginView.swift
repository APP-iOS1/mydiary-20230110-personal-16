
import SwiftUI
//import FirebaseAuth


struct LoginView: View {
    @EnvironmentObject var avocadoStore: AvocadoStore
    @State var textFieldLoginID: String = ""
    @State var textFieldLoginPW: String = ""
    @Binding var isNotLogined: Bool
    var socialLoginArray: [String] = [
        "naver", "kakao", "google", "apple"
    ]
    @State var navStack = NavigationPath()
    
    func login() {
        Task {
            await avocadoStore.login(withEmail: textFieldLoginID, withPassword: textFieldLoginPW)
            if avocadoStore.loginRequestState == .loggedIn {
                isNotLogined.toggle()
            }
        }
    }
    
    var body: some View {
        NavigationStack(path: $navStack) {
            VStack(spacing: 30) {
                
                //MARK: 로그인 필드, 로그인하기 버튼
                Section {
                    VStack {
                        TextField(text: $textFieldLoginID) {
                            Text("아이디 (이메일)")
                        }
                        .padding()
                        .border(.secondary)
                        .textInputAutocapitalization(.never) // 첫 문자 대문자화 막기
                        .disableAutocorrection(true)

                        
                        SecureField(text: $textFieldLoginPW) {
                            Text("비밀번호")
                        }
                        .padding()
                        .border(.secondary)
                        
                        Button {
                            print("로그인버튼")
                            login()
                        } label: {
                            Text("로그인하기")
                                .frame(width: 335, height: 25)
                                .foregroundColor(.white)
                                .font(.headline)
                                .padding()
                                .background(Color.black)
                                .padding()
                        }
                    }
                    .padding()
                }
                
                //MARK: SNS 로그인 기능
                Section {
                    VStack {
                        Text("SNS 계정으로 로그인하기")
                        HStack {
                            ForEach(socialLoginArray, id: \.self) { sns in
                                Button {
                                    //SNS 로그인 연동
                                } label: {
                                    Text(sns)
                                }
                            }
                        }
                    }
                }
                
                //MARK: 간편 회원가입하기
                
                NavigationLink(value: "") {
                    Text("간편 회원가입하기")
                        .font(.footnote)
                        .foregroundColor(.accentColor)
                }
                .navigationDestination(for: String.self) { value in
                    SignUpView_One(navStack: $navStack)
                }
                
                
                Spacer()

            }
            .navigationTitle("LOGIN")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(isNotLogined: .constant(false))
            .environmentObject(AvocadoStore())
    }
}

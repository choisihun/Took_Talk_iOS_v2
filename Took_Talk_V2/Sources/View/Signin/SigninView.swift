//
//  SigninView.swift
//  Took_Talk
//
//  Created by 최시훈 on 2023/09/14.
//

import SwiftUI

struct SigninView: View {
    @StateObject private var viewModel = SigninViewModel()
    
    let signupSuccessPublish = NotificationCenter.default.publisher(for: .signupSuccess)

    var body: some View {
        NavigationStack {
            VStack {
                Image("TookTalkMainLogo")
                    .padding(.top, 46)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                Text("또래와의 소통이 더욱 쉬워지는\nTook Talk으로 지금 시작해보세요!")
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.center)
                    .font(.pretendard(12))
                    .frame(width: 250, height: 30, alignment: .top)
                    .padding(.top, 50)
                
                VStack {
                    CustomSignTextField(text: "아이디", 
                                        placeholder: "아이디를 입력해주세요",
                                        textfieldValue: $viewModel.number)
                    
                    CustomSignSecureField(text: "비밀번호", 
                                          placeholder: "비밀번호를 입력해주세요",
                                          textfieldValue: $viewModel.password)
                    
                    HStack {
                        Spacer()
                        
                        Group {
                            NavigationLink(value: viewModel.isFindPasswordViewActive) {
                                EmptyView()
                            }
                            .navigationDestination(for: Bool.self) { isActive in
                                if isActive {
                                    EmptyView()
                                }
                            }
                            .hidden()
                            
                            Button {
                                
                            } label: {
                                Text("비밀번호 찾기")
                                    .font(.pretendard(13, weight: .thin))
                                    .foregroundColor(Color.black)
                                    .fontWeight(.semibold)
                            }
                        }
                        .frame(width: 80)
                        
                        Rectangle()
                            .foregroundColor(.black)
                            .frame(width: 1, height: 20)
                            .padding(.trailing, 3)
                        
                        Button {
                            viewModel.signup()
                        } label: {
                            Text("회원가입")
                                .font(.pretendard(13, weight: .thin))
                                .foregroundColor(Color.black)
                        }
                        .navigationDestination(isPresented: $viewModel.isSignupViewActive) {
                            SignupView()
                        }
                    }
                    .frame(width: 290, alignment: .trailing)
                    
                    .padding(.bottom, 12)
                    .padding(.top, 10)
                    
                    Spacer()
                        .padding(.bottom, 70)
                    
                    Button {
                        viewModel.login()
                    } label: {
                        Text("로그인")
                            .font(.pretendard(20, weight: .regular))
                            .frame(width: 320, height: 50)
                    }
                    .background(Color("myOrange"))
                    .foregroundColor(Color.white)
                    .cornerRadius(15)
                    .padding(.bottom, 87)
                    .navigationDestination(isPresented: $viewModel.isMainTabViewActive) {
                        MainTabView()
                    }
                }
                .padding(.horizontal, 45)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                
                Spacer()
            }
        }
        .onReceive(signupSuccessPublish) { _ in
            viewModel.isSignupViewActive = false
        }
    }
}

#Preview {
    SigninView()
}

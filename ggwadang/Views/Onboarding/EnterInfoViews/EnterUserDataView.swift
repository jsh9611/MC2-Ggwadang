//
//  EnterUserDataView.swift
//  ggwadang
//
//  Created by SeongHoon Jang on 2022/06/13.
//

import SwiftUI

struct EnterUserDataView: View {
    @AppStorage(StorageKeys.nickName.rawValue) private var nickName: String = UserDefaults.standard.string(forKey: "nickName") ?? ""    // 닉네임
    @AppStorage(StorageKeys.gender.rawValue) private var gender: Int = UserDefaults.standard.integer(forKey: "gender") // 유저의 성별(남:0, 여:1)
    
    @Binding var isFirstDataInput: Bool
    
    let genderType = ["남성","여성"]    // 성별 테이블
    
    var body: some View {
        NavigationView {
            VStack (alignment: .leading){
                Spacer()
                // 닉네임 입력
                Text("닉네임을 입력해주세요.")
                    .bold()
                    .padding(.top, 20)
                    .padding(.bottom, 5)
                ZStack {
                    TextFieldBox()
                        .frame(width: 350)
                    TextField("홍길동", text: $nickName).keyboardType(.default)
                        .padding(.leading)
                        .submitLabel(.done)
                }
                .frame(height: 44)
                .padding(.bottom, 40)
                
                // 성별 선택(애니메이션 기능 구현 예정)
                Text("성별을 선택해주세요.")
                    .bold()
                    .padding(.bottom, 5)
                HStack {
                    Spacer()
                    GenderSegmentedBar(selected: $gender)
                        .frame(width: 220, height: 44)
                    Spacer()
                }
                .shadow(color: .black.opacity(0.1), radius: 10, x: 10, y: 10)
                .shadow(color: .white.opacity(0.7), radius: 10, x: -5, y: -5)
                
                HStack {
                    Spacer()
                    NavigationLink(destination: EnterAgePickerView(isFirstDataInput: $isFirstDataInput)) {
                        NextButton(buttonText: "다음")
                            .frame(width: 350, height: 50)
                    }
                    .buttonStyle(PlainButtonStyle())
                    Spacer()
                }
            }
            .frame(width: 350)
            .navigationBarHidden(true)
            .padding(.bottom, 20)
        }
    }
}

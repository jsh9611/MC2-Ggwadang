//
//  SettingUserInfoView.swift
//  ggwadang
//
//  Created by SeongHoon Jang on 2022/06/19.
//

import SwiftUI

struct SettingUserInfoView: View {
    @Environment(\.presentationMode) var presentationMode
    @AppStorage(StorageKeys.nickName.rawValue) private var nickName: String = UserDefaults.standard.string(forKey: "nickName") ?? ""    // 닉네임
    @AppStorage(StorageKeys.gender.rawValue) private var gender: Int = UserDefaults.standard.integer(forKey: "gender") // 유저의 성별(남:0, 여:1)
    @AppStorage(StorageKeys.age.rawValue) private var age: Int =  20 // 유저의 만나이
    @State private var tempAge = 0
    @State private var tempGender = 0
    @State private var tempNickname = ""
    @Binding var naviLinkActive : Bool
    let genderType = ["남성","여성"]
    
    // TextField에 숫자를 표시하려면 NumberFormatter 를 사용해야 합니다
    let formatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter
    }()
    // https://seons-dev.tistory.com/entry/TextField
    
    var body: some View {
        VStack{
            Form{
                // 닉네임 입력
                Section(header: Text("닉네임"), content: {
                    TextField("닉네임을 입력하세요.", text: $tempNickname).keyboardType(.default)
                })
                // 생일을 입력
                Section(header: Text("만 나이")){
                    // TextField에 age를 타이핑. 숫자라서 NumberFormatter 적용해야함
                    TextField("20살", value: $tempAge, formatter: formatter)
                    //                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .keyboardType(.numberPad)
                }
                // 성별 선택 피커
                Section(header: Text("성별")){
                    Picker("성별",selection: $tempGender){
                        ForEach( 0  ..< genderType.count, id: \.self){
                            Text("\(self.genderType[$0])")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
            }
            Button {
                age = tempAge
                gender = tempGender
                nickName = tempNickname
                naviLinkActive.toggle()
            } label: {
                Text("수정완료")
                    .frame(width: (UIScreen.main.bounds.width)*0.9, height: 50)
                    .foregroundColor(Color.white)
            }
            .background(RoundedRectangle(cornerRadius: 30).fill(Color(hex: 0x6CADA5)))
            .padding(.vertical, 20)
        }
    }
}

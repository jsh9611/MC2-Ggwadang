//
//  SettingUserSugarView.swift
//  ggwadang
//
//  Created by SeongHoon Jang on 2022/06/19.
//

import SwiftUI

struct SettingUserSugarView: View {
    @AppStorage(StorageKeys.sugar.rawValue) private var sugar : Double = UserDefaults.standard.double(forKey: "sugar")
    @AppStorage(StorageKeys.nickName.rawValue) private var nickName: String = UserDefaults.standard.string(forKey: "nickName") ?? ""    // 닉네임
    
    @State var nowSugar : Double = 0
    @Binding var naviLinkActive : Bool
    var body: some View {
        
        VStack (alignment: .leading) {
            Text("하루 목표 당 섭취량을\n선택해 주세요.")
                .font(.body)
                .bold()
                .padding(.bottom, 30)
            Text("\(String(format: "%.0f", nowSugar))g")
                .font(.largeTitle)
                .bold()
            
            Slider(value: $nowSugar, in: 0...100, step: 1.0)
                .accentColor(Color(hex: 0x6CADA5))
            
            Text("* \(nickName)님의 일일 당 섭취 권장량은 \(Int(sugarGram()))g 입니다.")
                .font(.footnote)
                .foregroundColor(.gray)
            
            Spacer()
            
            Button {
                sugar = nowSugar
                naviLinkActive.toggle()
            } label: {
                NextButton(buttonText: "수정하기")
                    .buttonStyle(PlainButtonStyle())
                    .frame(height: 50)
            }
            .padding()
        }
        .onAppear {
            nowSugar = sugar
        }
        .padding()
    }
}

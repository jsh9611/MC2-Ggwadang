//
//  SettingUserSugarView.swift
//  ggwadang
//
//  Created by SeongHoon Jang on 2022/06/19.
//

import SwiftUI

struct SettingUserSugarView: View {
    @AppStorage(StorageKeys.sugar.rawValue) private var sugar : Double = UserDefaults.standard.double(forKey: "sugar")
    
    var body: some View {
        VStack (alignment: .leading){
            Text("하루 목표 당 섭취량을\n선택해 주세요.")
                .font(.title)
                .bold()
            Text("\(String(format: "%.1f", sugar))g")
                .font(.title3)
                .padding()
            Slider(value: $sugar, in: 0...100, step: 1.0)
                .accentColor(Color(hex: 0x6CADA5))
                .padding()
        }
        
    }
}

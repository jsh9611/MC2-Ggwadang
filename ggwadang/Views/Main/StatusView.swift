//
//  StatusView.swift
//  ggwadang
//
//  Created by kimjimin on 2022/06/18.
//

import SwiftUI
import RealmSwift

struct StatusView: View {
    @Binding var todaySugarValue: Double
    @Binding var isPresented: Bool
    @AppStorage(StorageKeys.sugar.rawValue) private var sugar : Double = UserDefaults.standard.double(forKey: "sugar")
    
    let realm = try! Realm()
    
    var body: some View {
        // 오늘 날짜에 대해서만 불러온다.
        ZStack {
            RoundedRectangle(cornerRadius: 15)
                .fill(.white)
                .opacity(0.2)
                .frame(width: 350, height: 80)
            HStack {
                VStack {
                    Text("섭취량")
                        .font(.system(size:15, weight: .medium))
                    Spacer()
                        .frame(height: 5)
                    
                    // Double에 맞게 변경(소수점 1자리만 표현! - 소수점 2째자리에서 반올림함)
                    Text("\(String(format: "%.1f", todaySugarValue))g")
                        .fontWeight(.bold)
                }
                
                Spacer()
                    .frame(width: 35)
                
                Divider()
                    .background(Color.white)
                    .frame(height: 40)
                    .overlay(.white)
                
                Spacer()
                    .frame(width: 35)
                
                VStack {
                    Text("목표량")
                        .font(.system(size:15, weight: .medium))
                    
                    Spacer()
                        .frame(height: 5)
                    
                    Text("\((String(format: "%.1f", sugar)))g")
                        .fontWeight(.bold)
                    
                }
                
                Spacer()
                    .frame(width: 35)
                
                Divider()
                    .background(Color.white)
                    .frame(height: 40)
                    .overlay(.white)
                
                Spacer()
                    .frame(width: 35)
                
                VStack {
                    Text("남은 양")
                        .font(.system(size:15, weight: .medium))
                    
                    Spacer()
                        .frame(height: 5)
                    
                    Text("\(String(format: "%.1f", (sugar - todaySugarValue)))g")
                        .fontWeight(.bold)
                    
                }
                
            }.foregroundColor(.white)
            
        }
        
    }
}




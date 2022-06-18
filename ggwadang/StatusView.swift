//
//  StatusView.swift
//  ggwadang
//
//  Created by kimjimin on 2022/06/18.
//

import SwiftUI

struct StatusView: View {
    
    // TODO: RecordDB로부터 오늘 먹은 레코드 불러오기 -> 섭취량 계산
    @State private var intakeSugar: Int = 15
    // TODO: AppStorage에 저장된 사용자 목표 섭취량 가져오기
    @State private var targetSugar: Int = 100
    
    var body: some View {
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
                    Text("\(intakeSugar)g")
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
                    Text("\(targetSugar)g")
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
                    Text("\(targetSugar - intakeSugar)g")
                        .fontWeight(.bold)
                }
            }
            .foregroundColor(.white)
        }
    }
}

struct StatusView_Previews: PreviewProvider {
    static var previews: some View {
        StatusView()
    }
}

//
//  MainFullListView.swift
//  ggwadang
//
//  Created by Hyemin Choi on 2022/06/17.
//

import SwiftUI


struct MainFullListView: View {
    // TODO: RecordDB에서 오늘 먹은 음식불러오기
    // 아래는 더미데이터
    @State private var name: String = "오렌지주스"
    @State private var intakeVolume: String = "300ml"
    @State private var sugarVolume: String = "당류 10g"
    
    // FIXME: 스크롤 가능 리스트로 아예 변경
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Text("\(today, formatter: MainView.dateFormat)")
                Spacer()
            }
            Spacer()
                .frame(height: 30)
            HStack {
                VStack (alignment: .leading){
                    Text("\(name)")
                    Text("\(intakeVolume)")
                        .font(.system(size:13))
                }
                Spacer()
                Text("\(sugarVolume)")
            }
            Divider()
            HStack {
                VStack (alignment: .leading){
                    Text("\(name)")
                    Text("\(intakeVolume)")
                        .font(.system(size:13))
                }
                Spacer()
                Text("\(sugarVolume)")
            }
            Divider()
            Spacer()
        }
        .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
    }
}

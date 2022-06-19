//
//  MainFullListView.swift
//  ggwadang
//
//  Created by Hyemin Choi on 2022/06/17.
//

import SwiftUI
import RealmSwift

struct MainFullListView: View {
    // TODO: RecordDB에서 오늘 먹은 음식불러오기
    // 아래는 더미데이터
    @State private var name: String = "아니 없어요"
    @State private var intakeVolume: String = "없어요"
    @State private var sugarVolume: String = "아니 없어요!"
    
    let realm = try! Realm()
    // FIXME: 스크롤 가능 리스트로 아예 변경
    var body: some View {
        // 메인화면 2개 띄워주는건 설탕이 젤 많은게 먼저 오도록함.
        let userRecords = realm.objects(RecordDB.self).sorted(byKeyPath: "date").reversed()  // 날짜 순 정렬을 reserved => 가장 최근게 먼저
        
        VStack {
            HStack {
                Text("소그룹")
                Divider()
                Spacer()
                Text("날짜")
                Spacer()
                Divider()
                Text("설탕")
            }
            .frame(height:40)
            List {
                if userRecords.isEmpty {
                    VStack (alignment: .leading){
                        Text("\(name)")
                        Text("\(intakeVolume)")
                            .font(.system(size:13))
                    }
                }
                ForEach(userRecords, id: \.self) { record in
                    HStack {
                        Text("\(record.large) > \(record.medium) > \(record.small) / \(record.date)")
                        Spacer()
                        Text("\(record.calculatedSugar, specifier: "%.1f")g").bold()
                    }
                }
            }
            .listStyle(.plain)
            .navigationTitle(Text("\(today, formatter: MainView.dateFormat)"))
//            HStack {
//                VStack (alignment: .leading){
//                    Text("\(name)")
//                    Text("\(intakeVolume)")
//                        .font(.system(size:13))
//                }
//                Spacer()
//                Text("\(sugarVolume)")
//            }
//            Divider()
//            HStack {
//                VStack (alignment: .leading){
//                    Text("\(name)")
//                    Text("\(intakeVolume)")
//                        .font(.system(size:13))
//                }
//                Spacer()
//                Text("\(sugarVolume)")
//            }
//            Divider()
//            Spacer()
        }
        .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
    }
}

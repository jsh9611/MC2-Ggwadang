//
//  SettingListView.swift
//  ggwadang
//
//  Created by SeongHoon Jang on 2022/06/19.
//

import SwiftUI

struct SettingListView: View {
    
    // 사용자 안내 온보딩 페이지
    @AppStorage(StorageKeys.isFirstLaunching.rawValue) private var isFirstLaunching: Bool = true
    // 사용자 입력 온보딩 페이지(테스트용이라 나중에 무조건 빼주세요!!!)
    @AppStorage(StorageKeys.isFirstDataInput.rawValue) private var isFirstDataInput: Bool = true   // 유저 입력
    
    var body: some View {
        List {
            NavigationLink(destination: SettingUserInfoView()) {
                Text("개인정보 변경")
            }
            NavigationLink(destination: SettingUserSugarView()) {
                Text("목표 섭취량 변경")
            }
            Toggle("도움말 다시보기", isOn: $isFirstLaunching)
            //Toggle("유저정보 테스트 끝나면 이거 삭제ㄱ", isOn: $isFirstDataInput)
                .listRowBackground(Color.clear)
        }
        .onAppear{
            UITableView.appearance().backgroundColor = UIColor.white
        }
        .navigationBarTitle("Settings")
    }
}

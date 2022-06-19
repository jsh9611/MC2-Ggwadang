//
//  ContentView.swift
//  ggwadang
//
//  Created by kimjimin on 2022/06/05.
//

import SwiftUI

struct ContentView: View {
    // 사용자 안내 온보딩 페이지
    @AppStorage(StorageKeys.isFirstLaunching.rawValue) private var isFirstLaunching: Bool = true
    // 사용자 입력 온보딩 페이지
    @AppStorage(StorageKeys.isFirstDataInput.rawValue) private var isFirstDataInput: Bool = true   // 유저 입력
    
    @EnvironmentObject var store: RecordStore
    
    
    var body: some View {
        // 도움말 페이지를 본적이 없다면 이동
        if isFirstLaunching {
            GuideTabView(isFirstLaunching: $isFirstLaunching)
        // 입력 페이지를 본 적이 없다면 이동
        } else if isFirstDataInput {
            EnterUserDataView(isFirstDataInput: $isFirstDataInput)
        } else {
            // 실행한 적이 있었다면 메인 페이지로 이동.
            tabView(records: store.records)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

//
//  TempContentView.swift
//  ggwadang
//
//  Created by SeongHoon Jang on 2022/06/13.
//

import SwiftUI

// 테스트를 위한 임시용 View 입니다.
struct TempContentView: View {
    // 사용자 안내 온보딩 페이지
    @AppStorage(StorageKeys.isFirstLaunching.rawValue) private var isFirstLaunching: Bool = true
    // 사용자 입력 온보딩 페이지
    @AppStorage(StorageKeys.isFirstDataInput.rawValue) private var isFirstDataInput: Bool = true   // 유저 입력
    var body: some View {
        // 도움말 페이지를 본적이 없다면 이동
        if isFirstLaunching {
            GuideTabView(isFirstLaunching: $isFirstLaunching)
        // 입력 페이지를 본 적이 없다면 이동
        } else if isFirstDataInput {
            EnterUserDataView(isFirstDataInput: $isFirstDataInput)
        } else {
            // 실행한 적이 있었다면 메인 페이지로 이동.
            VStack {
                Toggle("도움말 다시보기", isOn: $isFirstLaunching)
                Toggle("입력량 다시보기", isOn: $isFirstDataInput)
                Button {
                    withAnimation {
                        self.isFirstLaunching = true
                        self.isFirstDataInput = true
                    }
                } label: {
                    Text("둘다 다시 보기")
                        .font(.title)
                        .background(.cyan)
                        .foregroundColor(.white)
                }
            }
            
        }
    }
}

struct TempContentView_Previews: PreviewProvider {
    static var previews: some View {
        TempContentView()
    }
}

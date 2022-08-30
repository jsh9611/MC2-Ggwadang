//
//  SettingListView.swift
//  ggwadang
//
//  Created by SeongHoon Jang on 2022/06/19.
//

import SwiftUI

struct SettingListView: View {
    
    // MARK: - AppStorage Keys for Onboarding(도움말)
    @AppStorage(StorageKeys.isFirstLaunching.rawValue) private var isFirstLaunching: Bool = true
    @Binding var naviLinkActive : Bool
    
    var body: some View {
        List {
            Section(header: Text("사용자")) {
                NavigationLink(destination: SettingUserInfoView(naviLinkActive: $naviLinkActive)) {
                    Text("개인정보 변경")
                }
                
                NavigationLink(destination: SettingUserSugarView(naviLinkActive: $naviLinkActive)) {
                    Text("목표 섭취량 변경")
                }
            }
            .listRowBackground(Color.clear)
            
            Section(header: Text("정보")) {
                ZStack {
                    NavigationLink(destination: Text("짜잔!")) {
                        Text("도움말 다시보기")
                    }
                    
                    HStack {
                        VStack {
                            Rectangle().opacity(0.00000001)
                            Spacer()
                        }
                        Spacer()
                    }
                    
                }.onTapGesture { isFirstLaunching.toggle() }

                NavigationLink(destination: LicenseView()) {
                    Text("오픈소스 라이선스")
                }
            }
            .listRowBackground(Color.clear)
        }
        .onAppear{
            UITableView.appearance().backgroundColor = UIColor.white
        }
        .navigationBarTitle("설정")
    }
}

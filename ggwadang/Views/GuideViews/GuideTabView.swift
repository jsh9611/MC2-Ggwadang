//
//  HelpTabView.swift
//  GwadangAntony
//
//  Created by SeongHoon Jang on 2022/06/09.
//

import SwiftUI

struct GuideTabView: View {
    @Binding var isFirstLaunching: Bool
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color(hex: 0x9DD2B9), Color(hex: 0x6CADA5)]),
                           startPoint: .top, endPoint: .bottom)
            
            .edgesIgnoringSafeArea(.all)
            ZStack {
                TabView {
                    // 페이지 1:
                    GuidePageView(
<<<<<<< HEAD
                        imageName: "꽈당이온보딩1",
                        title: "꽈당이 함께할게요!",
                        subtitle: "하루동안 먹은 간식의 간편한 기록, \n총 섭취량과 많이 섭취한 카테고리 등 \n다양한 통계를 제공해요"
=======
                        imageName: "dang1",
                        title: "도움말 페이지에요.",
                        subtitle: "넹"
>>>>>>> 38906d5
                    )
                    
                    // 페이지 2:
                    GuidePageView(
<<<<<<< HEAD
                        imageName: "꽈당이온보딩3",
                        title: "색으로 나의 섭취량을 알아봐요!",
                        subtitle: "하루섭취 당이 목표치의\n40%가 되면 노란색,\n80%가 되면 빨간색,\n100%를 넘게 되면 검은색으로 변해요"
=======
                        imageName: "dang2",
                        title: "숭구리당당 숭당당",
                        subtitle: "수구수구당당 숭당당"
>>>>>>> 38906d5
                    )
                    
                    // 페이지 3: 마지막 페이지
                    GuideLastPageView(
<<<<<<< HEAD
                        imageName: "꽈당이온보딩4",
                        title: "목표를 세우고 당 섭취를 줄여봐요!",
                        subtitle: "당류는 총 에너지 섭취량의 10%\n이내로 섭취하는 게 좋다고 해요\n성별과 나이를 알려주시면\n이에 따른 권장 당 섭취량을 알려드릴게요",
                        isFirstLaunching: $isFirstLaunching
                    )
                }
                
=======
                        imageName: "dang3",
                        title: "경로당",
                        subtitle: "노인들이 모여 여가를 선용할 수 있도록 지어 놓은 집 형태의 사회복지시설.방.",
                        isFirstLaunching: $isFirstLaunching
                    )
                }
>>>>>>> 38906d5
                .tabViewStyle(PageTabViewStyle())   // tabView를 PageView처럼 만들어준다
                .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .interactive))    // 하단부 (. . .)
                
                HStack {
                    Spacer()
                    VStack {
                        Button {
                            isFirstLaunching.toggle()
                        } label: {
                            Text("Skip")
<<<<<<< HEAD
                                .font(.title3)
=======
>>>>>>> 38906d5
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                        }
                        .padding()
                        Spacer()
                    }
                }
            }
        }
    }
}

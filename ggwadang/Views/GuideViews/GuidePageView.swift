//
//  GuidePageView.swift
//  ggwadang
//
//  Created by SeongHoon Jang on 2022/06/13.
//

import SwiftUI

struct GuidePageView: View {
    let imageName: String
    let title: String
    let subtitle: String
    
    var body: some View {
        VStack {
            // Assets에 이미지 추가 필요함
<<<<<<< HEAD
            VStack {
                Image(imageName)
                    .resizable()
                    .frame(width: (UIScreen.main.bounds.width)*0.7, height: (UIScreen.main.bounds.width)*0.7)
                .padding()
            }
            
            VStack {
                Text(title)
                    .font(.title2)
                    .fontWeight(.bold)
                .padding()
                Text(subtitle)
                    .font(.body)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                Spacer()
            }
            .foregroundColor(.white)
            .frame(height: 300)
//            .background(Color.blue)
            
            
=======
//            Image(imageName)
            Image(systemName: "icloud") // 임시용
                .font(.system(size: 100))
                .padding()
            Text(title)
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding()
            Text(subtitle)
                .font(.title2)
>>>>>>> 38906d5
        }
    }
}

struct GuidePageView_Previews: PreviewProvider {
    static var previews: some View {
        GuidePageView(
<<<<<<< HEAD
            imageName: "꽈당이온보딩1",
            title: "쓰기 탭",
            subtitle: "이 앱은 개인 메모장으로 쓸 수 있어요\n가나다\n아자차카타하"
=======
            imageName: "note.text.badge.plus",
            title: "쓰기 탭",
            subtitle: "이 앱은 개인 메모장으로 쓸 수 있어요"
>>>>>>> 38906d5
        )
    }
}

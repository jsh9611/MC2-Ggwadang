//
//  LargeCategoryView.swift
//  ggwadang
//
//  Created by kimjimin on 2022/06/16.
//

import SwiftUI

struct LargeCategoryView: View {
    @State var large_isSelected = ""
    @State var medium_isSelected = ""
    @State var small_isSelected = ""
    @Binding var isPresented: Bool
    
    let largeArray = [["과자","🍪"], ["떡·견과류","🍡"], ["베이커리","🥐"], ["아이스크림","🍦"], ["유가공품","🥛"], ["음료","🥤"], ["초콜릿","🍫"], ["캐러멜·양갱","🍮"], ["캔디·젤리","🍭"]]
    var gridItemLayout = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
        NavigationView{
            VStack {
                dismissButton(isPresented: self.$isPresented)
                LazyVGrid(columns: gridItemLayout, spacing: 10) {
                    ForEach((0..<largeArray.count), id: \.self) { num in
                        NavigationLink(destination: MediumCategoryView(isPresented: self.$isPresented, large_isSelected: self.$large_isSelected, medium_isSelected: self.$medium_isSelected, small_isSelected: self.$small_isSelected)
                        ){
                            VStack(spacing: 10) {
                                Text(largeArray[num][1]).font(.system(size: 40))
                                Text(largeArray[num][0])
                                    .font(.system(size: 15))
                                    .foregroundColor(.black)
                            }
                        }
                        .simultaneousGesture(TapGesture().onEnded {
                            large_isSelected=largeArray[num][0]
                        })
                        .modifier(navViewModifier())
                    }
                }
                .padding(.top, 5)
                .padding([.leading, .trailing], 20)
                Spacer()
            }
        }
    }
}

struct navViewModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .navigationBarTitle("", displayMode: .inline)
            .navigationBarHidden(true)
            .frame(width: 110, height: 150)
            .background(RoundedRectangle(cornerRadius: 15)
                .fill(Color.white)
                .shadow(color: Color.gray.opacity(0.15), radius: 20, y: 3))
    }
    
}

struct dismissButton: View {
    @Binding var isPresented: Bool
    var body: some View {
        Button {
            isPresented.toggle()
        } label: {
            Image(systemName: "xmark")
                .resizable()
                .frame(width: 17, height: 17)
        }
        .padding([.top, .trailing], 10)
        .frame(maxWidth: .infinity, alignment: .trailing)
    }
}

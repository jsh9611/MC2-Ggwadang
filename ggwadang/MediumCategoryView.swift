//
//  MediumCategoryView.swift
//  ggwadang
//
//  Created by kimjimin on 2022/06/16.
//

import SwiftUI

struct MediumCategoryView: View {
    @EnvironmentObject var food: FoodStore
    @Binding var isPresented: Bool
    @Binding var large_isSelected: String
    @Binding var medium_isSelected: String
    @Binding var small_isSelected: String

    @State var mediumArray : [String] = []
    @State var smallArray : [String] = []
    var gridItemLayout = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
        LazyVGrid(columns: gridItemLayout, spacing: 10) {
            ForEach((0..<mediumArray.count), id: \.self) { num in
                NavigationLink(destination: SmallCategoryView(isPresented: self.$isPresented, large_isSelected: self.$large_isSelected, medium_isSelected: self.$medium_isSelected, small_isSelected: self.$small_isSelected, smallArray: $smallArray)
                ){
                    Text(mediumArray[num]).foregroundColor(.black)
                }
                .simultaneousGesture(TapGesture().onEnded {
                    medium_isSelected=mediumArray[num]
                    /** 바인딩으로 smallArray를 넘겨주기 위한 작업(가슴 아픈 코드) **/
                    let temp = food.foods.filter{
                        $0.large == large_isSelected &&
                        $0.medium == medium_isSelected
                    }
                    var tempSet : Set<String> = []
                    for tem in temp {
                        tempSet.insert(tem.small)
                    }
                    smallArray = tempSet.sorted()
                })
                .modifier(gridModifier())
            }
        }.onAppear {
            // 안좋은 코드
            // 리펙토링이 필요합니다ㅠㅠ
            let temp = food.foods.filter{ $0.large == large_isSelected }
            var tempSet : Set<String> = []
            for tem in temp {
                tempSet.insert(tem.medium)
            }
            mediumArray = tempSet.sorted()
        }
        
        .padding(.top, 20)
        .padding([.leading, .trailing], 20)
        .navigationBarTitle("", displayMode: .inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Text(large_isSelected)
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action:{
                    isPresented.toggle()
                }){Image(systemName: "xmark")}
            }
        }
        Spacer()
    }
}


struct gridModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(width: 110, height: 60)
            .background(RoundedRectangle(cornerRadius: 15)
                .fill(Color.white)
                .shadow(color: Color.gray.opacity(0.15), radius: 20, y: 3))
    }
    
}

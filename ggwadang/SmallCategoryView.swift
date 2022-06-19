//
//  SmallCategoryView.swift
//  ggwadang
//
//  Created by kimjimin on 2022/06/16.
//

import SwiftUI

struct SmallCategoryView: View {
    @EnvironmentObject var food: FoodStore
    @Binding var isPresented: Bool
    @Binding var large_isSelected: String
    @Binding var medium_isSelected: String
    @Binding var small_isSelected: String
    @Binding var smallArray: [String]

    
    var body: some View {
        List(0..<smallArray.count) { num in
            NavigationLink(destination: IntakeAmountView(isPresented: self.$isPresented, large_isSelected: self.$large_isSelected, medium_isSelected: self.$medium_isSelected, small_isSelected: self.$smallArray[num])
            ){
                Text("\(smallArray[num])" )
            }
            .listRowBackground(Color.clear)
        }
        .onAppear{
            UITableView.appearance().backgroundColor = UIColor.white
        }
        .navigationBarTitle("", displayMode: .inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Text(medium_isSelected)
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action:{
                    isPresented.toggle()
                }){Image(systemName: "xmark")}
            }
        }
    }
}

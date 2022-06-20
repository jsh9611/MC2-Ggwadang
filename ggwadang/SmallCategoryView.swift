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

    @State var query = ""
    var body: some View {
        List {
            ForEach(searchResults, id:\.self) {name in
                NavigationLink(destination: IntakeAmountView(isPresented: self.$isPresented, large_isSelected: self.$large_isSelected, medium_isSelected: self.$medium_isSelected, small_isSelected: $smallArray[smallArray.firstIndex(of: name)!])
            ){
                Text(name)
            }
            .listRowBackground(Color.clear)
            }
        }
        .searchable(text: $query, placement: .navigationBarDrawer(displayMode: .always), prompt:"검색어를 입력해주세요")
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
    var searchResults: [String] {
        if query.isEmpty {return smallArray}
        else{
            return smallArray.filter {$0.contains(query)}
        }
    }
}

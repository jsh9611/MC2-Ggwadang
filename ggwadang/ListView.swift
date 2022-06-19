//
//  ListView.swift
//  ggwadang
//
//  Created by kimjimin on 2022/06/16.
//

import SwiftUI
import RealmSwift

struct ListView: View {
    @EnvironmentObject var store: RecordStore
    @EnvironmentObject var food: FoodStore
    @State var isPresented = false
    
    var body: some View {
        EmptyView()
    }
}

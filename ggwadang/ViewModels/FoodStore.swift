//
//  FoodStore.swift
//  ggwadang
//
//  Created by kimjimin on 2022/06/18.
//

import SwiftUI
import Foundation
import RealmSwift

final class FoodStore: ObservableObject {
    private var foodResults: Results<FoodDB>
    
    init(realm: Realm) {
        csvToRealm()
        foodResults = realm.objects(FoodDB.self)
    }
    var foods: [Food] {
        foodResults.map(Food.init)
    }
}

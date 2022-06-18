//
//  FoodDB.swift
//  ggwadang
//
//  Created by kimjimin on 2022/06/18.
//

import Foundation
import RealmSwift

class FoodDB: Object {
    @objc dynamic var id = ""
    @objc dynamic var large = ""
    @objc dynamic var medium = ""
    @objc dynamic var small = ""
    @objc dynamic var sugarPerGram = ""
    @objc dynamic var servingSize = ""
    @objc dynamic var unit = ""
    
//    override static func primaryKey() -> String? {
//        "id"
//    }
//
    convenience init(id: String, large: String, medium: String, small: String, sugarPerGram: String, servingSize: String, unit: String) {
        self.init()
        self.id = id
        self.large = large
        self.medium = medium
        self.small = small
        self.sugarPerGram = sugarPerGram
        self.servingSize = servingSize
        self.unit = unit
    }
    
}

// FoodDB가 비여있다면 CSV로 부터 데이터를 파싱해서 DB에 저장합니다
func csvToRealm() {
    let realm = try! Realm()
    if realm.objects(FoodDB.self).isEmpty {
        let foods = loadCSV(from: "final_food_data")
        for food in foods {
            let item = FoodDB(id: food.id, large: food.large, medium: food.medium, small: food.small, sugarPerGram: food.sugarPerGram, servingSize: food.servingSize, unit: food.unit)
            try! realm.write {
                realm.add([item])
            }
        }
    }
}

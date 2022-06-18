//
//  Food.swift
//  ggwadang
//
//  Created by kimjimin on 2022/06/18.
//

import Foundation

struct csvFood: Identifiable {
    var id: String
    var large: String
    var medium: String
    var small: String
    var sugarPerGram: String
    var servingSize: String
    var unit: String
    
    init (raw: [String]) {
        id = raw[0]
        large = raw[1]
        medium = raw[2]
        small = raw[3]
        sugarPerGram = raw[4]
        servingSize = raw[5]
        unit = raw[6]
    }
}
struct Food: Identifiable {
    var id: String
    var large: String
    var medium: String
    var small: String
    var sugarPerGram: String
    var servingSize: String
    var unit: String
    
    init (foodDB: FoodDB) {
        id = foodDB.id
        large = foodDB.large
        medium = foodDB.medium
        small = foodDB.small
        sugarPerGram = foodDB.sugarPerGram
        servingSize = foodDB.servingSize
        unit = foodDB.unit
    }
}

// https://stackoverflow.com/questions/68991238/data-from-csv-file-wont-show-up-when-called-in-list-on-swift
func loadCSV(from csvName: String) -> [csvFood] {
    var csvToStruct = [csvFood]()
    
    guard let filePath = Bundle.main.path(forResource: csvName, ofType: "csv") else {
        return[]
    }
    
    var data = ""
    do {
        data = try String(contentsOfFile: filePath)
    } catch {
        print(error)
        return[]
    }

    var rows = data.components(separatedBy: "\n")
    
    let columnCount = rows.first?.components(separatedBy: ",").count
    rows.removeFirst()
    
    for row in rows {
        let csvColumns = row.components(separatedBy: ",")
        if csvColumns.count == columnCount {
            let foodStruct = csvFood.init(raw: csvColumns)
            csvToStruct.append(foodStruct)
        }
    }
    return csvToStruct
}

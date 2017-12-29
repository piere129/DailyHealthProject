import Foundation
class FoodItem {
    var type: FoodType
    var name: String
    var caloryAmount: Int
    
    init(foodType: FoodType, name: String, caloryAmount: Int) {
        self.type = foodType
        self.name = name
        self.caloryAmount = caloryAmount
    }

}

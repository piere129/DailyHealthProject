import Foundation
class FoodItem {
    var type: FoodType
    var name: String    
    var caloryAmount: Double
    
    init(foodType: FoodType, name: String, caloryAmount: Double) {
        self.type = foodType
        self.name = name
        self.caloryAmount = caloryAmount
    }

}

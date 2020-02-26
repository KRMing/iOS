import UIKit

class Mammal {
    var name = ""
    var canFly: Bool?
    var age: Int!
    var weight: Int
    
    init() {
        weight = 0
    }
    
    init(withName: String, flies: Bool, withAge: Int, withWeight: Int) {
        name = withName
        canFly = flies
        age = withAge
        weight = withWeight
    }
}

var a = Mammal()
var b = Mammal(withName: "Dog", flies: false, withAge: 1, withWeight: 12)

class Person: Mammal {
    var canMakeSandwich: Bool
    
    override init() {
        canMakeSandwich = false
        
        super.init()
        
        makeSandwich()
    }
    
    init(canMakeSandwich: Bool) {
        self.canMakeSandwich = canMakeSandwich
        
        super.init()
        
        makeSandwich()
    }
    
    func makeSandwich() {
        if canMakeSandwich {
            print("Here's your chicken avocado sandwich")
        }
        else {
            print("Here's two slices of bread")
        }
    }
}

var c = Person()
var d = Person(canMakeSandwich: true)

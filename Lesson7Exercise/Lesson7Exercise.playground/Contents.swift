import UIKit

class Spaceship {
    
    var fuelLevel:Int = 50
    
    func liftOff() {
        fuelLevel -= 50
        print("We have lift off!")
        print("Current Fuel level at: \(fuelLevel)")
    }
    
    func addFuel(fuel:Int) {
        fuelLevel += fuel
        print("Fuel added")
        print("Current Fuel level at: \(fuelLevel)")
    }
    
    func thrust() {
        fuelLevel -= 15
        print("Rocket is thrusting")
        print("Current Fuel level at: \(fuelLevel)")
    }
    
    func cruise() {
        fuelLevel -= 5
        print("Rocket is cruising")
        print("Current Fuel level at: \(fuelLevel)")
    }
    
}

var myShip = Spaceship()
myShip.addFuel(fuel: 50)
myShip.liftOff()
myShip.thrust()
myShip.cruise()

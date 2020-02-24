import UIKit

class Spaceship {

    var fuelLevel = 100
    var name = ""
    
    func cruise() {
        print("Cruising is initiated for \(name)")
    }
    
    func thrust() {
        print("Rocket thrusters is initiated for \(name)")
    }

}

var myShip:Spaceship = Spaceship()
myShip.name = "Tom"
myShip.cruise()
myShip.thrust()

import UIKit

// Optional declaration
var s:String? = "Hello"

// Using an IF statement to check for nil
if s != nil {
    // Unwrap the optional to get the value
    print(s!)
}
else {
    // s is nil, so don't do anything
}

// Optional Binding to check for nil
// Checks for nil, and assigns value into constant a
if let a = s {
    print(a)
}

// Spaceship class declaration
class Spaceship {
    func cruise() {
        print("Spaceship cruise!")
    }
}

// Optional Chaining
var sc:Spaceship? = nil
sc?.cruise()

// Implicitly Unwrapped Optionals
var s3:Spaceship! = Spaceship()
s3.cruise()





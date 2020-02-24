import UIKit

// basic hello printing function
func sayHello() {
    print("Hello!")
}

sayHello()

// function with parameters
func sayHelloTo(_ name:String, _ age:Int) {
    print("Hello, \(name), who is \(age) years old.")
}

sayHelloTo("Martin", 25)

// function with return value
func addFourTo(x:Int) -> Int {
    return x + 4
}

print(addFourTo(x: 10))

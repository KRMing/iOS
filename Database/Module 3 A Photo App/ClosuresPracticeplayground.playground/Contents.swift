//: A UIKit based Playground for presenting user interface
  
import UIKit

Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { (t) in
    
    
}

UIView.animate(withDuration: 1, animations: {
    
    
}) { (ended: Bool) in
    
    
}

func addTax(subTotal: Double, completion: @escaping (Double) -> Void) {
    
    let total = subTotal * 1.13
    
    completion(total)
}

func addTax(subTotal: Double) -> Double {
    
    return subTotal * 1.13
}

// call the one with the closure
addTax(subTotal: 20) { (total: Double) in
    
    print("My meal was $\(total)")
}

// call the one with the return value
print("My meal was $\(addTax(subTotal: 20))")

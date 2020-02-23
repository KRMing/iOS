import UIKit

func goodMorning() {
    print("Good Morning")
}

goodMorning()

func printTotalWithTax(subtotal:Double) {
    print(subtotal * 1.13)
}

printTotalWithTax(subtotal: 1.13)

func getTotalWithTax(subtotal:Double) -> Double {
    return subtotal * 1.13
}

print(getTotalWithTax(subtotal: 1.13))

func calculateTotalWithTax(subtotal:Double, tax:Double) -> Double {
    return subtotal * tax
}

print(calculateTotalWithTax(subtotal: 1.13, tax: 1.13))

import UIKit

var dict = ["CA": "California", "TX": "Texas"]
var arr = ["AL", "UT", "NY"]
var test = [02: "Seoul", 031: "Gyeonggi", 051: "Busan"]

for _ in 1...2 {
    print("hello")
}

for someVar in 1...10 {
    print(someVar)
}

for stateAbbrev in arr {
    print(stateAbbrev)
}

for arrIndex in 0...arr.count-1 {
    print("#\(arrIndex) is \(arr[arrIndex])")
}

for (abbrev, state) in dict {
    print("\(abbrev) is \(state)")
}

for (regionNum, region) in test {
    print("Region number for \(String(region)) is \(regionNum).")
}

while arr.count <= 0 {
    arr.append("OH")
}
print(arr)

repeat {
    arr.append("OH")
} while arr.count <= 0
print(arr)

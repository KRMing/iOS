import UIKit

var array = [String]()
var array2 = ["e", "f"]

array.append("a")
array += ["b"]
array += ["c", "d"]
print(array)

array.append(contentsOf: array2)
print(array)

print(array[0])
print(array[1])
print(array.count)

array.append(contentsOf: [String(1), String(3)])
print(array)

array.remove(at: 6)
print(array)

array.remove(at: array.count-1)
print(array)

array.append(String(3))
print(array)

array.removeLast()
print(array)

print(array.removeFirst())



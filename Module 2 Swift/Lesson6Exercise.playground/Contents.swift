import UIKit

var dict = ["CA": "California", "TX": "Texas"]
var emptyDict = [String:String]()

dict["AL"] = "Alabama"
dict["NC"] = "North Carolina"

print(dict)

print(dict["AL"]!)
print(dict["CA"]!)

if dict["NY"] != nil {
    print(dict["NY"]!)
}

print(dict.count)

dict.removeValue(forKey: "CA")
print(dict)

dict["AL"] = nil
print(dict)

dict.removeValue(forKey: "AL")
print(dict)

import UIKit

class Person {
    var firstName = ""
    var lastName = ""
    
    init(firstName: String, lastName: String) {
        self.firstName = firstName
        self.lastName = lastName
    }
}

struct Book {
    var pages: Int
}

var student = Person(firstName: "Mike", lastName: "Jones")

var tom = student
tom.firstName = "Tom"

print(student.firstName)
print(tom.firstName)

var textbook = Book(pages: 100)
print(textbook.pages)


var photocopy = textbook
print(photocopy.pages)
photocopy.pages = 99

print(textbook.pages)
print(photocopy.pages)

var classArray = [tom, student]

var classArrayCopy = classArray
classArrayCopy[0].firstName = "Joe"

print(classArray[0].firstName)
print(classArray[1].firstName)
print(classArrayCopy[0].firstName)
print(classArrayCopy[1].firstName)

var structArray = [textbook, photocopy]
var structArrayCopy = structArray
structArrayCopy[0].pages = 10
structArrayCopy[1].pages = 11

print(structArray[0].pages)
print(structArray[1].pages)
print(structArrayCopy[0].pages)
print(structArrayCopy[1].pages)

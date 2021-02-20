import UIKit

var str = "Hello, playground"
print("They wrote:\(str)")


func printAndMultiply(_str : String ,_intval : Int?)-> Int{
    print("Inputted number is:\(_intval)")
    print("Inputted String name is :\(_str)")
    
    guard  let intval = _intval else {return 0}
        
   return  intval*5
    
}
    


print(printAndMultiply(_str: "Geetha", _intval: nil))


import Foundation

extension String {
    // convenience way to loop through with Character->String convert built in
    func each(closure: (String) -> Void ) {
        for digit in self
        {
            closure(String(digit))
        }
    }
}
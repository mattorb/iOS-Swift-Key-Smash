import Foundation
import UIKit

protocol Mode {
    func start() -> Void
    func respondTo(key:String) -> Void
}
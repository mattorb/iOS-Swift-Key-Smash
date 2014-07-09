import Foundation
import UIKit

protocol InteractionMode {
    func start() -> Void
    func respondTo(key:String) -> Void
}

import Foundation

public enum CardSwitcherError: Error, Sendable, Equatable {
    case invalidMerchant
    case invalidCard
    case networkFailure
    case cancelled
}

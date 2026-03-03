
import Foundation

public struct Card: Sendable, Hashable {
    public let last4: String
    public let expirationMMYY: String

    public init(last4: String, expirationMMYY: String) {
        self.last4 = last4
        self.expirationMMYY = expirationMMYY
    }
}

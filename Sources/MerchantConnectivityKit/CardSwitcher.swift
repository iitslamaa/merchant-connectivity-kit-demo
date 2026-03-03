import Foundation

/// A demo SDK component that simulates updating a payment method
/// for a merchant account.
public final class CardSwitcher: @unchecked Sendable {

    public struct Configuration: Sendable {
        public var simulatedLatencyNanoseconds: UInt64
        public var failureRate: Double

        public init(
            simulatedLatencyNanoseconds: UInt64 = 300_000_000,
            failureRate: Double = 0.1
        ) {
            self.simulatedLatencyNanoseconds = simulatedLatencyNanoseconds
            self.failureRate = failureRate
        }
    }

    private let config: Configuration

    public init(configuration: Configuration = .init()) {
        self.config = configuration
    }

    /// Updates the card on file for a merchant.
    public func updateCard(
        for merchant: Merchant,
        with card: Card
    ) async throws {

        try Task.checkCancellation()

        guard !merchant.id.isEmpty else {
            throw CardSwitcherError.invalidMerchant
        }

        guard card.last4.count == 4 else {
            throw CardSwitcherError.invalidCard
        }

        do {
            try await Task.sleep(nanoseconds: config.simulatedLatencyNanoseconds)
        } catch {
            throw CardSwitcherError.cancelled
        }

        let randomValue = Double.random(in: 0...1)

        if randomValue < config.failureRate {
            throw CardSwitcherError.networkFailure
        }
    }
}

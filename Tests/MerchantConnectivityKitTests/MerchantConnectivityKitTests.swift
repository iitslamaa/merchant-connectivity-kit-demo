import XCTest
@testable import MerchantConnectivityKit

final class CardSwitcherTests: XCTestCase {

    func testUpdateCardSucceedsWithValidInput() async throws {
        let sdk = CardSwitcher(
            configuration: .init(
                simulatedLatencyNanoseconds: 1_000_000,
                failureRate: 0.0
            )
        )

        try await sdk.updateCard(
            for: Merchant(id: "netflix", name: "Netflix"),
            with: Card(last4: "1234", expirationMMYY: "0129")
        )
    }

    func testInvalidMerchantThrows() async {
        let sdk = CardSwitcher(
            configuration: .init(
                simulatedLatencyNanoseconds: 1_000_000,
                failureRate: 0.0
            )
        )

        do {
            try await sdk.updateCard(
                for: Merchant(id: "", name: "Bad"),
                with: Card(last4: "1234", expirationMMYY: "0129")
            )
            XCTFail("Expected invalidMerchant error")
        } catch let error as CardSwitcherError {
            XCTAssertEqual(error, .invalidMerchant)
        } catch {
            XCTFail("Unexpected error: \(error)")
        }
    }

    func testInvalidCardThrows() async {
        let sdk = CardSwitcher(
            configuration: .init(
                simulatedLatencyNanoseconds: 1_000_000,
                failureRate: 0.0
            )
        )

        do {
            try await sdk.updateCard(
                for: Merchant(id: "paypal", name: "PayPal"),
                with: Card(last4: "12", expirationMMYY: "0129")
            )
            XCTFail("Expected invalidCard error")
        } catch let error as CardSwitcherError {
            XCTAssertEqual(error, .invalidCard)
        } catch {
            XCTFail("Unexpected error: \(error)")
        }
    }

    func testCancellation() async {
        let sdk = CardSwitcher(
            configuration: .init(
                simulatedLatencyNanoseconds: 2_000_000_000,
                failureRate: 0.0
            )
        )

        let task = Task {
            try await sdk.updateCard(
                for: Merchant(id: "amex", name: "Amex"),
                with: Card(last4: "9999", expirationMMYY: "0129")
            )
        }

        task.cancel()

        do {
            _ = try await task.value
            XCTFail("Expected cancellation")
        } catch {
            XCTAssertTrue(error is CancellationError || error as? CardSwitcherError == .cancelled)
        }
    }
}

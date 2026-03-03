# MerchantConnectivityKit (Demo SDK)

This project is a small demonstration of how I approach designing an embedded iOS SDK.

The goal is to demonstrate:

- Clean public API design
- Async / await concurrency patterns
- Explicit error modeling
- Cancellation safety
- Unit testing discipline
- SDK integration ergonomics

## Example Usage

```swift
import MerchantConnectivityKit

let cardSwitcher = CardSwitcher()

try await cardSwitcher.updateCard(
    for: Merchant(id: "netflix", name: "Netflix"),
    with: Card(last4: "1234", expirationMMYY: "0129")
)

# MerchantConnectivityKit

A demo Swift Package showing how I approach designing an embedded iOS SDK.

## Goals
- Clean public API design
- Async/await concurrency patterns
- Explicit error modeling
- Cancellation safety
- Unit testing of failure modes
- Integration ergonomics for host apps

## Example

```swift
import MerchantConnectivityKit

let cardSwitcher = CardSwitcher()

try await cardSwitcher.updateCard(
    for: Merchant(id: "netflix", name: "Netflix"),
    with: Card(last4: "1234", expirationMMYY: "0129")
)

Design considerations

• Typed errors for predictable SDK behavior
• Cancellation-aware async operations
• Configuration injection for deterministic tests
• Minimal public surface area to maintain API stability

Future improvements

• Retry policies
• SDK versioning strategy
• Performance profiling with Instruments
• WKWebView merchant session layer

```
let sdk = CardSwitcher()

Task {
    do {
        try await sdk.updateCard(
            for: Merchant(id: "netflix", name: "Netflix"),
            with: Card(last4: "1234", expirationMMYY: "0129")
        )
        print("Card updated")
    } catch {
        print("Failed:", error)
    }
}
```

# MerchantConnectivityKit

A small Swift Package demonstrating how I approach designing an embedded iOS SDK.

The goal of this project is to explore SDK API design, concurrency patterns, error modeling, and developer integration ergonomics.

---

## Overview

MerchantConnectivityKit simulates an SDK that allows a host application to update a stored payment method for a merchant account.

In a real-world scenario, a fintech or consumer app could use an SDK like this to update a user's payment method across a merchant account (for example Netflix or other subscription services).

The focus of this project is the **developer-facing API layer** of an embedded SDK.

---

## Example Usage

```swift
import MerchantConnectivityKit

let cardSwitcher = CardSwitcher()

try await cardSwitcher.updateCard(
    for: Merchant(id: "netflix", name: "Netflix"),
    with: Card(last4: "1234", expirationMMYY: "0129")
)
```

Example inside an application context:

```swift
let sdk = CardSwitcher()

Task {
    do {
        try await sdk.updateCard(
            for: Merchant(id: "netflix", name: "Netflix"),
            with: Card(last4: "1234", expirationMMYY: "0129")
        )
        print("Card updated successfully")
    } catch {
        print("Update failed:", error)
    }
}
```

---

## Project Goals

- Clean and predictable public API design  
- Modern async/await concurrency patterns  
- Explicit typed error modeling  
- Cancellation-safe async operations  
- Testable architecture  
- Clear integration ergonomics for host apps  

---

## Design Considerations

### Typed Errors

SDKs should expose predictable failure modes so host apps can safely handle different error cases.

```swift
enum CardSwitcherError: Error {
    case invalidMerchant
    case invalidCard
    case networkFailure
    case cancelled
}
```

### Cancellation Awareness

Async operations check for cancellation before and after work to avoid unnecessary computation.

```swift
try Task.checkCancellation()
```

### Configuration Injection

Configuration can be injected to make behavior deterministic during testing.

```swift
CardSwitcher.Configuration(
    simulatedLatencyNanoseconds: 300_000_000,
    failureRate: 0.1
)
```

### Minimal Public API Surface

The public interface is intentionally small and focused to keep the SDK stable and easy to integrate.

---

## Testing

The package includes unit tests covering:

- Successful card update  
- Invalid merchant input  
- Invalid card validation  
- Cancellation behavior  

Run tests with:

```bash
swift test
```

---

## Future Improvements

Potential extensions for a production SDK:

- Retry policies for transient failures  
- Versioned public API surface  
- Performance profiling with Instruments  
- Merchant session flows using WKWebView  
- Logging and observability hooks for host apps  

---

## Why This Project Exists

This project was built to explore how embedded iOS SDKs are designed and consumed by other applications, with a focus on reliability, predictable APIs, and developer experience.

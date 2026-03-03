import Foundation

/// Example showing how a host app would use the SDK.
func demoCardUpdate() async {

    let sdk = CardSwitcher()

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

// Example usage (not executed automatically during package builds/tests)
// Task {
//     await demoCardUpdate()
// }

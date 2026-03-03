import MerchantConnectivityKit
import Foundation

@main
struct DemoApp {

    static func main() async {

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
}

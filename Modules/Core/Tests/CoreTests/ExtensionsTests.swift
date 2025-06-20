@testable import Core
import XCTest

final class ExtensionsTests: XCTestCase {
    func testUniqueByKeySelector() {
        struct Item { let id: Int; let name: String }
        let items = [Item(id: 1, name: "A"), Item(id: 2, name: "B"), Item(id: 1, name: "C")]
        let uniques = items.unique { $0.id }
        XCTAssertEqual(uniques.count, 2)
        XCTAssertEqual(uniques.map { $0.name }, ["A", "B"])
    }

    func testFormattedYear() {
        let date = DateFormatter.yyyyMMdd.date(from: "2020-06-15")!
        XCTAssertEqual(date.formattedYear(), "2020")
    }

    func testDateFormatter_yyyyMMddParsesAndFormats() {
        let date = DateFormatter.yyyyMMdd.date(from: "2021-12-31")
        XCTAssertNotNil(date)
        let string = DateFormatter.yyyyMMdd.string(from: date!)
        XCTAssertEqual(string, "2021-12-31")
    }

    func testFormattedPriceDefault() {
        let value = 1234.567
        let formatted = value.formattedPrice()
        XCTAssertTrue(formatted.hasSuffix("$"), "Should default to suffix currency format")
    }

    func testFormattedPriceWithPrefixAndFractionDigits() {
        let value = 1234.567
        let formatted = value.formattedPrice(
            currency: "USD",
            style: .currency,
            maximumFractionDigits: 2,
            currencyPrefix: true
        )
        XCTAssertTrue(formatted.starts(with: "USD"), "Should prefix currency code")
        XCTAssertTrue(formatted.contains("."), "Should include fractional part")
    }

    func testIsEmptyOrNil() {
        let empty: String? = ""
        let whitespace: String? = "   "
        let nilString: String? = nil
        let filled: String? = "text"

        XCTAssertTrue(empty.isEmptyOrNil)
        XCTAssertTrue(whitespace.isEmptyOrNil)
        XCTAssertTrue(nilString.isEmptyOrNil)
        XCTAssertFalse(filled.isEmptyOrNil)

        XCTAssertTrue(filled.isNotEmptyOrNotNil)
        XCTAssertFalse(nilString.isNotEmptyOrNotNil)
    }

    func testTrimmingWhiteSpacesAndNewlines() {
        let string = "  Hello \n"
        XCTAssertEqual(string.trimmingWhiteSpacesAndNewlines(), "Hello")
    }

    func testIsBlankString() {
        XCTAssertTrue("   ".isBlankString)
        XCTAssertFalse("not blank".isBlankString)
    }
}

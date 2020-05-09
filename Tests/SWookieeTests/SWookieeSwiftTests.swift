import XCTest
@testable import SWookiee

final class SWookieeTests: XCTestCase {
    func testRoot() {
        let expectation = XCTestExpectation()
        Root.fetch { root, err in
            XCTAssertNil(err)
            guard let root = root else {
                XCTFail()
                return
            }
            XCTAssertEqual(root.films.path, Endpoint.films.baseURL.path)
            XCTAssertEqual(root.people.path, Endpoint.people.baseURL.path)
            XCTAssertEqual(root.planets.path, Endpoint.planets.baseURL.path)
            XCTAssertEqual(root.species.path, Endpoint.species.baseURL.path)
            XCTAssertEqual(root.starships.path, Endpoint.starships.baseURL.path)
            XCTAssertEqual(root.vehicles.path, Endpoint.vehicles.baseURL.path)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10.0)
    }

    func testPeople() {
        let expectation = XCTestExpectation()
        Person.fetch { people, err in
            XCTAssertNil(err)
            guard let people = people else {
                XCTFail()
                return
            }
            XCTAssertTrue(people.count > 0)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testPerson() {
        let expectation = XCTestExpectation()
        Person.fetch(id: 1) { person, err in
            XCTAssertNil(err)
            guard let person = person else {
                XCTFail()
                return
            }
            XCTAssertTrue(person.birthYear.count > 0)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10.0)
    }

    static var allTests = [
        ("testRoot", testRoot),
        ("testPeople", testPeople),
        ("testPerson", testPerson),
    ]
}

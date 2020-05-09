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
    
    func testFilms() {
        let expectation = XCTestExpectation()
        Film.fetch { films, err in
            XCTAssertNil(err)
            guard let films = films else {
                XCTFail()
                return
            }
            XCTAssertTrue(films.count > 0)
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
    
    func testPlanets() {
        let expectation = XCTestExpectation()
        Planet.fetch { planets, err in
            XCTAssertNil(err)
            guard let planets = planets else {
                XCTFail()
                return
            }
            XCTAssertTrue(planets.count > 0)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testSpecies() {
        let expectation = XCTestExpectation()
        Species.fetch { species, err in
            XCTAssertNil(err)
            guard let species = species else {
                XCTFail()
                return
            }
            XCTAssertTrue(species.count > 0)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testStarships() {
        let expectation = XCTestExpectation()
        Starship.fetch { starships, err in
            XCTAssertNil(err)
            guard let starships = starships else {
                XCTFail()
                return
            }
            XCTAssertTrue(starships.count > 0)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testVehicles() {
        let expectation = XCTestExpectation()
        Vehicle.fetch { vehicles, err in
            XCTAssertNil(err)
            guard let vehicles = vehicles else {
                XCTFail()
                return
            }
            XCTAssertTrue(vehicles.count > 0)
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
            XCTAssertTrue(person.eyeColor.count > 0)
            XCTAssertTrue(person.gender.count > 0)
            XCTAssertTrue(person.hairColor.count > 0)
            XCTAssertTrue(person.height.count > 0)
            XCTAssertTrue(person.mass.count > 0)
            XCTAssertTrue(person.skinColor.count > 0)
            XCTAssertTrue(person.homeworld.count > 0)
            XCTAssertTrue(person.films.count > 0)
            XCTAssertTrue(person.starships.count > 0)
            XCTAssertTrue(person.vehicles.count > 0)
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

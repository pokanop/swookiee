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
    
    func testFilm() {
        let expectation = XCTestExpectation()
        Film.fetch(id: 1) { film, err in
            XCTAssertNil(err)
            guard let film = film else {
                XCTFail()
                return
            }
            XCTAssertTrue(film.name.count > 0)
            XCTAssertTrue(film.episode > 0)
            XCTAssertTrue(film.openingCrawl.count > 0)
            XCTAssertTrue(film.director.count > 0)
            XCTAssertTrue(film.producer.count > 0)
            XCTAssertTrue(film.species.count > 0)
            XCTAssertTrue(film.starships.count > 0)
            XCTAssertTrue(film.vehicles.count > 0)
            XCTAssertTrue(film.characters.count > 0)
            XCTAssertTrue(film.planets.count > 0)
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
    
    func testPlanet() {
        let expectation = XCTestExpectation()
        Planet.fetch(id: 1) { planet, err in
            XCTAssertNil(err)
            guard let planet = planet else {
                XCTFail()
                return
            }
            XCTAssertTrue(planet.name.count > 0)
            XCTAssertTrue(planet.diameter.count > 0)
            XCTAssertTrue(planet.rotationPeriod.count > 0)
            XCTAssertTrue(planet.orbitalPeriod.count > 0)
            XCTAssertTrue(planet.gravity.count > 0)
            XCTAssertTrue(planet.population.count > 0)
            XCTAssertTrue(planet.climate.count > 0)
            XCTAssertTrue(planet.terrain.count > 0)
            XCTAssertTrue(planet.surfaceWater.count > 0)
            XCTAssertTrue(planet.residents.count > 0)
            XCTAssertTrue(planet.films.count > 0)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testSpeciesSingle() {
        let expectation = XCTestExpectation()
        Species.fetch(id: 1) { species, err in
            XCTAssertNil(err)
            guard let species = species else {
                XCTFail()
                return
            }
            XCTAssertTrue(species.name.count > 0)
            XCTAssertTrue(species.classification.count > 0)
            XCTAssertTrue(species.designation.count > 0)
            XCTAssertTrue(species.averageHeight.count > 0)
            XCTAssertTrue(species.averageLifespan.count > 0)
            XCTAssertTrue(species.eyeColors.count > 0)
            XCTAssertTrue(species.hairColors.count > 0)
            XCTAssertTrue(species.skinColors.count > 0)
            XCTAssertTrue(species.language.count > 0)
            XCTAssertTrue(species.people.count > 0)
            XCTAssertTrue(species.films.count > 0)
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

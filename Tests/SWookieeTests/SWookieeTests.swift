import XCTest
@testable import SWookiee

final class SWookieeTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        Network.shared.provider = URLSession.shared
        Cache.shared.reset()
    }
    
    func testRoot() {
        let expectation = XCTestExpectation()
        Root.fetch { result in
            guard case .success(let root) = result else {
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
        Film.fetch { result in
            guard case .success(let films) = result else {
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
        Person.fetch { result in
            guard case .success(let people) = result else {
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
        Planet.fetch { result in
            guard case .success(let planets) = result else {
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
        Species.fetch { result in
            guard case .success(let species) = result else {
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
        Starship.fetch { result in
            guard case .success(let starships) = result else {
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
        Vehicle.fetch { result in
            guard case .success(let vehicles) = result else {
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
        Film.fetch(id: 1) { result in
            guard case .success(let film) = result else {
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
        Person.fetch(id: 1) { result in
            guard case .success(let person) = result else {
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
        Planet.fetch(id: 1) { result in
            guard case .success(let planet) = result else {
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
        Species.fetch(id: 1) { result in
            guard case .success(let species) = result else {
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
    
    func testStarship() {
        let expectation = XCTestExpectation()
        Starship.fetch(id: 10) { result in
            guard case .success(let starship) = result else {
                XCTFail()
                return
            }
            XCTAssertTrue(starship.name.count > 0)
            XCTAssertTrue(starship.model.count > 0)
            XCTAssertTrue(starship.starshipClass.count > 0)
            XCTAssertTrue(starship.manufacturer.count > 0)
            XCTAssertTrue(starship.costInCredits.count > 0)
            XCTAssertTrue(starship.length.count > 0)
            XCTAssertTrue(starship.crew.count > 0)
            XCTAssertTrue(starship.passengers.count > 0)
            XCTAssertTrue(starship.maxAtmospheringSpeed.count > 0)
            XCTAssertTrue(starship.hyperdriveRating.count > 0)
            XCTAssertTrue(starship.mglt.count > 0)
            XCTAssertTrue(starship.cargoCapacity.count > 0)
            XCTAssertTrue(starship.consumables.count > 0)
            XCTAssertTrue(starship.films.count > 0)
            XCTAssertTrue(starship.pilots.count > 0)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testVehicle() {
        let expectation = XCTestExpectation()
        Vehicle.fetch(id: 14) { result in
            guard case .success(let vehicle) = result else {
                XCTFail()
                return
            }
            XCTAssertTrue(vehicle.name.count > 0)
            XCTAssertTrue(vehicle.model.count > 0)
            XCTAssertTrue(vehicle.vehicleClass.count > 0)
            XCTAssertTrue(vehicle.manufacturer.count > 0)
            XCTAssertTrue(vehicle.length.count > 0)
            XCTAssertTrue(vehicle.costInCredits.count > 0)
            XCTAssertTrue(vehicle.crew.count > 0)
            XCTAssertTrue(vehicle.passengers.count > 0)
            XCTAssertTrue(vehicle.maxAtmospheringSpeed.count > 0)
            XCTAssertTrue(vehicle.cargoCapacity.count > 0)
            XCTAssertTrue(vehicle.consumables.count > 0)
            XCTAssertTrue(vehicle.films.count > 0)
            XCTAssertTrue(vehicle.pilots.count > 0)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testCache() {
        let expectation = XCTestExpectation()
        Person.fetch(id: 1) { result in
            guard case .success(let person) = result else {
                XCTFail()
                return
            }
            XCTAssertEqual(person, Cache.shared.get(Person.endpoint.itemURL(id: 1)))
            expectation.fulfill()
        }
        Film.fetch { result in
            guard case .success(let films) = result else {
                XCTFail()
                return
            }
            XCTAssertEqual(films, Cache.shared.get(Film.endpoint.baseURL))
        }
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testNetworkError() {
        let network = TestNetwork()
        Network.shared.provider = network
        
        network.error = NSError(domain: NSCocoaErrorDomain, code: NSURLErrorBadURL, userInfo: nil)
        Root.fetch { result in
            guard case .failure(let error) = result else {
                XCTFail()
                return
            }
            guard case SWookieeError.network(let underlyingError) = error else {
                XCTFail()
                return
            }
            XCTAssertEqual(underlyingError.localizedDescription, network.error?.localizedDescription)
        }
    }
    
    func testDataError() {
        let network = TestNetwork()
        Network.shared.provider = network
        
        Root.fetch { result in
            guard case .failure(let error) = result else {
                XCTFail()
                return
            }
            guard case SWookieeError.data = error else {
                XCTFail()
                return
            }
            XCTAssertEqual(error.localizedDescription, SWookieeError.data.localizedDescription)
        }
    }
    
    func testDecoderError() {
        let network = TestNetwork()
        Network.shared.provider = network
        
        network.data = "[}]{".data(using: .utf8)
        Root.fetch { result in
            guard case .failure(let error) = result else {
                XCTFail()
                return
            }
            guard case SWookieeError.decoder(let underlyingError) = error else {
                XCTFail()
                return
            }
            guard case DecodingError.dataCorrupted = underlyingError else {
                XCTFail()
                return
            }
        }
    }

    static var allTests = [
        ("testRoot", testRoot),
        ("testFilms", testFilms),
        ("testPeople", testPeople),
        ("testPlanets", testPlanets),
        ("testSpecies", testSpecies),
        ("testStarships", testStarships),
        ("testVehicles", testVehicles),
        ("testFilm", testFilm),
        ("testPerson", testPerson),
        ("testPlanet", testPlanet),
        ("testSpeciesSingle", testSpeciesSingle),
        ("testStarship", testStarship),
        ("testVehicle", testVehicle),
        ("testCache", testCache),
        ("testNetworkError", testNetworkError),
        ("testDataError", testDataError),
        ("testDecoderError", testDecoderError)
    ]
    
}

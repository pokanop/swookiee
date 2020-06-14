# SWookiee

A Swift based library for accessing [SWAPI](https://swapi.dev) because Star Wars 🖖🎤

<p align="center">
  <img src="Images/swookiee.gif" alt="animated" />
</p>

## The App

Open the `SWookiee.xcworkspace` and run the sample application shown above. It's a fun experience that demonstrates usage of the library.

> You might have trouble if you haven't set up Xcode with Github credentials since the app uses SPM to fetch repos.

## Installation

Use Swift Package Manager to install the `SWookiee` package.

## API

The API is simple and allows access to [SWAPI](https://swapi.dev) resources.

All of the major [`Resource`](https://github.com/pokanop/swookiee/blob/master/Sources/SWookiee/Resource.swift) types and structs available are:

- [Root](https://github.com/pokanop/swookiee/blob/master/Sources/SWookiee/Root.swift) - fetches the root resources from SWAPI
- [Film](https://github.com/pokanop/swookiee/blob/master/Sources/SWookiee/Film.swift) - fetches the film resources
- [Person](https://github.com/pokanop/swookiee/blob/master/Sources/SWookiee/Person.swift) - fetches the people resources
- [Planet](https://github.com/pokanop/swookiee/blob/master/Sources/SWookiee/Planet.swift) - fetches the planet resources
- [Species](https://github.com/pokanop/swookiee/blob/master/Sources/SWookiee/Species.swift) - fetches the species resources
- [Starship](https://github.com/pokanop/swookiee/blob/master/Sources/SWookiee/Starship.swift) - fetches the starship resources
- [Vehicle](https://github.com/pokanop/swookiee/blob/master/Sources/SWookiee/Vehicle.swift) - fetches the vehicle resources

For full details on which endpoints are used, check [`Endpoint.swift`](https://github.com/pokanop/swookiee/blob/master/Sources/SWookiee/Endpoint.swift).

The common method for fetching data, for example the films would be like this:

```swift
Film.fetch { result in
  guard case .success(let films) = result else {
    // Deal with failure
    return
  }

  // Do something with `films` list
}
```

Each resource can access related resources as well simply via [`Provider`](https://github.com/pokanop/swookiee/blob/master/Sources/SWookiee/Providers.swift) methods. For example, to get `characters` for a film, you can do:

```swift
film.characters { result in
  // Process list of characters or error
}
```

> All completion handlers may be called on a background thread, so if you're updating UI, be sure to dispatch back onto the **main** queue.

## Cache

The library [caches](https://github.com/pokanop/swookiee/blob/master/Sources/SWookiee/Cache.swift) responses by default, so subsequent requests don't reach out to the network. This _may_ or _may not_ be ideal but future changes can make this functionality more configurable.

Additionally, when you call `fetch` on any of the `Resource` types, it will follow pages automatically as well and get **all** the available data from SWAPI. Again, this may or may not be ideal, but can be augmented in the future.

## Image Search

The app tries to search for images from [Pixabay](https://pixabay.com/) so you'll need to update [`ImageService`](https://github.com/pokanop/swookiee/blob/adf5b793e0cafa70cfa1f8a15af1ab1d058a8471/Demo/SWookiee%20App/Services/ImageService.swift#L22) with an API key. Otherwise, the images feature will not work.

## Contributing

Contributions are what makes the open-source community such an amazing place to learn, inspire, and create. Any contributions you make are greatly appreciated.

1. Fork the Project
2. Create your Feature Branch (git checkout -b feature/AmazingFeature)
3. Commit your Changes (git commit -m 'Add some AmazingFeature')
4. Push to the Branch (git push origin feature/AmazingFeature)
5. Open a Pull Request

## License

Distributed under the MIT License.

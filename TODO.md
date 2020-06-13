# TODO

The library and app are in decent shape but there are several optimizations that can be made in retrospect.

- Add API documentation in comment blocks
- `ResourceExtensions` feels like it has too much and the library isn't optimal for generic usage but good for specialized calls to API like `person.films(...)` or something.
- Add star field backgrounds to intro and other areas in the app using `CAEmitterLayer`.
- Add header image to resource views for the item being viewed.
- Add images section to resource views, search the internets by default.
- Account for iPad and other sizing changes to make sure everything looks correct.
- Add GraphQL support instead of REST

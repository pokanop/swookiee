# TODO

The library and app is in decent shape but there are several optimizations that can be made in retrospect.

- `ResourceExtensions` feels like it has too much and the library isn't optimal for generic usage but good for specialized calls to API like `person.films(...)` or something.
- Add star field backgrounds to intro and other areas in the app using `CAEmitterLayer`.
- Add header image to resource views for the item being viewed.
- Add images section to resource views, search the internets by default.
- Add selection styling to cells and improve overall look for `AttributeCell` and `Relationship` cell.
- Account for iPad and other sizing changes to make sure everything looks correct.
- Fix constraint warnings for navigation title view using attributed strings.
- Check date handling since `created` and `updated` are empty and provide sane defaults everywhere.
- Add GraphQL support instead of REST

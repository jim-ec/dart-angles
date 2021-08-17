# Publishing new Versions

1. Merge everything back into `master`, delete development branches
2. Ensure correct functionality by running all unit tests: `dart test`
3. Add an entry to the [changelog](CHANGELOG.md)
4. Bump the version specified in the [Pub manifest](pubspec.yaml)
5. Create a GitHub release with the version number as the title, implies creating a Git tag
6. Publish package to Pub: `pub publish`

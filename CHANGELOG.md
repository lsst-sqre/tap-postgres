# Change log

tap-postgres is versioned with [semver](https://semver.org/). Dependencies are updated to the latest available version during each release. Those changes are not noted here explicitly.

Find changes for the upcoming release in the project's [changelog.d](https://github.com/lsst-sqre/tap-postgres/tree/main/changelog.d/).

<!-- scriv-insert-here -->

<a id='changelog-8.1.0'></a>
## 1.16.0 (2024-05-30)

### New features

- Added UWSInitAction class, which can be used to initialise the database schema & tables for UWS. Modified the web.xml to run the class on initialisation


### Bug fixes

- Freeze the cadc-tap dependencies to the versions that came with the most recently released image, to address backwards incompatible changes in the most recent cadc-tap util package release

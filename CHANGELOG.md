# Change log

tap-postgres is versioned with [semver](https://semver.org/). Dependencies are updated to the latest available version during each release. Those changes are not noted here explicitly.

Find changes for the upcoming release in the project's [changelog.d](https://github.com/lsst-sqre/tap-postgres/tree/main/changelog.d/).

<!-- scriv-insert-here -->

<a id='changelog-1.20.0'></a>
## 1.20.0 (2025-02-19)

### Added

-  Added /reg endpoint so that we don't have to use the external cadc web service

<a id='changelog-1.19.0'></a>
## 1.19.0 (2024-11-01)

### Changed

- Updated version of gms to >=1.0.14

### Fixed

- Label warning in Docker build

<a id='changelog-1.18.7'></a>
## 1.18.7 (2024-11-01)

### Fixed

- Enable non GCS S3 support for TAP_UPLOAD

<a id='changelog-1.18.6'></a>
## 1.18.6 (2024-09-12)

### Removed

- Remove jcenter repo as it is obsolete and no longer used by cadc

- Remove deprecated AuthenticatorImpl class

### Added

- Support for S3 bucket storage of async results

### Changed

- Switch RubinUploadManagerImpl to use UploadLimits and set a default filesize limit of 32Mb

### Other Changes

- Added mavenCentral and jCenter repos (match what we have in lsst-tap-service)

<a id='changelog-1.18.5'></a>
## 1.18.5 (2024-07-24)

### Fixed

- Changed QueryJobManager to use the IdentityManager available via the AuthenticationUtil class (OpenID in our case)
- Upgrade version of uws-server to 1.2.21
- Fixes issue with ownerID missing

<a id='changelog-1.18.4'></a>
## 1.18.4 (2024-07-19)

### Fixed

- Changed accessUrl use for /tables back to "base"

<a id='changelog-1.18.3'></a>
## 1.18.3 (2024-07-15)

### Other changes

- Remove unneeded cadc dependencies (issue with dali/stilts conflict)
- Upgrade log4j (Log4j vulnerability)
- Modified scriv settings 

<a id='changelog-1.18.2'></a>
## 1.18.2 (2024-07-12)

### Fixed

- Fix Postgres data database init scripts

<a id='changelog-1.18.1'></a>
## 1.18.1 (2024-07-11)

### Changed

- Change Postgres to v15 and base image to fedora (centos endoflife)

<a id='changelog-1.18.0'></a>
## 1.18.0 (2024-06-24)

### Changed

- Change result handling, to use a redirect servlet. Addresses issue with async failing due to auth header propagation with clients like pyvo, topcat

### Fixed

- Fixed Capabilities handling. Use new CapGetAction & CapInitAction, modified by getting pathPrefix from ENV property

<a id='changelog-1.17.3'></a>
## 1.17.3 (2024-06-18)

### Changed

- Upgrade MySQL connector to version 8.4.0

<a id='changelog-1.17.2'></a>
## 1.17.2 (2024-06-10)

### Fixed

- Fixed Capabilities based on standard, mainly Table Access and authentication related

### Changed

- Refactor UWSInitAction class a bit, make sure each call in the schema init process is separate

<a id='changelog-1.17.1'></a>
## 1.17.1 (2024-06-10)

### Fixed

- Added PgsphereDeParser to AdqlQueryImpl / Fixes issue with queries having quotes around column names ("size")

<a id='changelog-1.17.0'></a>
## 1.17.0 (2024-06-07)

## Changed

- Bump cadc dependency versions & switch to using cadc-tomcat image by @stvoutsin in #28


<a id='changelog-1.16.0'></a>
## 1.16.0 (2024-05-30)

### New features

- Added UWSInitAction class, which can be used to initialise the database schema & tables for UWS. Modified the web.xml to run the class on initialisation


### Bug fixes

- Freeze the cadc-tap dependencies to the versions that came with the most recently released image, to address backwards incompatible changes in the most recent cadc-tap util package release

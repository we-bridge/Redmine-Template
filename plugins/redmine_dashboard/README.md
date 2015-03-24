# Redmine Dashboard 2

[![Build Status](http://img.shields.io/travis/jgraichen/redmine_dashboard/stable-v2.svg?style=flat)](https://travis-ci.org/jgraichen/redmine_dashboard)
[![Rate at redmine.org](http://img.shields.io/badge/rate%20at-redmine.org-blue.svg?style=flat)](http://www.redmine.org/plugins/redmine-dashboard)
[![Follow at Twitter](http://img.shields.io/badge/follow%20at-twitter-blue.svg?style=flat)](https://twitter.com/RmDashboard)
[![Flattr this git repo](http://api.flattr.com/button/flattr-badge-large.png)](https://flattr.com/submit/auto?user_id=jgraichen&url=https://github.com/jgraichen/redmine_dashboard&tags=github&category=software)

This [Redmine](http://redmine.org) plugin adds an issue dashboard that supports drag and drop for issues and various filters.

**Redmine Dashboard 2** is compatible with Redmine 2.4 and possibly older versions.

![Redmine Dashboard v2.x Screenshot](http://altimos.de/rdb/img/rdb_2-1.png)

## Features List

* Drag-n-drop of issues
* Configurable columns
* Grouping & Filtering
* Group folding
* Hierarchical parent issue view
* Include subproject issues
* Quick edit of assignee and progress

Rate plugin at [redmine.org](http://www.redmine.org/plugins/redmine-dashboard).

## Install

### Ubuntu / Debian

I provide a PPA at [ppa:jgraichen/redmine-dashboard](https://launchpad.net/~jgraichen/+archive/redmine-dashboard) for Ubuntu Trusty that should work with Trusty's Redmine and [ppa:ondrej/redmine](https://launchpad.net/~ondrej/+archive/redmine). Debian Wheezy with wheezy-backports enabled should also work with trusty PPA.

### Others

Clone git repository to `plugins`, checkout wanted release (`git checkout v2.2.0`) and restart redmine. A database migration is not needed. Run `bundle install` to install required gems.

#### Upgrade

Fetch updates (`git fetch --tags`) and checkout newer release (`git checkout $(git tag | tail -n1)`). Run `bundle install` to install newly required gems. A database migration is not needed.

You can list all available version with `git tag -l`.

## Contribute

I appreciate any help and like Pull Requests. The `stable-v2` branch is the current stable branch for v2. The next version, Redmine Dashboard 3, a complete rewrite is under development on the `master` branch. Please try to not add larger new features to current v2.

I gladly accept new translations or language additions for any version of Redmine Dashboard. I would prefer new translations via [Transifex](https://www.transifex.com/projects/p/redmine-dashboard-2/) but you can also send a Pull Request. If you want to maintain a translation contact me via IRC (jgraichen at [irc://irc.freenode.net/redmine_dashboard](irc://irc.freenode.net/redmine_dashboard)) or email.

[![Translation status](https://www.transifex.com/projects/p/redmine-dashboard-2/resource/strings/chart/image_png)](https://www.transifex.com/projects/p/redmine-dashboard-2/)

## Build Debian / Ubuntu package

Checkout `debian` branch. The branch is prepared to be used with `gbp`.

* Build a source only package:
  `gbp buildpackage --git-builder="debuild -S" --git-ignore-new`
* Build binary packages with `sbuild`:
  `gbp buildpackage --git-builder="sbuild -A" --git-ignore-new`

## License

Redmine dashboard is licensed under the Apache License, Version 2.0.
See LICENSE for more information.

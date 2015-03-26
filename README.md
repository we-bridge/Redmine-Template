Plugins List
=

Open-source plugins are added as sub-modules while
others are directly added as-is in the repository.

Those are for Redmine 2.6

Submodules
==

- Dashboard v2 Stable
- CKEditor v1.1.0
- Knowledgebase v3.0.7
- Login Audit v0.1.5
- Git Remote (Latest)
- Default Members (Latest)
- Silencer (Latest)
- DMSF v1.4.9
- Tags (Lastest)
- Equipment Status Viewer (Latest)
- Lightbox2 (Latest for Redmine 2.6)

Other plugins
==

- Checklists Light v3.0.4
- Work Time v0.3.0
- People Light v0.1.8

Install
=

Installing required packages
==

    apt-get install imagemagick
    apt-get install zlib1g-dev
    apt-get install uuid-dev

Installing the plugins
==

    bundle install --without development test

Troubleshooting
===

Nokogiri Gem
====

If you have an error when installing the nokogiri bundle,
it might require the following configuration:

    bundle config build.nokogiri --use-system-libraries

Running Database Migrations
==

    rake redmine:plugins:migrate RAILS_ENV=production

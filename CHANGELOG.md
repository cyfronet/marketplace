# Change Log
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](http://keepachangelog.com/)
and this project adheres to [Semantic Versioning](http://semver.org/).

Please view this file on the master branch, on stable branches it's out of date.

## [Unreleased]

### Added
- Representation of the Resource Organisation and Resource Providers in the Resource views (@kmarszalek, @jarekzet)
- Removal of duplicated provider entries in the Resource Provider field in the MP (@kmarszalek)
- Extend finding resource in main searchbar (@danielkryska)

### Changed
- `Provided by` field in `Popular resources`, `Suggested compatible resources` and `Recently added resources` to `Organisation` (@kmarszalek, @jarekzet)

### Deprecated

### Removed

### Fixed

## [3.8.0] 2021-03-03

### Added
- Highcharts scalability for the resource and provider views (@kmarszalek, @jarekzet)

### Changed
- Geographical availabilities order in the Resource details view (@kmarszalek, @jarekzet)
- Title of section `Related resources` instead of `Suggested compatible resources`  in `details` and `opinions` page (@goreck888)
- Statistics in executive panel counting resources grouped in access types and MP ordering/No MP ordering (@goreck888) 

### Fixed
- Differences in the behaviour of the offer UI and API (@kmarszalek)
- Show no parameters information in `ordering_configuration` page and in backoffice (@goreck888)

## [3.7.1] 2021-02-26

### Fixed
- Rake `import:providers` abort when invalid provider data received (@goreck888)

## [3.7.0] 2021-02-19

### Added
- API for Resource Offers management v1 (@wujuu)
- OpenAPI (swagger) documentation (rswag gem) (@wujuu)
- User token authentication for the MP API (simple_token_authentication gem) (@wujuu)
- Possibility to generate token for the MP API (UI and logic) (@wujuu, @jarekzet)
- Dedicated panel for Data Administrator role for adding/editing offers and its parameters (@goreck888)
- Dedicated views for Data Administrator's panel (@JanKapala, @jarekzet)
- Database serialization task for recommender system (rake - recommender::serialize_db) (@wujuu)
- Resource Preview for the providers aligned with the layout of Resource Presentation Page (@goreck888, @jarekzet)
- New provider's view (@kmarszalek, @jarekzet)
- New information fields in the Provider model (@goreck888)
- Providers import task (rake import:providers) (@goreck888)

### Fixed
- A/B testing framework issues in unit tests (rspec, split) (@kmarszalek)
- Recommendations removed from the backoffice resource list (@JanKapala)
- Minor Offers API bugs and cosmetic content changes (@wujuu)

## [3.6.0] 2021-01-27

### Changed
- Replace will_paginate with pagy gem (@goreck888)
- Move from deprecated `service` API to `resource` API in Providers component (@goreck888)

### Fixed
- Filter Provider location, rename to Resource availability (@kmarszalek)

## [3.5.0] 2021-01-15

### Added
- More fields to the comparision view (@kmarszalek)

### Changed
- Footer content (@goreck888)
- Footer align with EOSC Portal (@kmarszalek)
- TRL field view on the service details page (@kmarszalek)

### Fixed
- Filter save by breadcrumbs navigation test (@goreck888)
- Filter Provider location to use geographical_availabilities (@kmarszalek)
- ActiveStorage analysis and purge queues in sidekiq configurations (@goreck888)

## [3.4.0] 2020-12-22

### Added
- Create Simple Recommender Service (@JanKapala)
- Create two versions of "Recommended results" section on the search result page, managed by the split gem (@JanKapala)

### Changed
- Adapt old tests to the new "Recommended results" section (@JanKapala)

### Fixed
- Remove parameters in default offer(@goreck888)

## [3.3.0] 2020-12-11

### Added
- Add fast_gettext, gettext_p18_rails, gettext, ruby_parser gems (@JanKapala)
- Mark missing translations with `-# TODO: missing translation` (@JanKapala)
- Mark i18 dynamic translations with `-# TODO: refactor dynamic translation` (@JanKapala)
- Add configuration of PO files
- Whitelabel gettext support (@wujuu)
- Resources api tests (@goreck888)
- View components (@goreck888)

### Changed
- Replace i18 static translations in views with gettext (@JanKapala)
- Replace part of i18 dynamic translations in views with gettext(@JanKapala)
- Replace direct html strings with gettext translations in views (@JanKapala)
- Refactor html injection via i18 translation into regular hamls  (@JanKapala)
- Log level in production environment to info (@goreck888)
- Refactor serivce details display (@wujuu)

## [3.2.0] 2020-11-20

### Added
- Add and configure split gem (@goreck888)
- Errored status for imported resources (@goreck888)

### Changed
- Backoffice front-end mods (@jarekzet)

### Fixed
- Popular resources (@goreck888)
- Displaying service details tour on project_item page (@goreck888)
- Change status of resource to draft via jms (@goreck888)

## [3.1.1] 2020-11-16

### Fixed
- Services api (@goreck888)

## [3.1.0] 2020-11-13

### Added
- missing tests for comparison view (@goreck888)
- missing tests for create/update default offer by create/update resource (@goreck888)
- Default resource logo if not set (@goreck888)
- Tours (@michal-szostak)
- JIRA collector button (@michal-szostak)
- Remove element for array inputs (@goreck888)

### Changed
- Improved README readability and accessibility (@JanKapala, @wujuu)
- Resource form fields sort similar as PC (@goreck888) 
- missing `service` to `resource` texts in popups and messages (@goreck888)

### Fixed
- Added missing `phone` field to contact forms (@goreck888)
- `rake dev:prime` task (@goreck888)
- Better parsing error handling in jms-subscriber (@goreck888)

### Security
- Allow ssl secured connection in jms (@goreck888)

## [3.0.0] 2020-10-23

### Added
- Links for EOSC Portal social media (@goreck888)
- Service order type visibility and filter (@goreck888)
- Missing breadcrumbs and page titles (@goreck888)
- new url fields in service model (@goreck888)
- new missing multiselect fields in service model (@goreck888)
- pc_categories and pc_platforms near the internal entities (@goreck888)
- missing eid for scientific_domains and target_users(@goreck888)
- synchronized_at field for pc_create_or_update (@goreck888)
- Handling eIC services ids in mp (@goreck888)
- New resource presentation page (@michal-szostak) 
- UPCASE languages in import:eic task (@michal-szostak)
- `internal` field for offers and project_items (@goreck888)
- links for tags and emails in details view (@goreck888)
- authorized import:eic by token as parameter (@goreck888)

### Changed
- Sidebar links section name change from 'support' to 'links' (@goreck888)
- information texts in service ordering page (@goreck888)
- `service_type` to `order_type` in service and offer (@goreck888)
- `tutorial_url` to `training_information_url` in service model (@goreck888)
- Service `title` to `name` (@goreck888)
- name of research area model to scientific domain (@goreck888)
- `languages` to `language_availability` in service model (@goreck888)
- `target_group` to `target_user` in service model (@martaswiatkowska)
- Added field resource_organisation(main provider) (@martaswiatkowska)
- Refactor contact fields to new model `Contact` (@goreck888)
- Refactor related services (@goreck888)
- handling errors with logo downloading in importers (@goreck888)
- Hide default offer (@goreck888)
- Update default offer through service (@goreck888)
- New order_type mapping (@goreck888)
- service to resources in the mp content (@goreck888)
- hide visibility of single offer but allow to edit parameters (@goreck888)

### Removed
- tagline and unnecessary offer titles in ordering form (@goreck888)

### Fixed
- Added missing homepage graphics (@jarekzet)
- instance badge display on backoffice section (@goreck888)
- contact form tab layout modifications (@jarekzet)
- Service preview (@goreck888)
- Duplicated "sort" ids on services page (@goreck888)
- rdt task (@martaswiatkowska)
- Show welcome popup depending on database user information, not cookies (@goreck888)
- Tab links in the home page (@jarekzet)
- Fix js test (@martaswiatkowska)
- Fixed autocomplete service name displayng (@martaswiatkowska)
- languages and geographical_availabilities display (@martaswiatkowska)
- displaying services on search (@martaswiatkowska)
- date style in service details in "Maturity Information" (@michal-szostak)
- language concatenation and header naming in service details (@michal-szostak)
- comparison view (@goreck888)
- parameters in offers (@goreck888)
- service sidebar and details titles `translation-missing` error (@goreck888)
- displaying categories as tree in the sidebar (@goreck888)

### Security
- Update rails to 6.0.3.2 (@goreck888)

## [2.11.0] 2020-06-09

### Added
- Research areas and categories of user interests (@goreck888)
- Subscription mechanism for new added services (@goreck888)
- Subscriber for eic messages (@martaswiatkowska)
- Use overmind instead of foreman if present in the classpath (@mkasztelnik)

### Changed
- Updated nodejs to version 10.19.0

### Security
- Updated jquery to version 3.5.1
- Updated puma to version 4.3.5
- Updated websocket-extensions (ruby) to version 0.1.5
- Updated websocket-extensions (js) to version 0.1.4

## [2.10.3] 2020-05-27

### Added
- Recaptcha error if not validated (@martaswiatkowska)
- instance badges (@goreck888)
- `robots.txt` depending on instance (@goreck888)

### Fixed
- Empty service phase and service type in comparison view (@goreck888)
- Custom page titles in MP pages (@goreck888)
- Popular services section based on popularity ratio (@goreck888)
- Data of project creation (@martaswiatkowska)
- Project fields length validation (@martaswiatkowska)
- Links to categories in footer (@goreck888)

## [2.10.2] 2020-05-20

### Added
- Recaptcha in project form and service ordering (@goreck888)

### Fixed
- Display empty offer parameters as not correctly validated (@goreck888)

## [2.10.1] 2020-05-12

### Fixed
- Places visualisation (@martaswiatkowska)

## [2.10.0] 2020-05-12

### Added
- White label customization for development (@michal-szostak)
- Send analytics to PC component by matomo (@goreck888)
- Visualization of places (@martaswiatkowska)
- Views counter taken from Google Analytics (@goreck888)

### Changed
- Unification of top links comparing with Portal (@goreck888)
- Updated JEST version (@martaswiatkowska)

### Fixed
- Fix moving offer parameter up and down (@mkasztelnik)
- Fix `dev:prime` after introducing offer parameters (@mkasztelnik)
- Fix counter for research area filter (@mkasztelnik)
- Highlights show when at least 3 signs in query (@goreck888)
- Fix datepicker styling (@goreck888)

## [2.9.1] 2020-04-02

### Fixed
- eIC import error handling (@goreck888)

## [2.9.0] 2020-04-01

### Added
- Version import (@martaswiatkowska)
- Service comparison feature (@goreck888)

### Changed
- DesignSystem home page implementation(@abacz, @jarekzet)

### Fixed
- Displaying empty links in service details (@goreck888)
- Autocomplete element styles (@martaswiatkowska)

## [2.8.1] 2020-03-30

### Changed
- Description of ordered services (@martaswiatkowska)

## [2.8.0] 2020-03-12

### Added
- Automatic offer creating by services import (@goreck888)
- Information about offers statuses in the backoffice (@goreck888)
- Offers to autocomplete (@martaswiatkowska)
- Offers to search (@martaswiatkowska)

### Changed
- Text label by offer selection in the first step of service ordering (@goreck888)
- Rack and linked gems update (@goreck888)
- Use category user used to enter the service in breadcrumbs (@mkasztelnik)
- Portal link description from `Info` to `Portal Home` (@goreck888)
- User interface for defining offer parameters insead of pure JSON
  (@mkasztelnik, @martaswiatkowska, @goreck888)

### Fixed
- Keep filters and query by using breadcrumbs to go back to the services view (@goreck888)
- Offence detected by new version of rubocop (@goreck888)
- Reverse order of statuses and fix automatic scroll in project/service messages (@goreck888)

### Security
- Update dependencies (@goreck888)

## [2.7.3] 2020-02-28

### Fixed
- Redirects for modals which don't have html view (@goreck888)

## [2.7.2] 2020-02-25

### Fixed
- Truncate long headers and description in homepage sections (@goreck888)
- i18n labels in the backoffice service view (@goreck888)

## [2.7.1] 2020-02-21

### Fixed
- Back to the old schema for json services api (@goreck888)

## [2.7.0] 2020-02-20

### Added
- Customization for translation files (@goreck888)
- Customization for scss files (@michal-szostak, @mkasztelnik)
- Lead section error box displayed to admin user (@martaswiatkowska)

### Changed
- Template unification for all modals (@goreck888)
- Update outdated `playground` description and replace it with `designsystem` section (@mkasztelnik)
- Refactor translation files (@goreck888)

### Removed
- Static help removed in favour of help stored in DB (@mkasztelnik)
- Remove outdated filter variables from service index views (@mkasztelnik)

## [2.6.3] 2020-02-18

### Fixed
- Displaying archived project status (@martaswiatkowska)

## [2.6.2] 2020-02-13

### Fixed
- Show menu on small devices (@mkasztelnik)

## [2.6.1] 2020-02-06

### Fixed
- service_counter rake task (@goreck888)

## [2.6.0] 2020-02-05

### Added
- Add static pages for design system and UI documentation (@mkasztelnik)
- Comment changes in jira propagate to mp (@martaswiatkowska)
- Dynamic help sections visible currently only for admin (@mkasztelnik)
- Service information for a monitoring tool through `api/services` (@goreck888)
- Customization of learn more and use case sections by admin (@martaswiatkowska)

### Changed
- Move research area and category logos to active storage (@mkasztelnik)
- Refactor homepage partials (@mkasztelnik)
- Services search view refactoring and unification with backoffice view (@goreck888)
- Webpack entry structure (@martaswiatkowska)
- Sidebar in the service view generic rendering (@goreck888)
- Popular services main page section based on number of orders (@goreck888)

### Removed
- Remove not used `CartPolicy` class (@mkasztelnik)

### Fixed
- change html tag to pure conversation URL in text based emails (@martaswiatkowska)

## [2.5.1] 2020-01-14

### Fixed
- Rollback to `rack` 2.0.7. New version is not compatible yet with `redis-rack` (@mkasztelnik)

## [2.5.0] 2020-01-13

### Added
- Statistics for executive user group (@mkasztelnik)
- Copy offer details to project item while placing order (@mkasztelnik)
- Loader/cog after filter select (@martaswiatkowska)
- Integration with xGUS helpdesk (@goreck888)

### Changed
- Disable visibility of `input` type attribute on the offer view (@goreck888)
- Displaying label on project_item view Orderable date (@martaswiatkowska)
- Upgrade to rails 6 (@mkasztelnik)
- Report technical problem button styling (@jarekzet)

### Security
- Updated dependencies (@martaswiatkowska)
- Fixed security vulnerabilities in gemfile (@martaswiatkowska)

## [2.4.0] 2019-12-12

### Added
- Sort offers by creation date (@mkasztelnik)
- Tooltips in the project view in project items status dot (@goreck888)

### Changed
- Changes styling on checkout - Technical configuration tab (@jarekzet)
- Hide parameters section when there is not parameters (@martaswiatkowska, @mkasztelnik)
- Don't register internal messages (@mkasztelnik, @martaswiatkowska)
- Move test services generation from `db:seed` to `dev:prime` (@mkasztelnik)
- Merge Filterable and Searchable into one module Searchable (@goreck888)
- ProjectItem rating questions customization by offer type (@goreck888)
- Offer view unification (@jarekzet)
- New statuses labels displayed on timeline (@martaswiatkowska)
- Activate_message are send in mail (@martaswiatkowska)
- FAQ section content (@goreck888)
- Children research areas view in backoffice (@goreck888)
- Content and naming of service details in the project items view (@goreck888)

### Removed
- Remove playground section (@mkasztelnik)
- Duplicates of ids and questions in FAQ (@goreck888)
- Remove service description index from DB (@mkasztelnik)

### Fixed
- `dev:prime` task migrations update (@goreck888)
- Return nil to jira if service doesn't have category (@martaswiatkowska)

## [2.3.0] 2019-11-25

### Added
- EOSC logo update (@bwilk)
- Catalog can be added to project (@martaswiatkowska)
- Project_new_message mails content (@martaswiatkowska)
- Information step to ordering path (@martaswiatkowska)
- Use service type as default order type while seeding db (@mkasztelnik)
- Offer type to the project and offer selection views (@goreck888, @jarekzet)
- Add help static page with example help accordion (@mkasztelnik)
- Additional information to summary step (@martaswiatkowska)

### Changed
- Internal server error message (@goreck888)
- Anonymous user can enter service offer selection section (@mkasztelnik)
- Service access button (@martaswiatkowska)
- Services can be added to project multiple times if offer has parameters (@martaswiatkowska)
- Service and offer type enum values (@goreck888)
- Service ordering summary step unification (@goreck888)
- Anonymous user can enter information step (@martaswiatkowska)
- Project selection was moved to last service order step (@mkasztelnik)
- Order configuration step is shown when offer is voucherable or has properties (@mkasztelnik)
- Improve order wizard naming (@mkasztelnik)
- Highlights in search from bold to mark (@goreck888)
- Main page greeting change (@goreck888)
- Move `Service.connected_url` to `Offer.webpage` (@mkasztelnik)
- Order path styling (@jarekzet)
- Offer type required (@martaswiatkowska)
- "Technical parameters" label to "Parameters" (@goreck888)

### Fixed
- Active Order button in service preview (@goreck888)
- Cancel order link redirect for non logged-in user (@goreck888)
- Research area links at a service pane apply the filter (@goreck888)

## [2.2.3] 2019-11-19

### Changed
- Main page greeting change (@goreck888)

## [2.2.2] 2019-11-08

### Fixed
- EIC import fix - skipping services which don't validate properly (@michal-szostak)

## [2.2.1] 2019-10-31

### Fixed
- Url validation (@martaswiatkowska)

## [2.2.0] 2019-10-18

### Added
- Filtering by upstream source in the backoffice (@goreck888)
- Add marketplace service preview in the backoffice (@mkasztelnik, @goreck888)
- Service unverified but published state (@mkasztelnik)
- Multi checkbox filters search (@mkasztelnik)
- Filters autoreload (@martaswiatkowska)
- Project creation time default (@martaswiatkowska)
- Flag to set default upstream when importing from EIC (@michal-szostak)
- Ask a service question for non-signed in users with re-captcha(@goreck888)
- All filters are expanded by default, state is stored in cookie (@mkasztelnik)
- Filter titles in active filters (@goreck888)
- Propagate Project info update to jira (@martaswiatkowska)
- Filter unnecessary customer typology fields (@martaswiatkowska)

### Changed
- Service's status is preserved when updating services during EIC import (@michal-szostak)
- Cleanup and refactoring for service browsing specs (@mkasztelnik)
- UI Fixes and upgrades (@jarekzet)
- Show first project services when after entering "My projects" section (@mkasztelnik)

### Removed
- Remove category `services_count` (@mkasztelnik)
- Remove unnecessary logs in js console(@goreck888)

### Fixed
- EOSC Portal component titles at the top bar (@bwilk)
- Hide scrollArrow on scroll event (@goreck888)
- EIC import when existing provider has the same name as imported one (@michal-szostak)
- Rescue errors in eic import (@martaswiatkowska)

## [2.1.6] 2019-10-11

### Fixed
- Fix attribute input validation (@martaswiatkowska)

## [2.1.5] 2019-10-09

### Fixed
- Fix IID in projects (@michal-szostak, @martaswiatkowska)

## [2.1.4] 2019-09-20

### Changed
- Category and Research Area name uniqueness is parent scoped (@mkasztelnik)

### Fixed
- Services descriptions in 'Popular services' section at Home Page (@bwilk)

## [2.1.3] 2019-09-10

### Added
- Filtering by upstream source in the backoffice (@goreck888)

### Fixed
- Display root categories in the main page (@goreck888)

## [2.1.2] 2019-09-04

### Fixed
- Removed uniqueness constraint on user email (@bwilk)

## [2.1.1] 2019-08-30

### Changed
- Content change at the home page (@bwilk)

## [2.1.0] 2019-08-30

### Added
- Add new field helpdesk_email in the service model (@goreck888)
- Services sort by their status in the backoffice (@goreck888)

### Changed
- Move project create logic from controller to service (@mkasztelnik)
- Reuse `Project::Authorize`concern in project related controllers (@mkasztelnik)
- Project services (`ProjectItem`) id changed to project scoped (@mkasztelnik)
- Rename corporate_sla_url field to sla_url in services (@goreck888)
- Use project details partial on service order configuration step (@mkasztelnik)
- Apply a new view and functionalities of the start page (@jarekzet, @goreck888)
- Rename buttons for creating new platforms, providers and categories in the backoffice (@goreck888)
- Disabled css animations in the test environment (@goreck888)

### Removed
- Affiliation model removed (@mkasztelnik)
- Remove terms_of_use field from the service model and forms (@goreck888)

### Fixed
- Display choices.js in the owners multiselect field in the new service form (@goreck888)
- Styling in the e-mails field in the new service form (@goreck888)
- Typo in archive project flash type fixed (@mkasztelnik)
- Uniqueness of names in the platforms, categories, providers and research areas (@goreck888)
- Email validation in contact_emails field (@goreck888)

## [2.0.1] 2019-08-13

### Fixed
- Showing only published services at the homepage

## [2.0.0] 2019-08-06

### Added
- Service owner can edit service draft and service offer drafts (@mkasztelnik)
- Task for importing service data from eIC (@michal-szostak)
- Selective import of services from eIC based on ID (@michal-szostak)
- Auto select project when adding service to project from project view (@mkasztelnik)

### Changed
- Country of customer and country of collaboration fields (@goreck888)
- Country fields transfer to jira issues (@goreck888)
- Create project copy (@mkasztelnik)
- Conversation to project (@martaswiatkowska)
- Project item view is split into details and conversation (@mkasztelnik)
- Refacotoring of ordering - split project details in fragments (@bwilk)
- Redirection to a service upon choice made by autocomplete in search bar (@bwilk)
- Reimplemented filters and categories after creating indexes in Elasticsearch (@bwilk)
- Expand all projects on projects index view (@mkasztelnik)
- Improvements for project box views (@mkasztelnik)
- Project card redesigned (@mkasztelnik)
- Move ResearchArea association from project item to the project
- Content of mail templates by voucher accept (@goreck888)
- Reimplemented sending messages to providers (@martaswiatkowska)

### Removed
- Project filter removed from projects index view (@mkasztelnik)
- Affiliations were removed from all views (@mkasztelnik)

### Fixed
- Fixed showing projects with empty countries of partnerhip list (@bwilk)
- Wrong redirection after logging in while browsing the portal (@bwilk)
- Disabled possibility to add offers in drafts (@goreck888)
- Vulnerabilities alerts (@martaswiatkowska)
- Project migration task when JIRA issues has been deleted (@michal-szostak)

## [1.12.0] 2019-06-17

### Added
- Clear search button in the search bar (@bwilk, @abacz)

### Changed
- Redirection to a service upon choice made by autocomplete in search bar (@bwilk)
- Reimplemented filters and categories after creating indexes in Elasticsearch (@bwilk)

### Fixed
- Blocked access to the draft service via direct link
- Category and filter counters (@bwilk)
- Hierarchical filters deactivation buttons (@bwilk)
- Choice of "best match" sorting strategy after search (@bwilk)
- Maintaining sort order when filters are applied (@bwilk)
- Redirection to project edit view on project creation failure while ordering (@bwilk)

## [1.11.1] 2019-06-05

### Fixed
- fixed button dismiss action

## [1.11.0] 2019-06-04

### Added
- Cookie policies consent popup (@mkasztelnik)
- Project details view (@martaswiatkowska)
- Master / sub issue jira integration
- jira master / sub issue migration rake task

### Changed
- Improve empty project description (@mkasztelnik)
- Improve collapse / expand all behaviour for filters (@michal-szostak)
- Move additional_information from project_item to project (@martaswiatkowska)

### Removed
- Remove rating filter from the view until we have enough ratings to show it (@mkasztelnik)
- Remove default project creation (@mkasztelnik)
- Remove duplicated project fields from project-item (@martaswiatkowska)

### Fixed
- Don't add `+` instead of space to query value during filtering (@mkasztelnik)
- Showing draft services on search in backoffice (@martaswiatkowska)
- Validation logo format (@martaswiatkowska)

## [1.10.0] 2019-05-13

### Added
- Added tagline to elasticsearch index (@martaswiatkowska)

### Changed
- Research area filter changed to hierarchical and multi-select (@mkasztelnik)
- Rename `ServiceCategory` model to `Categorization` (@mkasztelnik)
- Autocomplete routing (@martaswiatkowska)
- Fields weights in elasticearch (@martaswiatkowska)

### Fixed
- Unescape query string while showing it to the user (@mkasztelnik)
- Multiplication of parameter q in autocomplete url(@martaswiatkowska)

## [1.9.0] - 2019-05-06

### Added
- Tracking code for Hotjar (@abacz)

## [1.8.1]- 2019-04-26

### Fixed
- Don't close already opened filter in test (@mkasztelnik)
- Don't duplicate results when service belongs to e.g. 2 selected in filter
  providers (@mkasztelnik)

## [1.8.0] - 2019-04-18

### Added
- search autocomplete (@martaswiatkowska)
- Highlights on main search (@martaswiatkowska)
- "collapse all" for service filters (@goreck888)
- "looking for" header in search (@goreck888)
- Controller for active filters (@goreck888)
- Counter in services view (@goreck888)

### Changed
- ruby and js dependencies upgraded (@mkasztelnik)
- Project item attributes refactored (@mkasztelnik)
- Fix reset services page after change number of items and after category change(@goreck888)
- `SO-1` jira field changed from url to json (@mkasztelnik)
- `rubocop-rails` gem was renamed to `rubocop-rails_config` (@mkasztelnik)
- Site width 1180px
- Shadow box for service header
- Yellow bullets and arrows in sidebar lists
- All services link moved above the category list
- Autocomplete content are serve only from ajax request (@martaswiatkowska)
- View of services navigation bar (@goreck888)

### Fixed
- Link to all services should contain filter params (@mkasztelnik)
- Use searchkick reindex in setup instead of elasticsearch import (@martaswiatkowska)
- Show 404 error page when affiliation is not found (@mkasztelnik)
- Use custom error pages with webpage layout in production environment (@mkasztelnik)
- Fix bug with JIRA issue creation (attribute mapping to SO-1) (@michal-szostak)
- Remove std out/err logs from test suite output (@mkasztelnik)
- Fix show opinions for open access services (@mkasztelnik)
- Fix authorising affiliation from user affiliations, not affiliations at all (@goreck888)


## [1.7.0] - 2019-04-01

### Added
- Link to the tutorial of creating attributes in backoffice (@goreck888)
- External ID input to backoffice provider's form (@michal-szostak)
- External import task (@michal-szostak)
- Initial implementation of usage Searchkik (@martaswiatkowska)

### Changed
- Filters refactored and moved into `Service::Filterable` concern (@mkasztelnik)
- Filters cleared when user type new query (@mkasztelnik)
- Filters not cleared when changing category (@mkasztelnik)
- Button styling in backoffice provider form (@michal-szostak)

### Removed
- Remove terms and conditions from service order confirmation view (@mkasztelnik)

### Fixed
- Show accept terms of use only when terms are given for the service (@mkasztelnik)

## [1.6.0] - 2019-03-18

### Added
- OfferType field in jira (@martaswiatkowska)

### Changed
- Improvements in backoffice service form (@martaswiatkowska)

### Removed
- Remove unused `orders` and `order_changes` tables from `db/schema.rb` (@mkasztelnik)

### Fixed
- service creation bug (@martaswiatkowska)
- integer and range validation bug (@michal-szostak / @martaswiatkowska)

## [1.5.1] - 2019-03-15


### Fixed
- Fix infinitive loop while updating main service category (@mkasztelnik)

### Security
- Rails upgraded with fixes for: CVE-2019-5418, CVE-2019-5419 and CVE-2019-5420 (@mkasztelnik)

## [1.5.0] - 2019-03-06

### Added
- Offer status (@martaswiatkowska)
- markdown rendering in offer's description (@goreck888)
- Offers parameters in backoffice - initial (@martaswiatkowska)
- Order Target field to Service (@michal-szostak)
- Passing of Order Target field to JIRA (field `SO-ServiceOrderTarget`) (@michal-szostak)

### Fixed
- Date and time display in order history

## [1.4.1] - 2019-02-28

### Fixed
- Small view error in my order detail page

## [1.4.0] - 2019-02-26

### Added
- voucher_id in aod_voucher_accepted email (@kmarszalek)
- voucher_id updates from jira (@michal-szostak)
- `elasticsearch` version added to `.tool-versions` file (@mkasztelnik)
- Offer type (`normal`, `open_access`, `catalog`) with service type taken as
  default (@mkasztelnik)
- Offer can be selected from `service#show` (@mkasztelnik)
- Date attribute `min` and `max` validation (@mkasztelnik)
- voucher_id display in project items's details (@michal-szostak)
- Add `Attribute::QuantityPrice` (@mkasztelnik)

### Changed
- Change service phase values into keys (@mkasztelnik)
- Change names of buttons and headers (@goreck888)
- Changes in aod_voucher_accepted mails and new mail sended after rejection (@martaswiatkowska)
- Change styles for project item details (@jarekzet)

## [1.3.0] - 2019-02-11

### Added
- Searchable backoffice services index view (@mkasztelnik)
- Hint to url inputs in service edit view (@kmarszalek)

### Changed
- Offers displaying on backoffice and portal view (@martaswiatkowska)
- Height of the textarea in the ofers form (@martaswiatkowska)
- Phase to select on service edit view (@kmarszalek)
- Phase to enum in Service model (@kmarszalek)

## [1.2.1] - 2019-01-30

### Added
- "about Marketplace" static page (@goreck888)

### Changed
- External Sources EID type has been changed to string (@michal-szostak)

### Fixed
- ProjectItem details view crash for open access services (@michal-szostak)
- Order mailing (@michal-szostak)

## [1.2.0] - 2019-01-29

### Added
- User needs to select "Research area" while ordering service (@mkasztelnik)
- Add voucher support in service ordering (@michal-szostak)
- Basic CRUD for backoffice Research areas (@mkasztelnik)
- Basic CRUD for backoffice Categories (@mkasztelnik)
- New custom fields for voucher in jira (@martaswiatkowska)
- Basic CRUD for backoffice Providers (@mkasztelnik)
- Basic CRUD for backoffice Platforms (@mkasztelnik)
- Voucher styling (@jarekzet)
- Vouchers emails (@martaswiatkowska)
- External Sources information for services (@michal-szostak)

### Fixed
- RWD for offer selection (@jarekzet)
- Show `*` near order research area field, show errors when research area is not
  selected (@mkasztelnik)
- Remove shell command invocation in one of the test (@mkasztelnik)

## [1.1.0] - 2019-01-18

### Added
- Breadcrumbs for Admin and Back office sections (@mkasztelnik)
- Add `service_portfolio_manager` role (@mkasztelnik)
- Possibility of adding offers to the services (@martaswiatkowska)
- `SO-ProjectName` to issue created in JIRA (@michal-szostak)
- Active filter list & remove in filter sidebar (@michal-szostak)
- Status to service (@martaswiatkowska)
- Add JIRA mapping for `CP-UserGroupName` and `CP-ProjectInformation` (@michal-szostak)

### Changed
- Unify Back office and Admin layout navbars (@mkasztelnik)
- Service can have many owners, owners can see but not modify owned services (@mkasztelnik)
- Category counter cache takes into account service status (@mkasztelnik)

### Fixed
- Corrected typos in terms and conditions hint (@mkasztelnik)


## [1.0.0] - 2018-12-20

### Added
- Basic application structure and configuration (@mkasztelnik)
- Service model, simple index and show pages integrated with elasticsearch (@mkasztelnik)
- Initialization of elastic search indexes on application setup (@michal-szostak)
- Sentry integration (@mkasztelnik)
- Profile page with basic info and unauthenticated user redirection (@martaswiatkowska @jswk)
- Pundit for user authorization (@mkasztelnik)
- ENV variables to configure checkin URLs and root application URL (@mkasztelnik)
- Custom git hooks for checking code syntax via RuboCop and commit message formatting (@michal-szostak)
- Custom git commit message template (@michal-szostak)
- Redirect user into `/` after checkin login failure (@mkasztelnik)
- Service categories (@mkasztelnik)
- Service order possibility (@mkasztelnik)
- Configure `database_cleaner` for rspec (@mkasztelnik)
- Service terms of use with markdown renderer (@mkasztelnik)
- Send email to order owner when order is created or updated (@mkasztelnik)
- User can ask about processed order (@mkasztelnik)
- Create first draft Ui layout (@kosmidma)
- Playground for designing views (@mkasztelnik)
- Bootstrap 4 style for will_paginate (@mkasztelnik)
- Possibility to configure development DB using ENV variables (@mkasztelnik)
- Possibility to configure elasticsearch URL using ENV variable (@wziajka)
- Bootstrap JS and font awesome regular (@michal-szostak)
- Service tagline (@martaswiatkowska)
- Transfer tabs from playground to services(@kosmidma)
- Add styling for services, improve global styles (@kosmidma)
- User affiliations (@mkasztelnik)
- Service and categories database seed (@bwilk)
- Conditional software version placeholder in frontend (@bwilk)
- Service owner can manage owned services (@mkasztelnik)
- Add rating for Service (@kmarszalek)
- Add JIRA integration (marketplace to jira) (@michal-szostak)
- Add open access services (#martaswiatkowska)
- Add HAML validation to overcommit via `haml-lint` (@michal-szostak)
- Add SCSS validation to overcommit via `scss-lint` (@michal-szostak)
- Jira webhook integration (@michal-szostak)
- Add footer at the bottom of the page (@kosmidma)
- Add styling for user's profile (@kosmidma)
- Add and styling static elements to sidebar (@kosmidma)
- Update service view (@kosmidma)
- Styling My Services view (@kosmidma)
- Styling Order Placement view (@kosmidma)
- Add dotenv gem (@michal-szostak)
- Change checkin service (@wziajka)
- Add filling database with services, categories and relations between them in seeds.rb (@goreck888)
- Styling Order Details view (@kosmidma)
- Create ticket in JIRA by open service order with adequate status "Done" (@goreck888)
- Added providers link (@martaswiatkowska)
- Styling Home view (@kosmidma)
- Corrections My Profile view (@kosmidma)
- Service opinion form and active job that send email to user about rating service 5 days after order is ready (@kmarszalek)
- Sort services via selection of options in select box (@michal-szostak)
- Store Jira internal id in order change (@mkasztelnik)
- Create new order change when Jira comment is posted (@mkasztelnik)
- Show number of services in category (@mkasztelnik)
- Possibility to define checkin identifier and secret using env variables (@mkasztelnik)
- Add breadcrumbs to order index and show (@mkasztelnik)
- Tabs to My profile view (@kmarszalek)
- 3 steps ordering (@mkasztelnik)
- New header & footer look (@kosmidma)
- Show 10, 20 or 30 services per page (@mkasztelnik)
- Go to order configuration step directly when there is only one offer (@mkasztelnik)
- Autoselect default project to open access service order and go directly to summary page (@mkasztelnik)
- Cannot order service when there is not offers (@mkasztelnik)
- Related services (@mkasztelnik)
- Service activate message (@mkasztelnik)
- Order steps layout (@mkasztelnik)
- Sidekiq for delayed jobs (@mkasztelnik)
- Admin administration panel stub with sidekiq monitoring and MP version (@mkasztelnik)
- Render root categories in page footer (@mkasztelnik)
- Use bootstrap cards to show service offers (@mkasztelnik)
- Add service logo (@mkasztelnik)
- Select affiliation on service order configuration page (@mkasztelnik)
- Styling of the 3rd step of the ordering process (@jswk)
- Add main navbar content and style it as in EOSC Portal (@jswk)
- Add real providers and missing entries in services in data.yml(@goreck888)
- Add known services relations in db/data.yml(@goreck888)
- Add filtering option to services (@michal-szostak)
- Optional additional information on configuration step (@martaswiatkowska)
- Research areas to service (@martaswiatkowska)
- Extend filtering for "dedicated for" field (@michal-szostak)
- Add sidekiq yaml configuration file (@wziajka)
- Add smtp configuration (@wziajka)
- Create new project on order configuration page (@mkasztelnik)
- Show alert for logged in user when there is not active affiliation (@mkasztelnik)
- Style ordered service view and remove mocked data (@mkasztelnik)
- Add logos to the services (@goreck888)
- User need to accept terms and conditions to order service (@mkasztelnik)
- Add new relic rpm (@mkasztelnik)
- Category hierarchical services count (@mkasztelnik)
- Show validation error when project is not selected for ordered service (@mkasztelnik)
- filter by status on my serices view (@martaswiatkowska)
- Simple form checks validation if conditions (@mkasztelnik)
- Clickable next order nav step (@mkasztelnik)
- Affiliation last step - consent (@martaswiatkowska)
- Multicheckbox widget to filters (providers & dedicated for) (@michal-szostak)
- Category tree in sidebar (@michal-szostak)
- Global filters to category view (@michal-szostak)
- Add offers to the services (@goreck888)
- Google analytics integration (@mkasztelnik)
- Friendly urls for categories and services (@mkasztelnik)
- Category select box to text searchbar (@michal-szostak)
- Fill order fields using predefined project fields (@mkasztelnik, @martaswiatkowska)
- Show offers sections only when there is more than 1 offer (@mkasztelnik)
- Dedicated ordering process for open access services (@mkasztelnik)
- Email signature and layout (@mkasztelnik, @abacz)
- Related Infrastructures and Platforms to filter section of services list (@martaswiatkowska)
- Related Infrastructures and Platforms to service details view (@kmarszalek)
- Technical parameters display in service offers (@michal-szostak)
- Add "All Services" link with services count above categories navigation in sidebar (@michal-szostak)
- Show "Go to the service" for catalog service (@mkasztelnik)
- Show affiliation info for project item (@jswk)
- Add a landing page for when affiliation is activated (@jswk)
- Favicon (@michal-szostak)
- Research area hierarchy (@mkasztelnik)
- Redirect user from `/affiliations` to `/profile` (@mkasztelnik)
- Service tags (@mkasztelnik)
- Customizable from email (@mkasztelnik)
- Flash fade out after 5 seconds (@mkasztelnik)
- Add new supported JIRA states (rejected, waiting for response) (@michal-szostak)
- ASSET_HOST and ASSET_PROTOCOL for mailer config (@kmarszalek)
- Additional field mapping to JIRA order (@michal-szostak)
- Possibility to setup RATE_AFTER_PERIOD ENV variable (@kmarszalek)
- Category field on create service view (@martaswiatkowska)
- Additional customer typologies fields for project_item and project (@martaswiatkowska)

### Changed
- Upgrade Sprockets gem to avoid CVE-2018-3760 vulnerability (@mkasztelnik)
- Fix and refactor seeds.rb to work properly (@goreck888)
- Update services and category list in data.yml (@goreck888)
- Update home view with static version (@kmarszalek)
- Upgrade service detail view (@kmarszalek)
- Rename `Order` to `ProjectItem` (@mkasztelnik)
- Rename `OrderChange` to `ProjectItemChange` (@mkasztelnik)
- Split backend for Service details view (@kmarszalek)
- Bootstrap improvements towards compliance with the guidelines (@jswk)
- Improve styling of affiliation list in profile and project list (@jswk)
- Deny to destroy an affiliation which is associated with a project item (@jswk)
- Styling of filters (@michal-szostak)
- Styling of ordering steps (@jarekzet, @michal-szostak)
- Remove description under "Services" header in services, add category description in categories (@michal-szostak)
- Reorder form parts in order/configuration (@michal-szostak)
- On project item view show order history in reversed order (@martaswiatkowska)
- Hide service offers on service about page if no offers are available (@michal-szostak)
- Rename "Some Header" in services' about page to "Documents" (@michal-szostak)
- Hide TODO Technical Parameters from service offer selection (@michal-szostak)
- Fields on Service entry to not be required (@kmarszalek)
- Link to webpage on project_item view (#martaswiatkowska)
- Url of terms and condition hint are taken from service.term_of_use_url (@martaswiatkowska)
- Platforms are not mandatory (@martaswiatkowska)
- Base URL for footer link updated to `https://eosc-portal.eu` (@mkasztelnik)
- Changed VO to Research groups in filters UI (@michal-szostak)
- Unify confirmation views - order, new affiliation, affiliation confirmations (@mkasztelnik)
- Improve wording of service, affiliation and project item mails (@jswk)
- Replace dedicated_for with target_group (@martaswiatkowska)
- Rating to three field form service_rating, order_rating and opinion (@kmarszalek)

### Deprecated

### Removed
- Remove default devise session routes, only logout remain (@mkasztelnik)

### Fixed
- Correctly expand affiliation accordions in profile (@jswk)
- Insert a line-break after button(s) in service header right panel (@jswk)
- Search by text from any view (@michal-szostak)
- Search does not preserve `page` query param (@michal-szostak)
- Multicheckbox does not take into account selected category when calculating available services (@michal-szostak)
- Change default sort order for services to name ascending (@michal-szostak)
- Open access services transition to "Done" state (@michal-szostak)
- Affiliations UI on small screens (@jarekzet)
- Support for Select type custom fields in JIRA (`CP-CustomerTypology`) (@michal-szostak)
- Input for tag_list for Service form in backoffice (@kmarszalek)

### Security

# Fridgeo iOS Client
Source code of the published iOS app Fridgeo, powered by NodeJS backend and MongoDB.

(for security reason, the original repo is set to private)

Followed MVC pattern.
No storyboard used (100% pure code).

View:
1. All UI views can be found under View directory and all properties of views can be found under View/Property, in order to be easy to manage.
2. Views are reusable and extendable.

Model:
1. For multiple UICollectionViews using IGListKit.

Controller:
1. Load views.
2. Handle user actions.

Helper:
1. DatabaseController: Handle sync/async HTTP requests/responses based on user needs.
2. Extension of standard library for further use.

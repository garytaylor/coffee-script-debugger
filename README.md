coffee-script-debugger
======================

This gem is used in a rails 3.2+ environment with coffeescript 1.6.1+
It will produce a source map file suitable for use by browsers (only tested with chrome at the moment)
The browser can then see and debug your coffeescript files just like normal javascript file.

Note that this is only intended for your development environment as it puts the raw files in public/assets - this includes any files that have erb
in them, so you have been warned.



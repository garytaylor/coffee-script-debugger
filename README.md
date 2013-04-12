#coffee-script-debugger


This gem is used in a rails 3.2+ environment with coffeescript 1.6.1+
It will produce a source map file suitable for use by browsers (only tested with chrome at the moment)
The browser can then see and debug your coffeescript files just like normal javascript files.
##Rubymine / Jetbrains Support
It also works with the Rubymine plugin.  In order to use it in this environment, follow the instructions in this article, but ignore step 1 and replace it with the installation instructions below

http://confluence.jetbrains.com/display/RUBYDEV/Debugging+CoffeeScript+Code

##Important
Note that this is only intended for your development environment as it puts the raw files in public/assets - this includes any files that have erb
in them, so you have been warned.

##Credits
Credit where credit is due, this is based on the 'coffee-script-redux-debugger' from https://github.com/avokin/coffee-script-redux-debugger.git
##Installation

Add the following to your gemfile or simply add the gem line to your existing development group
`
group :development do
    gem "coffee-script-debugger", :git => "https://github.com/garytaylor/coffee-script-debugger"
end
`

Then, tell your version control to ignore anything that is written to public/assets - a .map file is written there for each coffeescript
file that is compiled




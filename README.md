# Sumologic Cookbook

This is an alpha release of the Sumologic cookbook I developed for internal use. It currently has all the binaries included in this cookbook and ONLY works on 64bit platforms. 

To get started simply:
* Edit the templates/sources.erb with the path to your log files
* Edit the templates/wrapper.conf.erb with your Sumologic account information
* My organization uses <%= node.hostname %> for the hostname, you'll want to make sure you have this attribute or change appropriately.

# Contributing

Future improvements include:
* Downloading the newest (or specified) release
* Detecting the platform and using the right binaries

I welcome any pull requests to improve this cookbook, 

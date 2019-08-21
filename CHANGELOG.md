# Changelog

## Release 1.0.10

Thanks to Kevin Reeuwijk for multiple bug fixes:

* A hardcoded domain DN of DC=example,DC=com, caused an error if the domain had any other name. PR makes the domain DN dynamic by parsing the output of dsquery server
* Rubocop fixes
* Use Ruby 2.3.0 for checks

**Features**

**Bugfixes**

**Known Issues**

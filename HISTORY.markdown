Next
====

* added --commits=COUNT, max number of commits to display
* added support for pre-deploy commands with `git config --add remote.name.predeploy 'command'`
* displaying remote name and pre-deploy command on the web interface
* displaying last error with failures

0.3.0
=====

* initial public release

0.3.3
=====

* Solved can't avoid specifying predeploy command.

0.3.4
=====
* Change a .blank? for an .empty?

0.4.0
=====
* New Design
* Add Pagination
* Add --commits-per-page option
* Remove --commits option

0.4.1
=====
* Add feedback while bartender is deploying

0.5.0
=====
* Bartender now can copy the repository to a temporal directory to move to an specific version of the code to run the predeploy command

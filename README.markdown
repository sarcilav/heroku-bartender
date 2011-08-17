# Heroku Bartender
Is a simple way to manage releases in heroku

# How to bartender
## Install
        gem install heroku-bartender
## Run
        heroku-bartender
## Options
Server options:

		-h, --host=HOST              The hostname or ip of the host to bind to (default 0.0.0.0)
		-p, --port=PORT              The port to listen on (default 4567)
		-t, --target=TARGET          The target is the git remote in which you want to deploy (default heroku)
		--user=USER                  The user to login using HTTP Basic Auth
		--password=PASSWORD          The password to login using HTTP Basic Auth
		--commits-per-page           The maximun number of commits that you want to see in each page

For now you must run `heroku-bartender` inside your repo dir

## Specifying a Pre-Deploy Command

You can specify a command to run before deployment.

    git config --add remote.master.predeploy "rake test"


# Features
1. You can rollback your heroku app to a specific commit hash
2. You can secure your heroku-bartender server using HTTP Basic Auth
3. You can use a custom heroku remote target to deploy your app
4. Shows red/yellow/green status for deploys (red: fail, green: ok, yellow: unknow problem)
5. Shows dates for deployed versions
6. Shows colors/status for old deployed versions (only the versions that are deployed from the start)
7. Sandbox your code with the specific version when you need to run predeploy commands

# TODO
1. Keep the repo up-to-date
2. Handle branches/tags
3. DB Rollback
4. Async build
5. Integration with CI servers

# Screenshots

![Successful](http://f.cl.ly/items/1U1S2b45161H3x3N1V2z/Screen%20shot%202011-08-17%20at%2011.43.48%20AM.png)

## Waiting the predeploy command
![Predeploying](http://f.cl.ly/items/2t2I3v3b0A0v0Y413f3Q/Screen%20shot%202011-08-17%20at%2011.44.48%20AM.png)

# Special Thanks go out to:
* [Art.sy](http://art.sy/) for let me use 'office' hours to work in this project
* [@abuiles](https://github.com/abuiles) for the super-cool-name 
* [@febuiles](https://github.com/febuiles) for the design

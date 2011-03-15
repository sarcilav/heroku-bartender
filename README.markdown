# Heroku Bartender
Is a simple way to manage releases in heroku

# How to bartender
## Install
        gem install heroku-bartender
## Run
        heroku-bartender
## Options
Server options:
    -h, --host=HOST                  The hostname or ip of the host to bind to (default 0.0.0.0)
    -p, --port=PORT                  The port to listen on (default 4567)
    -t, --target=TARGET              The target is the git remote in which you want to deploy (default heroku)
        --user=USER                  The user to login using HTTP Basic Auth
        --password=PASSWORD          The password to login using HTTP Basic Auth


For now you must run `heroku-bartender` inside your repo dir
# Features
1. You can rollback your heroku app to a specific commit hash
2. You can secure your heroku-bartender server using HTTP Basic Auth
3. You can use a custom heroku remote target to deploy your app
4. Shows red/yellow/green status for deploys (red: fail, green: ok, yellow: unknow problem)
5. Shows dates for deployed versions
6. Shows colors/status for old deployed versions (only the versions that are deployed from the start)

# TODO
1. Keep update the repo
2. Handle branches/tags
3. DB Rollback
4. Styling view
5. Async build
6. Integration with CI servers

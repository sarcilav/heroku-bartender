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

For now you must run `heroku-bartender` inside your repo dir
# Feature
You can rollback your heroku app to a specific commit hash

# TODO
1. Keep update the repo
2. Handle branches/tags
3. DB Rollback
4. Styling view
5. Async build
6. Integration with CI servers

# Docker Files - DMOJ
This is a branch with the docker files for running the
[DMOJ](https://github.com/DMOJ/online-judge) frontend. You can view a running
instance [here](https://judge.theavid.dev). Keep in mind that it may be
occasionnaly unavailable during development. It runs the following containers:
 * `nginx` - the nginx web server for serving the websites and static files.
 * `dmoj` - the dmoj site (`online-judge`) acting as the frontend for judges.
 * `dmojdb` - dmoj database.
 * `bridge` - the bridge to connect the dmoj frontend site with judges.
 * `websocket` - websocket for live updates on the site.
 * `celery` - celery scheduler image.
 * `redis` - dependancy for celery handling data storage.
 * `mathoid` - wikimedia mathoid rendering.
 * `texoid` - latex rendering.
 
 **IMPORANT:** this branch does not contain a DMOJ
 [`judge-server`](https://github.com/DMOJ/judge-server), only the frontend
 website. For judges, please see
 [their documentation](https://docs.dmoj.ca/#/judge/linux_installation) and
 connect them to port `9999` which the `bridge` container exposes.
 
## Installation
#### Global:
Clone this branch and pull submodule repositories:
```sh
git clone -b dmoj https://github.com/TheAvidDev/docker-files.git
cd docker-files
git submodule update --init --recursive
```

Move config files into proper folders:
```
mv config.js repo/websocket/
mv uwsgi.ini repo/
mv local_settings.py repo/dmoj/
```

#### Website secrets:
Define the Django secret keys and database passwords in `docker-compose.yml`.
This means changing the `environment` sections from:
```py
MYSQL_DATABASE: 'dmojdb'
MYSQL_USER: 'dmoj'
MYSQL_PASSWORD: 'DATABASE DMOJ PASSWORD'
MYSQL_ROOT_PASSWORD: 'DATABASE ROOT PASSWORD'
SECRET_KEY: 'DJANGO SECRET KEY'
HOST: 'WEBSITE HOSTNAME'
DEBUG: 0
```

The `MYSQL_DATABASE`, `MYSQL_USER`, and `DEBUG` can be left alone. Change the
latter to `1` for Django testing. Set `HOST` to your hostname, such as
`judge.theavid.dev`. `MYSQL_PASSWORD` is the password for the databse which
images will use. While the database is only accessible locally, it's still a
good idea to make a good password. The `MYSQL_ROOT_PASSWORD` is unused within
DMOJ but is required for mariadb. Finally, `SECRET_KEY` is the Djano secret key.
It is vital that it is kept secure.

#### Final docker isntallation:
Run `./scripts/install.sh` to build the docker images and dmoj database. This
will migrate all necessary migrations and build static files. Keep in mind, you
may have to run this twice as the `dmojdb` container takes some time to
initalize.

## Maintaining
To run everything, use the following in the clone folder:
```
docker-compose up -d
```

To update migrations, run:
```
./scripts/migrate.sh
```

To compile and collect static files, run:
```
./scripts/makestatic.sh
```

#### Update Procedure
The probable update procedure would be to pull the repo and then run either the
migrate script (if a migration was added) and/or the static compilation and
collection script (if static files were updated).

It may also be necessary to update (rebuild) the images if, for example, python
requirements have changed. This can be done by building the docker images
without using the docker cache.
```
docker-compose build --no-cache
```

Keep in mind that the containers running said images will have to be turned off
(either killed with `docker kill` or brought down `docker-compose down`).

## Nginx Configuration
This image exposes an nginx webserver on port `81`. You should install another
nginx webserver on the host (or a separate container) that proxies connections
to this one. An example configuration for that nginx instance would look as
such:
```nginx
server {
    # Remove the two lines below to only allow ssl connections.
    # If you do this, you should uncomment, and update, the final ssl section.
    listen 80;
    listen [::]:80;
    server_name judge.theavid.dev;

    add_header X-UA-Compatible "IE=Edge,chrome=1";
    add_header X-Content-Type-Options nosniff;
    add_header X-XSS-Protection "1; mode=block";

    location / {
        proxy_http_version 1.1;
        proxy_buffering off;
        proxy_set_header Host $http_host;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;

        proxy_pass http://127.0.0.1:81/;
    }

    # For ssl connections, uncomment and update the following.
    #listen 443 ssl;
    #ssl_certificate /etc/letsencrypt/live/example.com/fullchain.pem;
    #ssl_certificate_key /etc/letsencrypt/live/example.com/privkey.pem;
    #include /etc/letsencrypt/options-ssl-nginx.conf;
    #ssl_dhparam /etc/letsencrypt/ssl-dhparams.pem;
}
```
You can modify on which port nginx runs or exposes itself on by either
modifying the `ports:` directive of the `docker-compose.yml` file and/or
by changing the nginx config in `/nginx/conf.d/default.conf`.

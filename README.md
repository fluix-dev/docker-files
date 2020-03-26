# Docker Files - Website
This is a branch with the docker files to host [my site](https://theavid.dev) along with [my judge](https://judge.theavid.dev) ([DMOJ](https://github.com/DMOJ/online-judge) clone). It runs the following containers:
 * `nginx` - the nginx web server for serving the websites and static files.
 * `dmoj` - the dmoj site (`online-judge`) acting as the frontend for judges.
 * `bridge` - the bridge to connect the dmoj frontend site with judges.
 * `websocket` - websocket for live updates on the site.
 * `site` - personal website with portfolio, about section, and contact form.
 * `dmojdb` - dmoj database.
 * `sitedb` - personal website database.
 * `phantomjs` - phantomjs image to generate pdf versions of dmoj site problems.
 * `certbot` - a certbot image for creating certificates.
 
## Installation
#### Global:
Clone this branch with:
```
git clone -b website https://github.com/TheAvidDev/docker-files.git
```

#### Website secrets:
Add Dango secret keys to `local_settings.py` in `site/` and `dmoj/`. This is done by setting the `SECRET_KEY` variable.

Set the postgres password by setting the `PASSWORD` field in `site/local_settings.py` and `POSTGRES_PASSWORD` in `docker-compose.yml`.

Set the MariaDB root password in `docker-compose.yml` by modifying the `MYSQL_ROOT_PASSWORD` environment variable.

Set the MariaDB dmoj password by setting the `PASSWORD` field in `dmoj/local_settings.py` and `MYSQL_PASSWORD` field in `docker-compose.yml`.

#### Nginx ssl conf:
You can follow the tutorial in [this article](https://medium.com/@pentacent/nginx-and-lets-encrypt-with-docker-in-less-than-5-minutes-b4b8a60d3a71). Keep in mind that the docker portions are already completed, so only the certificate generation is required. This final step is described below:

Make a `certbot` folder with:
```
mkdir certbot
```

Download the [`init-letsencrypt.sh`](https://raw.githubusercontent.com/wmnnd/nginx-certbot/master/init-letsencrypt.sh) script with:

```
curl -L https://raw.githubusercontent.com/wmnnd/nginx-certbot/master/init-letsencrypt.sh > init-letsencrypt.sh
```

Edit the script (with something like `nano`) and change the `domains=(example.org www.example.org)` line to your domains. Also change `data_path="./data/certbot"` to `data_path="./certbot"`.

Make the script executable and run it:
```
chmod +x init-letsencrypt.sh; sudo ./init-letsencrypt.sh
```

#### Final docker isntallation:
Run `./scripts/install.sh` to build the docker images and dmoj database.

Migrate the `site` database with:
```
docker-compose run --rm --entrypoint "python manage.py migrate --settings=mysite.local_settings" site
```

## Running
Start these services with:
```
docker-compose up -d
```

## Maintaining
To update everything, run `./scripts/update.sh`. This will also remake resources and static files for `dmoj`.

To update specific images, run `docker-compose build --no-cache [name]`.

# docker-compose-laravel
A pretty simplified Docker Compose workflow that sets up a LEMP network of containers for local Laravel development. You can view the full article that inspired this repo [here](https://dev.to/aschmelyun/the-beauty-of-docker-for-local-laravel-development-13c0).


## Usage

To get started, make sure you have [Docker installed](https://docs.docker.com/docker-for-mac/install/) on your system, and then clone this repository.

Next, navigate in your terminal to the directory you cloned this, and spin up the containers for the web server by running `docker-compose up -d --build site`.

After that completes, follow the steps from the [src/README.md](src/README.md) file to get your Laravel project added in (or create a new blank one).

Bringing up the Docker Compose network with `site` instead of just using `up`, ensures that only our site's containers are brought up at the start, instead of all of the command containers as well. The following are built for our web server, with their exposed ports detailed:

- **nginx** - `:8080`
- **nginx with ssl** - `:8443`
- **mysql** - `:3306`
- **php** - `:9000`
- **php xdebug** - `:9001`

Three additional containers are included that handle Composer, NPM, and Artisan commands *without* having to have these platforms installed on your local computer. Use the following command examples from your project root, modifying them to fit your particular use case.

- `docker-compose run --rm composer update`
- `docker-compose run --rm npm run dev`
- `docker-compose run --rm artisan migrate` 

## Persistent MySQL Storage

By default, whenever you bring down the Docker network, your MySQL data will be removed after the containers are destroyed. If you would like to have persistent data that remains after bringing containers down and back up, do the following:

1. Create a `mysql` folder in the project root, alongside the `nginx` and `src` folders.
2. Under the mysql service in your `docker-compose.yml` file, add the following lines:

```
volumes:
  - ./mysql:/var/lib/mysql
```

## Adjust package.json add a line. (maybe not necessary)

```
"scripts": {
   "preinstall":"cd $(pwd)"
}
```

## Store Git Password for vscode sync to git

Edit git.info then do the following command:

```
cat git.info | git credential-osxkeychain store
```

## Put your project source folder to ./src folder. Create file link into your project root path.

```
mkdir ./src/myproject
cd ./src/myproject
ln -s ../../run_artisan run_artisan
ln -s ../../run_composer run_composer
ln -s ../../run_npm run_npm
ln -s ../../run_yarn run_yarn
```

## Adjust nginx configure file, edit and copy below code to your default.conf file last line.

```
server {
    server_name myproject.local;
    listen 80;
    listen 443 ssl;
    ssl_certificate /var/www/html/myproject/sslcert.pem;
    ssl_certificate_key /var/www/html/myproject/sslprivkey.pem;
    root /var/www/html/myproject/public;
    
    include /etc/nginx/conf.d/inc/laravel.conf;
}
```

## Use HostAdmin App to edit host file

- MacOS path `/etc/hosts`
- Windows path `C:\windows\system32\drivers\etc\hosts`

add follow script at last line, then save.

```
127.0.0.1 myproject.local
```

follw up step, you can start your docker and browser http://myproject.local:8080
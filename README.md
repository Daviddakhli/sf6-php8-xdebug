
# Symfony 6 + PHP 8 + Mysql 8 + xdebug with Docker

## Run Locally

Clone the project

```bash
  git@github.com:kdakhli/sf6-php8-xdebug.git
```

Run the docker-compose

```bash
  docker-compose build
  docker-compose up -d
```

Log into the PHP container

```bash
  docker exec -it sf8-php8 bash
```

Create your Symfony application and launch the internal server

```bash
  symfony new new-project --full
  cd new-project
  symfony serve -d
```

Create an account (identical to your local session)

```bash
  adduser username
  chown username:username -R .
```

*Your application is available at http://127.0.0.1:9001*

# shis95/rainloop

### What is this ?

Rainloop is a simple, modern & fast web-based client. More details on the [official website](http://www.rainloop.net/).

### Features

- Lightweight & secure image (no root process)
- Based on Alpine
- Latest Rainloop **Community Edition** (stable)
- Contacts (DB) : sqlite, mysql or pgsql (server not built-in)
- With Nginx and PHP7
- Postfixadmin-change-password plugin

### Build-time variables

- **GPG_FINGERPRINT** : fingerprint of signing key

### Ports

- **8888**

### Environment variables

| Variable | Description | Type | Default value |
| -------- | ----------- | ---- | ------------- |
| **UID** | rainloop user id | *optional* | 100
| **GID** | rainloop group id | *optional* | 1000
| **UPLOAD_MAX_SIZE** | Attachment size limit | *optional* | 25M
| **LOG_TO_STDOUT** | Enable nginx and php error logs to stdout | *optional* | false
| **MEMORY_LIMIT** | PHP memory limit | *optional* | 128M

### Docker-compose.yml

```yml
# Full example :
# https://github.com/hardware/mailserver/blob/master/docker-compose.sample.yml

rainloop:
  image: shis95/rainloop
  container_name: rainloop
  volumes:
    - /mnt/docker/rainloop:/rainloop/data
```

#### How to setup

https://github.com/codestack-cc/rainloop

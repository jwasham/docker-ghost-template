# docker-ghost-template
Docker composition of Ghost blog with Node, NGINX proxy with SSL termination, database, etc.

## Software Used

**Docker** version 1.10.3

**docker-compose** version 1.6.2

## Before you start

0. Have your server's SSL certificate and key handy.
0. Be ready to point your domain to the new location (or put an entry in your hosts file for your domain)
0. Have an account with an email sending service (SMTP service) (Mailgun, Sendgrid, etc.). I'm using Mailgun, which is free for low volume.

## How to Use It

0. Clone project to your server's filesystem.
0. Edit environment settings in docker-compose.yml
    - blog domain
    - database settings
    - mail server settings
0. Add your SSL certificate and key to nginx/volumes/ssl/ (there are placeholders there)
0. Set the blog domain in nginx/copy/default.conf (must match the common name in your SSL certificate)
0. Run from within your Linux environment or Docker Toolbox environment: 
    0. docker-compose build
    0. docker-compose up -d  (you can remove the -d if you want to see logs, then Ctrl+C to stop all containers)
0. If using Docker Toolbox, look up the host IP address with: docker-machine ip default
0. On Linux, you'll just use "localhost" or "127.0.0.1".
0. Switch your domain's DNS to point to the address. Go to the domain in our browser and you'll see your new blog.
0. Go to https://YOUR_DOMAIN/admin to set up your blog.
0. Once you've made your admin account using that wizard, go back to: https://YOUR_DOMAIN/admin
0. Log in and enjoy.

## Ghost Content Directory

The directory ghost/volumes/content will be populated with 5 directories and a file the first time you start the container.

Ghost will create these directories:

- apps - for future use when ghost supports apps
- data - would normally hold a SQLite db, but won't for us since we're using MySQL
- images - for uploaded images, but will stay empty since we'll use S3 for storage
- storage - created in our Dockerfile for S3 image support
- themes - You can add more themes here. Default is Casper theme.
- index.js - It's a symlink. Don't edit or remove it.

## How to back up your database

0. Run "docker-compose ps" to get a list of running containers.
0. Locate the name of the mysql container.
0. Run this command to get the container's internal IP: docker inspect --format='{{.NetworkSettings.IPAddress}}' THAT_CONTAINER-NAME
0. In your favorite database GUI tool (like Navicat or DataGrip), create a new connection via SSH tunnel to the host machine
0. Use the internal IP address and database user and password to connect to database once SSH tunnel is established to host.
0. You'll have access to the data so you can view data and run backups.

## Theme

The default theme is Casper.  I have a minor fork of this theme here: https://github.com/jwasham/casper-startup-next-door

It includes Disqus support, so all you have to do is change the identifiers to your blog's Disqus ID and domain and you're good to go. See the README in that repo.

### To install another theme

Stop docker-compose with:

docker-compose stop

Copy the new theme to docker-ghost-template/ghost/volumes/content/themes/
so that your theme folder sits next to the casper folder in the themes directory

Now run:
docker-compose up -d

Log in to the Ghost admin, go to Settings > General, and at the bottom is the Theme dropdown. Select your theme and click Save.

### How does that work?

The ghost/volumes/content directory (on docker host machine) gets mounted inside your ghost container at /var/lib/ghost when the container runs. See the docker-compose.yml to see where this volume mount is happening.

## The Stack

- Node.js
    - Ghost blog software
    - Added Node module for supporting uploads to S3 so images are not saved to filesystem.
- NGINX
    - proxying port 80 calls to the Node web server on port 2368
- MySQL database
    - using UTFMB4 encoding (MySQL's UTF8 implementation was limited. UTFMB4 includes Emoji)

## Inherited Image Versions

- Ghost: 0.7.5
- NGINX: 1.9.9
- MySQL: 5.7.10

## Security

- Only NGINX's ports (80, 443) are exposed at host level.
- Other ports are available only from inside host and linked containers.

## MySQL memory

I'm running this on an EC2 t2.micro at 1GB RAM. I tried to limit MySQL's memory limit because it was taking up, what in my opinion, was too much.

Adding this to the mysql: block in docker-compose.yml will limit memory:
> mem_limit: 384m

I tried 256 and 384. Both caused issues with MySQL. Instead of continuing to experiment, or trying to tune MySQL in a container (no thanks), I just removed the limit.

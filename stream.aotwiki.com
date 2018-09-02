server {

    listen 80;
    listen [::]:80;

    server_name stream.aotwiki.com;

    root /var/www/stream.aotwiki.com/html;

    index index.php index.html;

    # Gzip file compression
    gzip on;
    gzip_disable "msie6";
    gzip_vary on;
    gzip_proxied any;
    gzip_comp_level 6;
    gzip_buffers 16 8k;
    gzip_http_version 1.1;
    gzip_types text/plain text/css application/json application/x-javascript text/xml application/xml application/xml+rss text/javascript;

    # Increase file size upload to 100 MB
    client_max_body_size 100M;

    # Exclude favicon and robots.txt from the logs
    location = /favicon.ico {
        log_not_found off;
        access_log off;
    }
    location = /robots.txt {
        log_not_found off;
        access_log off;
        allow all;
    }

    # Cache certain files and exclude them from logs too
    location ~* \.(css|gif|ico|jpeg|jpg|js|png)$ {
        expires max;
        log_not_found off;
    }

    # Error 404
    location / {
        try_files $uri $uri/ =404;
    }

    # Deny access to hidden and temporary files
    location ~ /\. {
        deny all;
    }
    location ~ ~$ {
        deny all;
    }

    # Pass the PHP scripts to FastCGI server
    location ~ \.php$ {
        include snippets/fastcgi-php.conf;
        fastcgi_pass unix:/run/php/php7.0-fpm.sock;
    }

}
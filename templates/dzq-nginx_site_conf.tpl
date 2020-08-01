server {
    listen 80;
    server_name {{domains}};
    root "{{project_dir}}/current/public";

    index index.php;

    charset utf-8;

    location / {
        try_files $uri $uri/ /index.php?$query_string;
    }

    location = /favicon.ico { access_log off; log_not_found off; }
    location = /robots.txt  { access_log off; log_not_found off; }

    access_log /var/log/nginx/{{project}}.log;
    error_log /var/log/nginx/{{project}}-error.log error;

    sendfile off;

    client_max_body_size 100m;

    gzip on;
    gzip_min_length 1024;
    gzip_types text/html text/css application/x-javascript application/vnd.api+json;
    gzip_disable "MSIE [1-6]\.";
    gzip_comp_level 2;

    location ~ \.php$ {
        fastcgi_split_path_info ^(.+\.php)(/.+)$;
        fastcgi_pass unix:/var/run/php/php7.4-fpm.sock;
        fastcgi_index index.php;
        include fastcgi_params;
        fastcgi_param SCRIPT_FILENAME $realpath_root$fastcgi_script_name;
        fastcgi_param DOCUMENT_ROOT $realpath_root;

        fastcgi_intercept_errors off;
        fastcgi_buffer_size 16k;
        fastcgi_buffers 4 16k;
        fastcgi_connect_timeout 300;
        fastcgi_send_timeout 300;
        fastcgi_read_timeout 300;
    }

    location ~ .*\.(gif|jpg|jpeg|png|bmp|swf)$ {
        expires      30d;
        error_log off;
        access_log /dev/null;
    }
    
    location ~ .*\.(js|css)?$ {
        expires      12h;
        error_log off;
        access_log /dev/null; 
    }

    location ~ /\.ht {
        deny all;
    }
}
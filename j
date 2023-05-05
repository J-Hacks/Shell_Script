<VirtualHost 192.168.0.217:8001>

        ServerAdmin findgood@localhost
        DocumentRoot /var/www/html/aakash
        ErrorLog ${APACHE_LOG_DIR}/error.log
        CustomLog ${APACHE_LOG_DIR}/access.log combined

</VirtualHost>

<VirtualHost 192.168.0.217:8003>

        ServerAdmin findgood@localhost
        DocumentRoot /var/www/html/manickam
        ErrorLog ${APACHE_LOG_DIR}/error.log
        CustomLog ${APACHE_LOG_DIR}/access.log combined

</VirtualHost>

<VirtualHost 192.168.0.217:8003>

        ServerAdmin findgood@localhost
        DocumentRoot /var/www/html/roshan
        ErrorLog ${APACHE_LOG_DIR}/error.log
        CustomLog ${APACHE_LOG_DIR}/access.log combined

</VirtualHost>

# vim: syntax=apache ts=4 sw=4 sts=4 sr noet

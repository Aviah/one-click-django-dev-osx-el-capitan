echo "=== django main.log /Users/myusername/myprojects/mysite/logs/main.log ==="
tail /Users/myusername/myprojects/mysite/logs/main.log
echo
echo "=== django debug.log /Users/myusername/myprojects/mysite/logs/debug.log ==="
tail /Users/myusername/myprojects/mysite/logs/debug.log
echo
echo "=== Apache error log /private/var/log/apache2/error_log_django_site ==="
tail /private/var/log/apache2/error_log_django_site
echo
echo "=== Nginx error log /usr/local/var/log/nginx/error_log_django_site ==="
tail /usr/local/var/log/nginx/error_log_django_site

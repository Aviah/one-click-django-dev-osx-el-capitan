USERNAME="myusername"
SITEPROJECTNAME="mysite"
PROJECTSDIR='myprojects'

# django site
mkdir -p /Users/$USERNAME/$PROJECTSDIR/
mkdir /Users/$USERNAME/$PROJECTSDIR/$SITEPROJECTNAME
mkdir /Users/$USERNAME/$PROJECTSDIR/$SITEPROJECTNAME/static_root
mkdir /Users/$USERNAME/$PROJECTSDIR/$SITEPROJECTNAME/media_resources
mkdir /Users/$USERNAME/$PROJECTSDIR/$SITEPROJECTNAME/media_uploads
cp images/favicon.ico images/powered-by-django.gif  /Users/$USERNAME/$PROJECTSDIR/$SITEPROJECTNAME/media_resources/
cp images/avatar.png /Users/$USERNAME/$PROJECTSDIR/$SITEPROJECTNAME/media_uploads
mkdir /Users/$USERNAME/$PROJECTSDIR/$SITEPROJECTNAME/site_config
touch /Users/$USERNAME/$PROJECTSDIR/$SITEPROJECTNAME/site_config/__init__.py
cp scripts/settings_tmp.py /Users/$USERNAME/$PROJECTSDIR/$SITEPROJECTNAME/site_config/
cp scripts/secrets.py /Users/$USERNAME/$PROJECTSDIR/$SITEPROJECTNAME/site_config/
mkdir /Users/$USERNAME/$PROJECTSDIR/$SITEPROJECTNAME/logs
touch /Users/$USERNAME/$PROJECTSDIR/$SITEPROJECTNAME/logs/main.log
touch /Users/$USERNAME/$PROJECTSDIR/$SITEPROJECTNAME/logs/debug.log
touch /Users/$USERNAME/$PROJECTSDIR/$SITEPROJECTNAME/logs/debug_db.log
mkdir /Users/$USERNAME/$PROJECTSDIR/$SITEPROJECTNAME/django_cache


sudo chown -R $USERNAME:_www /Users/$USERNAME/$PROJECTSDIR/$SITEPROJECTNAME/
git clone django@PUB.IP.IP.IP:/home/django/site_repo.git /Users/$USERNAME/$PROJECTSDIR/$SITEPROJECTNAME/site_repo
git --git-dir=/Users/$USERNAME/$PROJECTSDIR/$SITEPROJECTNAME/site_repo/.git remote add production django@PUB.IP.IP.IP:/home/django/$SITEPROJECTNAME/site_repo/
cp scripts/manage.py /Users/$USERNAME/$PROJECTSDIR/$SITEPROJECTNAME/
cp /Users/$USERNAME/$PROJECTSDIR/$SITEPROJECTNAME/site_repo/settings_dev.py /Users/$USERNAME/$PROJECTSDIR/$SITEPROJECTNAME/site_config/
sudo chown -R $USERNAME:_www /Users/$USERNAME/$PROJECTSDIR/$SITEPROJECTNAME/
sudo cp scripts/django_projects.pth /Library/Python/2.7/site-packages/

# nginx
cp /usr/local/etc/nginx/nginx.conf /usr/local/etc/nginx/nginx.conf.orig
cp etc/nginx.conf /usr/local/etc/nginx/
cp etc/django-site-nginx /usr/local/etc/nginx/servers/


# appache
sudo cp /etc/apache2/httpd.conf /etc/apache2/httpd.conf.orig
sudo cp etc/httpd.conf /etc/apache2/
sudo cp etc/django-site-apache /etc/apache2/extra/

# MySQL
mysql.server restart
python scripts/replace_django_mysql_passwd.py 
echo "Use MySQL root password"
mysql -uroot -p < scripts/db.sql
mysql.server restart

# command line scripts
cp scripts/site*.sh /usr/local/bin/
cp scripts/tail-logs.sh /usr/local/bin/
cp user/django_site_aliases /Users/$USERNAME/.django_site_aliases
touch /Users/$USERNAME/.bash_profile
echo "source ~/.django_site_aliases" >> ~/.bash_profile

# Init
/Users/$USERNAME/$PROJECTSDIR/$SITEPROJECTNAME/manage.py migrate
echo ">>> Adding django site superuser (access to the site django administration)"
echo "[press ENTER to continue]"
read dummy
/Users/$USERNAME/$PROJECTSDIR/$SITEPROJECTNAME/manage.py createsuperuser
/Users/$USERNAME/$PROJECTSDIR/$SITEPROJECTNAME/manage.py collectstatic
sudo chown -R $USERNAME:_www /Users/$USERNAME/$PROJECTSDIR/$SITEPROJECTNAME/

sudo nginx
sudo apachectl restart

# fabric
touch /Users/$USERNAME/.fabricrc
cp /Users/$USERNAME/.fabricrc /Users/$USERNAME/.fabricrc.orig
echo "fabfile=/Users/$USERNAME/fab_$SITEPROJECTNAME.py" > /Users/$USERNAME/.fabricrc
cp scripts/fabfile.py /Users/$USERNAME/fab_$SITEPROJECTNAME.py


echo "Woohoo! If everything OK you should be able to visit the site in your browser http://127.0.0.1, or with manage.py runserver at http://127.0.0.1:8000"













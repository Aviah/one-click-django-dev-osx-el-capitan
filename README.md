# one-click-django-dev-osx-el-capitan

**A set of scripts to auto-install a local dev & deployment django site, for a [one-click-django-server](https://github.com/Aviah/one-click-django-server)**    
   
Local dev machine: OSX 10.11 El-Capitan    
Server: Ubuntu 14.04 LTS    


[Why?](#why)    
[How?](#how)    
[The Polls Tutorial with Deployment](#the-polls-tutorial-with-deployment)    
[Pre-Requisits on your dev Mac](#pre-requisits-on-your-dev-mac)    
[Install Prep](#install-prep)   
[Auto Install](#auto-install)    
[What's Next?](#whats-next) 


## Why?

Tutorials usually start with a local website. But it's often more useful, and more fun, to see a real working website ASAP. With a real website you see something working early, you get a better feel for the progress, and you have something to demonstrate.  
  
The following scripts allow you to (almost) automatically install a django development environment on a local OSX 10.11 El-Capitan. Together with the matching auto-install production scripts, you get a complete development, deployment and production environment, without messing too much with configuration.

Once installed, it's easy to continue with any django tutorial, and instantly deploy to a real website. It's also a great way to learn a bit about deployment and some of of django's settings quirks.

For the seasoned django developer, it's an easy way to have a new single server django website up and running, quickly.

## How?
First auto-install the server with the script of [one-click-django-server](https://github.com/aviah/one-click-django-server). The script will auto-install a site on a clean slate Ubuntu VPS (any Ubuntu 14.04 VPS will do). Once the server works, and you can browse to the website, you can install the development environment.

The one-click-django-dev scripts will clone the server repo, then install and configure a local website. For deployment, the script installs fabric and includes a simple fabric file with common deployment recipes.

## The Polls Tutorial with Deployment

If you are new to django, there is also a tutorial.
 
It's built on the official django polls tutorial, but here you learn on this real development-production environemnt. This version of the official polls tutorial includes working with git, deployment, and basic server troubleshooting.   

So you will have the polls app working on a real website, at `www.yourdomain.com/polls`.


## Pre-Requisits on your dev Mac

You will need the following  installed on your Mac:

### OSX 10.11 El-Capitan
Tested the scripts only on this version. OSX already shipped with Apache2 and git. 

### Homebrew
If Homebrew is not installed, install it:

	you@mac-osx$ ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
	
If alreadt installed, just verify:

	you@mac-osx$ brew update
	you@mac-osx$ brew doctor
	you@mac-osx$ brew upgrade
	
### Nginx (with brew)

If not installed, run:

	you@mac-osx$ brew install nginx
	
*Note: If nginx is already installed, the django-dev setup will change the config files. Your original file will be saved to /usr/local/etc/nginx/nginx.conf.orig*
	
### MySQL (with brew)

If not installed, run:

	you@mac-osx$ brew install mysql
	you@mac-osx$ mysql.server start
	you@mac-osx$ mysql_secure_installation
	
	
*Note: mysql_secure_installation is optional, recommended if you want a similar environment like the server's MySQL. Please note that on OSX mysql_secure_installation, the default entry (not "y") does **not** run the suggested action, where on Ubuntu it does*
	
*Note: If MySQL is already installed, the django-dev setup will change the config files. Your original file will be saved to /etc/my.cnf.orig*


### mod_wsgi (with brew)

If not installed, run:

	you@mac-osx$ brew install homebrew/apache/mod_wsgi
	
*Note: You may need to first install the command line tools, brew will ask you to run xcode-select --install*


### Pip

If not installed, run:

	you@mac-osx$ sudo easy_install pip
	

### Django 1.8.9 (with pip)

Everything is tested on Django 1.8.9, which is LTS version. If django is not installed, run:

	you@mac-osx$ sudo -H pip install Django==1.8.9
	
	
### MySQLdb (with pip)

If not installed, run:

	you@mac-osx$ sudo -H pip install MySQL-python
	
	
### fabric (with pip)

If not installed, run:

	you@mac-osx$ sudo -H pip install fabric






## Install Prep


#### Overview  

**Step 1: Install the server with-one-click-django-server**    
**Step 2: OSX 10.11 El-Capitan with Pre-Requisits Ready**  
**Step 3: Make sure you have SSH access to the server**  
**Step 4: Download & prepare the one-click-django-dev config files**



#### Step 1: Install the server

With the one-click-django-server scripts you can auto install the single-server django website on any Ubuntu VPS. The setup script installs and configures the server, a django website, and a git repository. This repository is cloned to the development environment.    
Once the server is ready and the website works, continue to the local dev environment on your Mac with OSX El-Capitan.

For the auto-install of the server, see [one-click-django-server](https://github.com/aviah/one-click-django-server/)

#### Step 2: Mac OSX 10.11 El-Capitan with Pre-Requistis

The script was tested on OSX 10.11. The Mac should have the pre-requistis installed, see above. 


#### Step 3: Make sure your Mac has SSH access to the server

If you installed the server from your Mac, then you should already have SSH access to the server.

Check from your dev machine:

    you@mac-osx$ ssh PUB.IP.IP.IP

And:

    you@mac-osx$ ssh django@PUB.IP.IP.IP
    
*Replace PUB.IP.IP.IP with the actual VPS public ip (or hostname)*

If you used **another machine** (not the Mac you are going to install the dev environment with), then you should add your Mac ssh public key to the server. Since the server is configured to block password authentication, the easiest way is:

1. If you don't have ssh keys on this Mac, create one:

		you@mac-osx$: mkdir -p ~/.ssh
		you@mac-osx$: chmod 700 ~/.ssh
		you@mac-osx$: ssh-keygen -t rsa

2. Copy the public key (`~/.ssh/id_rsa.pub`) to the machine you created the server with, and name the file dev_id_rsa.pub
3. Upload this key to the server:

		you@local-machine-with-acccess-to-server: scp dev_id_rsa.pub @PUB.IP.IP.IP:~/
		
4. SSH to the server and add this key to the authorized keya:

		you@my-django-server$ cat dev_id_rsa.pub >> .ssh/authorized_keys
		you@my-django-server$ sudo su
		you@my-django-server# cat dev_id_rsa.pub >> /home/django/.ssh/authorized_keys
		you@my-django-server# exit
		you@my-django-server$ rm dev_id_rsa.pub
		
**To use the project's fabric script for deployment, please use SSH key without a passphrase.**



#### Step 3: Download & prepare the config files

1. Download the one-click-django-dev-osx-el-capitan files. You don't need to clone a repo,
just the files.

2. Open a command line, and cd to the one-click-django-dev directory

        you@dev-machine$ cd one-click-django-dev-osx-el-capitan
       
3. Edit find_replace.sh with your actual ip, username etc:

        you@dev-machine$ nano find_replace.sh                                                 
       
       
	In the editor, replace the items that start with `replace-with` with 	your actual data.
	
	So when you see a line like this:
		
		sed -i "s/myusername/replace-with-your-username/g" setup.sh
			
	The edited line should look like the following:
	
		sed -i "s/myusername/john/g" setup.sh
		
	To see an example of a fully edited file, see `find_replace.example` (saved in the same directory of find_replace.sh).
	
	These are the items to edit in `find_replace.sh`:


	Item to replace | Replace with
----------------| ------------  
"replace-with-actual-vps-ip" | The actual VPS Public IP
"replace-with-your-username" | Your actual Linux username
Optional: "replace-with-another-projects-dir-name" | Another projects directory name
Optional: "replace-with-another-project-name" | Another project name

	Use **the same name to replace "mysite" that you used in the server.** The project assumes that the site directory name is the same on both the server and the development environment. So if you changed the the project name (e.g. to "my-django-site") when you installed the one-click-django-server, edit the same change here. 
To change optional items, uncomment the line.

	To change Optional items, uncomment the line.

4. Run find_replace.sh. After you finished edit `find_replace.sh`, exit the editor and run the script:

        you@dev-machine$ ./find_replace.sh
          

*Note:If you do want to have a different name on the server and the development machine, you will have to manaualy edit the fabfile (one-click-django-dev/scripts/fabfile.py) before running the setup script* 
       



## Auto Install

From the command line, make sure you are in the `one-click-django-dev-osx-el-capitan` directory, and that you run it with an **Administrator** account:
     
     you@dev-machine# ./setup.sh
        
*Note: The setup.sh will ask for the sudo password and MySQL root password*

Thats' it! Browse to the local site at 127.0.0.1.
If eveything works, you should see something like [this website image](it_works_osx_el_capitan.png)


**The project location:**
The project is located in your home directory, at `~/myprojects/mysite`.    
On the server, the project is located at the django user home directory at /`home/django/mysite/` (mysite will be the directory you provided with the `find_replace.sh`).

**A word about the IDE:** Choosing an IDE is a personal preferene. If you don't have a prefered python IDE yet, I'll just mention Wing IDE Pro which I use for years and to me, it's the best Python IDE. It's built exactly for the "Python Zen", it's light, with django integration, git integration, excellent debugging and great support.

## What's Next?

Congrats! You have a local site to work with, a production website to deploy to, and a simple deployment script. Start working on your local site, then deploy, and browse to your real website. 
The simplest deployment is really easy! After you develop, commit and push a change that should go to production, simply:

	you@dev-machine: fab deploy
	
See [Deployment](https://github.com/aviah/one-click-django-docs/blob/master/deployment.md).

The project's [Playground](https://github.com/aviah/one-click-django-docs/blob/master/playground.md) let's you play and experiment a bit with the django-one-click project.

If you are new to django, why not take our version to the official django polls tutorial. It implments the polls app in in this real development-deployment-production environment, with git.   
When you finish this tutorial, the polls app will run on the real website at `www.yourdommain.com/polls`.    
Start here [The django polls tutorial with deployment](https://github.com/aviah/one-click-django-polls-tutorial/) 


For a detailed project documentation with refrences to imports, templates, settings, files, directories, logging etc, see [one-click-django-docs](https://github.com/aviah/one-click-django-docs/)




Support this project with my affiliate link| 
-------------------------------------------|
https://www.linode.com/?r=cc1175deb6f3ad2f2cd6285f8f82cefe1f0b3f46|


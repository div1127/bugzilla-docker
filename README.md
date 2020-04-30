# Bugzilla Docker
This repo contains the essential docker files needed to setup Bugzilla stack. You may customize few settings in docker-compose.yml and Dockerfile to suit your specific requirements. Nevertheless, this serves you a solid ground to start with. 

# Docker setup
To build and start the service:
```
docker-compose up -d 
```
To stop the service:
```
docker-compose down 
```
To build again and start with a fresh container: 
```
docker-compose up -d --build --force-recreate 
```

# Post installation steps

1. You would have to run the checkscript.pl script to verify the installation and dependencies. This script will also prompt you to set the login user credentials.
```
docker exec -it bugzilla_web ./checkscript.pl
```
2. Now, you should be able to access the Bugzilla at https://localhost:4080/bugzilla

   a. Please enter the login credentials which you must have set in the previous step.
   
   b. After logging in go to Administration>parameters and set base URL and other parameters as deem fit

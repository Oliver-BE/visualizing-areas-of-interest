# Server Configuration

This repository contains a build script to install and run a docker image (also located here) that will create and configure an r shiny and rstudio server to host various r shiny apps on an ec2 instance. To host more/ different apps, simply modify the apps pulled by the script and install any additional packages needed by modifying the dockerfile.  

## Execution 
To use this repository to create a new RShiny and RStudio Docker based server, create a new Linux 2 EC2 instance (suggest using a medium instance with >=25gb storage and >=4gb memory). If you create it with the security group "R-Docker-Server", you will automatically provide access to relevant ports. You also will need to have already created a free Docker account. Finally, you will need to add the server to the desired domain as an A record using the public ipv4 address of the EC2 instance.

Then, ssh into the instance using a keypair and execute the following commands 
1. Install Git: 
`sudo yum install git -y`
2. Clone this repository: 
`git clone https://github.com/Oliver-BE/visualizing-areas-of-interest.git`
3. Make the scripts executable: 
`chmod +x ./visualizing-areas-of-interest/srv/*.sh`
4. Execute the script `build.sh` with proper flags to install and configure Docker (This will terminate the ssh session and may take several minutes): 
`./visualizing-areas-of-interest/srv/build.sh`
5. Execute the script `containers.sh` with proper flags to build, run, and secure R server containers (This may take several minutes): 
`./visualizing-areas-of-interest/srv/containers.sh` 

After the script has finished executing, 
- Changes on github will be reflected hourly on registered domain

***Note:*** The inbound security group rules associated with the EC2 instance must be modified to include the following protocols in order to allow access to your newly constructed R ecosystem. If you used the R-Docker-Server security group when creating your instance, don't fret it has been done already!
- Port **80** from **anywhere** (Webserver- RShiny and RStudio)
- Port **443** from **anywhere** (Webserver- RShiny and RStudio)

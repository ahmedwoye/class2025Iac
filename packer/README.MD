# Packer and Terraform For building 3 AMI [Amazon Machine Images] and Ec2 Infrastructure



# Fruits And Veg App

![screenshot of app](ArchitecturalDesign.jpg)

A simple app to show how a 3 Tier app works. A list of **fruits** and **vegetables**

-**HTLM + JS** frontend (Tier 1) - fetches data
-**FastAPI/Python** - backend (Tier 2) provides `/fruits`
-**Maven/Java** - backend (Tier 3) provides `/vegetables`

-

## Note

- The frontend points to the dns of the load Balance to access the application

## Frontend Requirement
- install Nginx/HTTPD and deploy index.html file as required
- install git to download repo

## Backend Python Requirements
- Install git to download repo
- ensure you have python 3 on the server
- `python3 -m venv venv`  Setup required scripts 
- Activate the Virtual environment `source venv\bin/activate`
- install libraries `python -m pip install - r requirements.txt`
- run app `uvivorn main:app --port 8080 --reload` 


## Backend Java Requirements
- Install git to download repo
- ensure you have Java 17 on the server
- Install Java 17 `sudo yum install java-17-amazon-corretto -y`
- Install maven on the Server = `sudo yum install maven -y``
- run app `mvn spring-boot:run -DSpring-boot.run.argument="--server.address=0.0.0.0.0 --server.port=9090"`
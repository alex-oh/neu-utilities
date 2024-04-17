# NEU Utilities
## CS5200 DBMS Final Project
Authors: Ethan Olesinski, Alex Oh

## Prerequisites
### Site
- install python3
- install pip
- install pipenv: `pip install pipenv`

### Server
- install node.js v19 or higher
- install npm

### Database
- install mySQL Workbench

## Setup
### Site:
1. Navigate to the site directory from root: `cd site`
2. run `npm install` to install all dependencies
### Server:
3. Navigate to the server directory from root: `cd server`
4. run `pipenv install` to install all dependencies
### Database
5. Open the .sql database dump file from `/database` in a local mySQL database
6. Run the dump file

## Running this project
1. _Database_: Open the SQL database connection if not already done
2. _Start up server_ -\
    Inside `server/` directory, run:
    ```
    ./bootstrap.sh
    ```
3. _Start up web app locally_ -\
    Inside `site/` directory, run:
    ```
    npm start
    ```
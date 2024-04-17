from flask import Flask, jsonify, request
from flask_cors import CORS

from . import callbacks as c
import mysql.connector
from mysql.connector import pooling

config = {
  'user': 'root',
  'password': '95012638', # update this password
  'host': '127.0.0.1',
  'database': 'utilities',
  'raise_on_warnings': True
}

app = Flask(__name__)
CORS(app) # enable CORS for all routes

def make_connection():
    return mysql.connector.connect(**config)

@app.route("/hello") # default method is GET
def hello_world():
    return "hello, World!"

@app.route("/campuses")
def get_campuses():
    cnx = make_connection()
    response = c.read_campuses(cnx)
    cnx.close()
    return response

@app.route('/shutdown', methods=['POST'])
def shutdown():
    c.shutdown_server()
    return 'Server shutting down...'

@app.route("/all-buildings")
def get_all_buildings():
    cnx = make_connection()
    response = c.read_all_buildings(cnx)
    cnx.close()
    return jsonify(response)

if __name__ == "__main__":
    app.run(threaded=True)
from flask import Flask, jsonify, request

from . import callbacks as c
import mysql.connector

config = {
  'user': 'root',
  'password': '95012638', # update this password
  'host': '127.0.0.1',
  'database': 'utilities',
  'raise_on_warnings': True
}

app = Flask(__name__)
cnx = mysql.connector.connect(**config)

@app.route("/hello") # default method is GET
def hello_world():
    return "hello, World!"

@app.route("/campuses")
def get_campuses():
    return c.read_campuses(cnx)

@app.route('/shutdown', methods=['POST'])
def shutdown():
    c.shutdown_server()
    cnx.close()
    return 'Server shutting down...'

@app.route("/all-buildings")
def get_all_buildings():
    return jsonify(c.read_all_buildings(cnx))

if __name__ == "__main__":
    app.run()
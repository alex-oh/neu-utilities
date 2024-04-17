from flask import Flask, jsonify, request 
# TODO: jsonify maybe needed but not necessary to return a proper json object?
from flask_cors import CORS
import os # for getting password from .env

from . import callbacks as c
import mysql.connector
from mysql.connector import pooling

config = {
    'user': 'root',
    'password': os.environ['MYSQL_PASSWORD'],
    'host': '127.0.0.1',
    'database': 'utilities',
    'raise_on_warnings': True
}

app = Flask(__name__)
CORS(app)  # enable CORS for all routes


def make_connection():
    return mysql.connector.connect(**config)


@app.route("/hellotest")  # default method is GET
def hello_world():
    return "hello, World!"


@app.route("/campuses")
def get_campuses():
    cnx = make_connection()
    query = ("SELECT DISTINCT campus_name, campus_id FROM campus")
    response = c.query_list(cnx, query)
    cnx.close()
    return response

@app.route("/all-buildings")
def get_all_buildings():
    cnx = make_connection()
    query = ("CALL getFullBuildingDetails()")
    response = c.query_object(cnx, query)
    cnx.close()
    return response

@app.route("/invoices-delete-list")
def getInvoicesDeleteList():
    cnx = make_connection()
    # response = c.getInvoicesForDelete(cnx)
    query = ("SELECT invoice_id, i.date, building_name FROM invoice AS i JOIN building ON i.building_id = building.building_id")
    response = c.query_object(cnx, query)
    cnx.close()
    return response

'''template for API endpoint'''
@app.route("/template-url")
def templateEndpoint():
    cnx = make_connection()  # open new connection
    # execute callback function to query the database
    response = c.callbackTemplate(cnx)
    cnx.close()  # close the connection out after executing query

    return response # return the response

@app.route("/open-tickets/<int:building_id>")
def get_open_tickets(building_id):
    cnx = make_connection()
    query = (f"SELECT getOpenTickets({building_id})")

    response  = c.query_list(cnx, query)
    cnx.close()
    return response


if __name__ == "__main__":
    app.run(threaded=True)

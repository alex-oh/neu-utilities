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

@app.route("/buildings/deletelist")
def getBuildingsDeleteList():
    cnx = make_connection()
    query = ("SELECT building_name, building_id, campus_name FROM building JOIN campus ON building.campus_id = campus.campus_id")
    response = c.query_object(cnx, query)
    cnx.close()
    return response

@app.route("/buildings/<campus_id>")
def getBuildingsListByCampus(campus_id):
    cnx = make_connection()
    query = (f"CALL getCampusBuildings({campus_id})")
    response = c.query_object(cnx, query)
    cnx.close()
    return response

@app.route("/building/<building_id>", methods=['GET', 'DELETE'])
def buildingRoute(building_id):
    cnx = make_connection()
    response = None
    if request.method == 'GET':
        query = (f"CALL getBuildingDetails({building_id})")
        response = c.query_object(cnx, query)
    elif request.method == 'DELETE':
        print(f"Deleting building {building_id}")
        query = (f"CALL DeleteBuilding({building_id})")
        response = c.delete_query(cnx, query)
    cnx.close()
    return response

@app.route("/invoices/deletelist")
def getInvoicesDeleteList():
    cnx = make_connection()
    query = ("SELECT invoice_id, i.date, building_name FROM invoice AS i JOIN building ON i.building_id = building.building_id")
    response = c.query_object(cnx, query)
    cnx.close()
    return response

@app.route("/invoice/<invoice_id>", methods=['GET', 'DELETE'])
def invoiceRoute(invoice_id):
    cnx = make_connection()
    response = None
    if request.method == 'GET':
        query = (f"SELECT * FROM invoice WHERE invoice_id = {invoice_id}")
        response = c.query_object(cnx, query)
    elif request.method == 'DELETE':
        print(f"Deleting invoice {invoice_id}")
        query = (f"CALL DeleteInvoice({invoice_id})")
        response = c.delete_query(cnx, query)
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

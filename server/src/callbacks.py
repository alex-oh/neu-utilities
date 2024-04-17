from flask import request


def read_campuses(cnx):
    cursor = cnx.cursor()
    query = ("SELECT DISTINCT campus_name FROM campus")

    cursor.execute(query)

    campuses = []  # List to store the campus names

    for x in cursor:
        campuses.append(x[0])  # Assuming campus_name is the first column

    cursor.close()
    return campuses

def read_all_buildings(cnx):
    cursor = cnx.cursor()
    query = ("CALL getFullBuildingDetails()")

    cursor.execute(query)

    buildings = []
    for c in cursor:
        buildings.append(c)
    
    cursor.close()
    return buildings

def shutdown_server():
    func = request.environ.get('werkzeug.server.shutdown')
    if func is None:
        raise RuntimeError('Not running with the Werkzeug Server')
    func()

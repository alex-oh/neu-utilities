from flask import request


def read_campuses(cnx):
    cursor = cnx.cursor()
    query = ("SELECT DISTINCT campus_name, campus_id FROM campus")

    cursor.execute(query)

    # parse the cursor response
    # if it returns a bunch of rows, get the column names
    column_names = []
    for desc in cursor.description:
        column_names.append(desc[0])

    campuses = []  # List to store the campus names
    for row in cursor:  # parse the cursor response from the database
        data_piece = {}
        for key, val in enumerate(row):
            data_piece[column_names[key]] = val
        campuses.append(data_piece)

    cursor.close()
    return campuses

def read_all_buildings(cnx):
    cursor = cnx.cursor()
    query = ("CALL getFullBuildingDetails()")

    cursor.execute(query)

    column_names = []
    for desc in cursor.description:
        column_names.append(desc[0])

    buildings = []
    for row in cursor:
        b_data = {}
        for key, val in enumerate(row):
            b_data[column_names[key]] = val
        buildings.append(b_data)

    cursor.close()
    return buildings


def shutdown_server():
    func = request.environ.get('werkzeug.server.shutdown')
    if func is None:
        raise RuntimeError('Not running with the Werkzeug Server')
    func()


def callbackTemplate(cnx):
    '''
    cursor = cnx.cursor() # open a cursor from the connection
    query = ("insert query here")

    cursor.execute(query) # make the cursor execute the query. response will be returned into cursor
    # parse the cursor response
    # if it returns a bunch of rows, get the column names
    column_names = []
    for desc in cursor.description:
        column_names.append(desc[0])

    # convert row into a json object where the key is the column name, val is row value
    data = []
    for row in cursor: # parse the cursor response from the database
        data_piece = {}
        for key, val in enumerate(row):
            data_piece[column_names[key]] = val
        data.append(data_piece)

    cursor.close() # close the cursor
    '''

    return [{"key": "value"}]

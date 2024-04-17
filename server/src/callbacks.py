from flask import request

def query_list(cnx, query):
    cursor = cnx.cursor()

    cursor.execute(query)

    # parse the cursor response
    # if it returns a bunch of rows, get the column names
    column_names = []
    for desc in cursor.description:
        column_names.append(desc[0])

    data = []  # List to store the campus names
    for row in cursor:  # parse the cursor response from the database
        data_piece = {}
        for key, val in enumerate(row):
            data_piece[column_names[key]] = val
        data.append(data_piece)
    cursor.close()
    return data

def query_object(cnx, query):
    '''Queries database and returns a list of JSON style objects'''
    cursor = cnx.cursor() # open a cursor from the connection

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

    return data


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
  
# callproc method information found via mysql python connector docs at:
# https://dev.mysql.com/doc/connector-python/en/connector-python-api-mysqlcursor-callproc.html
def get_num_workers_at_building(cnx, building_id):

    cursor = cnx.cursor()
    cursor.callproc('getNumWorkersAtBuilding', [building_id])

    result = cursor.fetchone()[0]
    
    cursor.close()
    
    return result

def get_open_tickets(cnx, building_id):

    cursor = cnx.cursor()
    cursor.callproc('getOpenTickets', [building_id])

    result = cursor.fetchone()[0]

    cursor.close()
    
    return result
  
    cursor.close() # close the cursor

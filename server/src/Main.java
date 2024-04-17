import java.util.Scanner;
import java.sql.*;

public class Main {

    /**
     * Method for getting an integer selection from a user.
     * @param scanner the current scanner in scope
     * @return the integer selection from the user
     */
    public static int getMenuInt(Scanner scanner){

        // display the menu and get the selection from the user
        System.out.println("Menu Options:");
        System.out.println("Option 1: Show a list of spells");
        System.out.println("Option 2: Disconnect from the database");
        System.out.print("Please select a menu item: ");

        return scanner.nextInt();

    }

    /**
     * Method for querying the database and listing the spell types available
     * @param connection the database connection
     * @throws SQLException the exception to throw if the connection fails
     */
    public static void listSpellTypes(Connection connection) throws SQLException {

        // create a statement
        Statement statement = connection.createStatement();

        // write the sql query
        ResultSet resultSet = statement.executeQuery("SELECT DISTINCT type_name FROM spell_type");

        System.out.println("Available spell types:");

        // iterate through each spell in the spell list
        while (resultSet.next()) {

            System.out.println(resultSet.getString("type_name"));

        }

        // close the statement
        resultSet.close();
        statement.close();

    }

    /**
     * Method for querying the database and returning the spells of a specified type.
     * @param connection the database connection
     * @param spell the spell type
     * @throws SQLException the exception to throw if the connection fails
     */
    public static void showSpells(Connection connection, String spell) throws SQLException {

        // call the HW 7 procedure from the database
        CallableStatement callableStatement = connection.prepareCall("{call spell_has_type(?)}");
        callableStatement.setString(1, spell);

        // get the results from the query
        ResultSet results = callableStatement.executeQuery();

        // print the results from the procedure call
        System.out.println("Spells of type " + spell + ":");

        // call the print results function to format for standard output
        printTable(results);

        // close the result set and sql statement
        results.close();
        callableStatement.close();

    }

    /**
     * Function for printing an arbitrary result set returned by a sql query.
     * @param results the result from the sql query
     * @throws SQLException the exception to throw if the connection fails
     */
    public static void printTable(ResultSet results) throws SQLException {

        // get the metadata from the database response
        ResultSetMetaData metaData = results.getMetaData();

        // retrieve the number of columns in the response
        int num_col = metaData.getColumnCount();

        // iterate across the results to print the results form the sql query
        while (results.next()) {

            for (int i = 1; i <= num_col; i++) {

                System.out.print(metaData.getColumnName(i) + ": " + results.getString(i));

                // separate each tuple by a comma
                if (i < num_col) {

                    System.out.print(", ");
                }

            }

            // add a newline
            System.out.println();

        }

    }

    /**
     * Method for checking to see if a user input a valid spell or not.
     * @param connection the database connection
     * @param spellType the spell type to check
     * @return true or false depending on whether the spell is in the database or not
     */
    public static boolean isValidSpell(Connection connection, String spellType) {

        try {

            // check to see that the spell the user input is in the database (convert to lower case)
            PreparedStatement statement = connection.prepareStatement("SELECT type_name FROM spell_type WHERE LOWER(type_name) = LOWER(?)");
            statement.setString(1, spellType);

            // execute the query
            ResultSet resultSet = statement.executeQuery();

            // check to see if there is a tuple in the result set
            boolean isValid = resultSet.next();

            // close the query
            resultSet.close();
            statement.close();

            return isValid;

            // catch an exception and return false if validation fails due to sql error
        } catch (SQLException e) {

            return false;
        }

    }

    /**
     * Method for getting a valid spell from a user.
     * @param scanner the scanner to use
     * @param connection the connection to the database
     * @return the spell type from the user
     */
    public static String getSpell(Scanner scanner, Connection connection) {

        // create a string to store the spell type
        String spellType;

        // continue to loop through until the user provides a valid spell
        while (true) {

            // ask the user for a spell type
            System.out.print("Enter a spell type: ");
            spellType = scanner.nextLine().toLowerCase();

            // check to see if a given spell type is valid or not
            if (isValidSpell(connection, spellType)) {

                break;

            } else {

                // ask the user to provide a valid spell
                System.out.println("Please input a valid spell");

            }

        }

        return spellType;

    }


    public static void main(String[] args) {

        // initialize a new scanner
        Scanner scanner = new Scanner(System.in);

        // loop through until a user inputs the correct credentials
        while (true) {

            // get the username
            System.out.print("Please enter your MySQL username: ");
            String username = scanner.nextLine();

            // get the password
            System.out.print("Please enter your MySQL password: ");
            String password = scanner.nextLine();

            // attempt to connect to the database with the given credentials
            try (Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/harry_potter_book_v2", username, password)) {

                System.out.println("Successfully connected to database!");

                // continue to ask loop through to menu items until user quits the program
                while (true) {

                    // ask the user for their selection
                    int selection = getMenuInt(scanner);
                    scanner.nextLine();

                    // check to see if the user picked option one
                    if (selection == 1) {

                        // list the spell types available to the user
                        listSpellTypes(connection);

                        // get a spell type from the user
                        String spellType = getSpell(scanner, connection);

                        // show the spells for a specific spell type
                        showSpells(connection, spellType);

                    }

                    // check to see if a user picked selection two
                    else if (selection == 2) {

                        // close the database connection and quit the program
                        connection.close();
                        System.out.println("you closed the connection");
                        System.exit(0);

                    }

                    else {
                        System.out.println("Please choose option 1 or 2.");
                    }

                }

                // if the connection does not work send an error message to the user
            } catch (SQLException e) {
                System.out.println("Database connection failed.");
                System.out.println("Please try checking your connection or entering in your username/password again.");

            }

        }

    }

}

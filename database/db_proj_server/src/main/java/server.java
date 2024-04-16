import static spark.Spark.*;
public class server {
  public static void main(String[] args) {
    System.out.println("Hello World");

    get("/hello", (req, res)->{
      return helloHandler();
    });
  }

  private static String helloHandler() {
    return "Goodbye World :(";
  }
}

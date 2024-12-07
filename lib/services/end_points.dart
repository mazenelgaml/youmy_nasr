class EndPoint {
  static String baseUrl="http://192.168.202.123:8088";
  static String signIn = "/nectar/login";
  static String signUp = "/nectar/signUp";
  static String getUserDataEndPoint(id) {
    return "/nectar/get/$id";
  }
}

class ApiKey {
  static String status = "status";
  static String errorMessage = "ErrorMessage";
  static String email = "email";
  static String password = "password";
  static String token = "token";
  static String message = "message";
  static String id = "id";
  static String username = "username";
  static String phone = "phone";
  static String confirmPassword = "confirmPassword";
  static String location = "location";
  static String profilePic = "profilePic";

}
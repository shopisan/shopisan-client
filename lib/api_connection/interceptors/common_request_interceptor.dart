import 'package:http_interceptor/http_interceptor.dart';
import 'package:shopisan/repository/user_repository.dart';

class CommonRequestInterceptor implements InterceptorContract{
  @override
  Future<RequestData> interceptRequest({required RequestData data}) async {
    try {
      data.headers["Accept"] = "application/json";
      data.headers["Content-Type"] = "application/json";
    } catch (e) {
      print(e);
    }

    // TODO isn't this a bit heavy?
    // Test the perfs on this
    final UserRepository userRepo = UserRepository();
    bool hasUser = await userRepo.hasToken();

    if (hasUser) {
      String token = await userRepo.getAuthToken();
      data.headers["Authorization"] = "Token $token";
    }

    return data;
  }

  Future<bool> shouldAttemptRetryOnResponse(ResponseData response) async {
    print(response.body);
    if (response.statusCode == 401) {
      // Perform your token refresh here.
      throw new HttpInterceptorException("Not implemented");
      return true;
    }

    if (response.body?.contains("Connection closed before full header") == true){
      return true;
    }

    return false;
  }

  @override
  Future<ResponseData> interceptResponse({required ResponseData data}) async => data;
}

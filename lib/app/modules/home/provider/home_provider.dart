import 'package:bkd_presence/app/models/user_model.dart';
import 'package:bkd_presence/app/services/api_service.dart';

class HomeProvider {
  final ApiService _apiService;
  HomeProvider(this._apiService);
  Future<UserModel?> getUsers() async {
    final response = await _apiService.get(
      endpoint: '/user',
      requiresAuthToken: true,
    );
    return UserModel.fromJson(response);
  }

  Future<UserModel?> presenceIn(int id, Map<String, dynamic> body) async {
    final response = await _apiService.put(
      body: body,
      endpoint: '/presence-in/$id',
      requiresAuthToken: true,
    );
    return UserModel.fromJson(response);
  }

  Future<UserModel?> presenceOut(int id, body) async {
    final response = await _apiService.put(
      body: body,
      endpoint: '/presence-out/$id',
      requiresAuthToken: true,
    );
    return UserModel.fromJson(response);
  }

  Future logout() async {
    final response = await _apiService.post(
      endpoint: '/logout',
      requiresAuthToken: true,
    );
    return response;
  }
}

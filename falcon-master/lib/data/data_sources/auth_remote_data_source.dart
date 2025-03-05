import 'package:falcon/core/core_exports.dart';

abstract class BaseAuthRemoteDataSource {
  Future<LoginModel> loginDataSource({required LoginParameters parameters,});
  Future<RegisterModel> registerDataSource({required RegisterParameters parameters,});
  Future<List<UniversityModel>> UniversitiesDataSource();
}

class AuthRemoteDataSource extends BaseAuthRemoteDataSource {


  @override
  Future<LoginModel> loginDataSource({required LoginParameters parameters,}) async {
    try {
      String? deviceId =await getDeviceId();

      final response = await ApiConstants.dio.post(
        ApiConstants.loginUrl,
        data: {
          "email":parameters.email,
          "password": parameters.password,
          "deviceid": (parameters.email=="test@t.com")?"PKQ1.190616.001":deviceId
        },
      );

      if (response.statusCode == 200) {
        return LoginModel.fromJson(response.data);
      } else {
        throw ServerException(
          dioException: DioException(
            requestOptions: response.requestOptions,
            response: response,
            error: response.statusMessage,
          ),
        );
      }
    } on DioException catch (e) {
      throw ServerException(dioException: e);
    }
  }

  //----------------------------------------------------------------------------

  @override
  Future<RegisterModel> registerDataSource({required RegisterParameters parameters,}) async {

    try {

      final response = await ApiConstants.dio.post(
          ApiConstants.registerUrl,
          data: {
            "name": parameters.name,
            "phone": parameters.phone,
            "email": parameters.email,
            "password": parameters.password,
            "university": parameters.university,
            "faculty": parameters.faculty,
            "level": parameters.level,
            "fcmtoken": parameters.fcmtoken,
      });
      if (response.statusCode == 200) {
        return RegisterModel.fromJson(response.data);
      } else {
        throw ServerException(
          dioException: DioException(
            requestOptions: response.requestOptions,
            response: response,
            error: response.statusMessage,
          ),
        );
      }
    } on DioException catch (e) {
      throw ServerException(dioException: e);
    }
  }

  //----------------------------------------------------------------------------

  @override
  Future<List<UniversityModel>> UniversitiesDataSource() async{
    try {
      final response = await ApiConstants.dio.get(ApiConstants.universitiesUrl);
      if(response.statusCode == 200){
        return List<UniversityModel>.from(
            (response.data["universities"]).map((e) => UniversityModel.fromJson(e),)
        );
      }else{
        throw ServerException(
          dioException: DioException(
            requestOptions: response.requestOptions,
            response: response,
            error: response.statusMessage,
          ),
        );
      }
    } on DioException catch (e) {
      throw ServerException(dioException: e);
    }
  }
}


//
// @override
// Future<List<UniversityModel>> UniversitiesDataSource() async{
//   final response = await ApiConstants.dio.get(ApiConstants.universitiesUrl);
//   if(response.statusCode == 200){
//     return List<UniversityModel>.from(
//         (response.data as List).map((e) => UniversityModel.fromJson(e),)
//     );
//   }else{
//     throw ServerException(
//         errorMessageModel: ErrorMessageModel.fromJson(response.data)
//     );
//   }
// }
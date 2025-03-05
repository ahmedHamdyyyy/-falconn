import 'package:falcon/core/core_exports.dart';
import 'package:falcon/data/models/general_models/wallet_model.dart';

abstract class BaseGeneralRemoteDataSource {

  Future<List<DoctorModel>> showAllDoctorsDataSource();
  Future<WalletModel> showWalletDataSource({required ShowWalletParameters parameters});
  Future<ProfileModel> editStudentProfileDataSource({required EditStudentProfileParameters parameters});
  Future<RateModel> rateAndCommentDataSource({required RateAndCommentParameters parameters});
  Future<ChargeCodeModel> validateCodeAndChargeDataSource({required ValidateCodeAndChargeParameters parameters});
  Future<ByContentModel> byAnyContentDataSource({required ByAnyContentParameters parameters});
  Future<RequestContentModel> requestContentDataSource({required RequestContentParameters parameters});
  Future<String> deleteAccountDataSource({required DeleteAccountParameters parameters});

}

class GeneralRemoteDataSource extends BaseGeneralRemoteDataSource {

  @override
  Future<List<DoctorModel>> showAllDoctorsDataSource() async{
    try {
      final response = await ApiConstants.dio.get(
        ApiConstants.showAllDoctorsUrl,
      );
      if (response.statusCode == 200) {
        return List<DoctorModel>.from((response.data["doctors"]).map((e)=>DoctorModel.fromJson(e,isMyLearning: false)));
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
  Future<ProfileModel> editStudentProfileDataSource({required EditStudentProfileParameters parameters}) async{
    try {
      final response = await ApiConstants.dio.post(
        ApiConstants.editStudentProfileUrl,
        data: {
          "id":parameters.studentId,
          "name":parameters.name,
          "phone":parameters.phone,
          "email":parameters.email,
          "password":parameters.password,
          "university":parameters.university,
          "faculty":parameters.faculty,
          "level":parameters.level,
        }
      );
      if (response.statusCode == 200) {
        return ProfileModel.fromJson(response.data);
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
  Future<RateModel> rateAndCommentDataSource({required RateAndCommentParameters parameters}) async{
    try {

      final response = await ApiConstants.dio.post(
        ApiConstants.ratingUrl,
        data: {
          "studentid": parameters.studentId,
          "subjectid": parameters.subjectId,
          "rate": parameters.rate,
          "comment": parameters.comment,
        }
      );

      if (response.statusCode == 200) {
        return RateModel.fromJson(response.data);
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
  Future<ChargeCodeModel> validateCodeAndChargeDataSource({required ValidateCodeAndChargeParameters parameters}) async{
    try {
      final response = await ApiConstants.dio.post(
        ApiConstants.walletChargeUrl,
        data: {
          "studentid":parameters.studentId.toString(),
          "code":parameters.code.toString(),
        }
      );
      if (response.statusCode == 200) {
        return ChargeCodeModel.fromJson(response.data);
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
  Future<WalletModel> showWalletDataSource({required ShowWalletParameters parameters}) async{
    try {
      final response = await ApiConstants.dio.get(
        "${ApiConstants.showWalletUrl}?studentid=${parameters.studentId}",

      );
      if (response.statusCode == 200) {
        return WalletModel.fromJson(response.data);
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
  Future<ByContentModel> byAnyContentDataSource({required ByAnyContentParameters parameters}) async{
    try {

      final response = await ApiConstants.dio.post(
        ApiConstants.byAnyContentUrl,

          data: {
            "type": parameters.type.toString(),
            "id": parameters.id.toString(),
            "studentid":parameters.studentid.toString(),
            "code": parameters.code.toString()
          }
      );
      if (response.statusCode == 200) {
        return ByContentModel.fromJson(response.data);
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
  Future<RequestContentModel> requestContentDataSource({required RequestContentParameters parameters}) async{
    try {

      final response = await ApiConstants.dio.post(
          ApiConstants.requestContentUrl,

          data: {
            "type": parameters.type.toString(),
            "id": parameters.id.toString(),
            "studentid":parameters.studentid.toString(),
          }
      );


      if (response.statusCode == 200 ||response.statusCode==201) {

        return RequestContentModel.fromJson(response.data);
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
  Future<String> deleteAccountDataSource({required DeleteAccountParameters parameters}) async{
    try {

      final response = await ApiConstants.dio.post(
        "${ApiConstants.deleteAccountUrl}?studentid=${parameters.studentId}",

      );
      if (response.statusCode == 200) {
        return response.data["message"].toString();
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

}
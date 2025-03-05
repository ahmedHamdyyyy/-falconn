import 'package:falcon/core/core_exports.dart';

abstract class BaseModulesRemoteDataSource {

  Future<List<LastChapterModel>> getLastChaptersDataSource();
  Future<List<ModuleModel>> getUserModulesDataSource({required GetUserModulesParameters parameters});
  Future<List<SubjectModel>> getUserSubjectsDataSource({required GetUserSubjectsParameters parameters});
  Future<List<ChapterModel>> getUserChaptersDataSource({required GetUserChaptersParameters parameters});
  Future<List<ModuleModel>> getStudentModulesDataSource({required GetStudentModulesParameters parameters});
}


class ModulesRemoteDataSource extends BaseModulesRemoteDataSource {

  @override
  Future<List<LastChapterModel>> getLastChaptersDataSource() async{
    try {
      final response = await ApiConstants.dio.get(
        ApiConstants.lastChaptersUrl,
      );

      if (response.statusCode == 200) {
        return List<LastChapterModel>.from((response.data["latest_chapters"]).map((e)=>LastChapterModel.fromJson(e)));
      } else {
        throw ServerException(
          dioException: DioException(
            requestOptions: response.requestOptions,
            response: response,
          ),
        );
      }
    } on DioException catch (e) {
      throw ServerException(dioException: e);
    }
  }

  //----------------------------------------------------------------------------

  @override
  Future<List<ChapterModel>> getUserChaptersDataSource({required GetUserChaptersParameters parameters}) async{
    try {
      final response = await ApiConstants.dio.get(
        "${ApiConstants.chaptersUrl}?subjectid=${parameters.subjectId}&userid=${parameters.userId}",
      );
      if (response.statusCode == 200) {
        return List<ChapterModel>.from((response.data["chapters"]).map((e)=>ChapterModel.fromJson(e,isMyLearning: false)));
      } else {
        throw ServerException(
          dioException: DioException(
            requestOptions: response.requestOptions,
            response: response,
          ),
        );
      }
    } on DioException catch (e) {
      throw ServerException(dioException: e);
    }
  }

  //----------------------------------------------------------------------------

  @override
  Future<List<ModuleModel>> getUserModulesDataSource({required GetUserModulesParameters parameters}) async{
    try {
      final response = await ApiConstants.dio.get(
        "${ApiConstants.modulesUrl}?userid=${parameters.userId}",
      );
      if (response.statusCode == 200) {
        return List<ModuleModel>.from((response.data["modules"]).map((e)=>ModuleModel.fromJson(e,isMyLearning: false)));
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
  Future<List<SubjectModel>> getUserSubjectsDataSource({required GetUserSubjectsParameters parameters})async {
    try {
      final response = await ApiConstants.dio.get(
        "${ApiConstants.subjectsUrl}?moduleid=${parameters.moduleId}",
      );
      if (response.statusCode == 200) {
        return List<SubjectModel>.from((response.data["subjects"]).map((e)=>SubjectModel.fromJson(e,isMyLearning: false)));
      } else {
        throw ServerException(
          dioException: DioException(
            requestOptions: response.requestOptions,
            response: response,
            error: response.statusMessage,
          ),
        );
      }
    }on DioException catch (e) {
      throw ServerException(dioException: e);
    }
  }

  //----------------------------------------------------------------------------

  @override
  Future<List<ModuleModel>> getStudentModulesDataSource({required GetStudentModulesParameters parameters}) async{
    try {
      final response = await ApiConstants.dio.get(
        "${ApiConstants.showStudentModuleUrl}?studentid=${parameters.studentId}",
        data: {
          "studentid":parameters.studentId,
        },
      );
      if (response.statusCode == 200) {
        return List<ModuleModel>.from((response.data["modules"]).map((e)=>ModuleModel.fromJson(e,isMyLearning: true)));
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
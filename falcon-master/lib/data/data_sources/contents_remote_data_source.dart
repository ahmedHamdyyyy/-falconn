import 'package:falcon/core/core_exports.dart';

abstract class BaseContentsRemoteDataSource {

  Future<List<AdModel>> getAdsDataSource();
  Future<List<ContentModel>> showAllContentsDataSource({required ShowAllContentsParameters parameters});
  Future<OrgContentsModel> showOrgContentsDataSource({required ShowOrgContentsParameters parameters});
  Future<ContentModel> showContentByIDDataSource({required ShowContentByIDParameters parameters});
  Future<VideoFileModel> showVideoFileDataSource({required ShowVideoFileParameters parameters});
  Future<QuizModel> showQuestionsDataSource({required ShowQuestionsParameters parameters});
  Future<AssignmentModel> showAssignmentQuestionDataSource({required ShowAssignmentsParameters parameters});
  Future<List<AnswerCorrectModel>> getModelAnswersDataSource({required GetModelAnswersParameters parameters});
  Future<List<AssignmentAnswerModel>> getAssignmentModelAnswersDataSource({required GetAssignmentModelAnswersParameters parameters});

}

class ContentsRemoteDataSource extends BaseContentsRemoteDataSource {

  @override
  Future<List<AdModel>> getAdsDataSource() async{
    try {
      final response = await ApiConstants.dio.get(
        ApiConstants.adsShowUrl,
      );
      if (response.statusCode == 200) {
        return List<AdModel>.from((response.data["ads"]).map((e)=>AdModel.fromJson(e)));
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
  Future<List<ContentModel>> showAllContentsDataSource({required ShowAllContentsParameters parameters}) async{
    try {
      final response = await ApiConstants.dio.get(
          "${ApiConstants.showAllContentUrl}?userid=${parameters.userId}&chapterid=${parameters.chapterId}",
          data: {
            "userId":parameters.userId,
          }
      );
      if (response.statusCode == 200) {
        return List<ContentModel>.from((response.data).map((e)=>ContentModel.fromJson(e)));
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
  Future<OrgContentsModel> showOrgContentsDataSource({required ShowOrgContentsParameters parameters}) async{
    try {
      final response = await ApiConstants.dio.get(
        "${ApiConstants.showOrgContentsUrl}?userid=${parameters.userId}&chapterid=${parameters.chapterId}",
      );
      if (response.statusCode == 200) {
        return OrgContentsModel.fromJson(response.data);
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
  Future<ContentModel> showContentByIDDataSource({required ShowContentByIDParameters parameters}) async{
    try {
      final response = await ApiConstants.dio.get(
          ApiConstants.showContentByIdUrl,
          data: {
            "studentId":parameters.contentId,
            "type":parameters.type,
          }
      );
      if (response.statusCode == 200) {
        return ContentModel.fromJson(response.data);
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
/*

  @override
  Future<VideoViewModel> countVideoViewDataSource({required CountVideoViewParameters parameters}) async{
    try {
      final response = await ApiConstants.dio.get(
        ApiConstants.countVideoViewUrl,
        data: {
          "studentId":parameters.studentId,
          "videoId":parameters.videoId,
        }
      );
      if (response.statusCode == 200) {
        return VideoViewModel.fromJson(response.data);
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
*/

  //----------------------------------------------------------------------------

  @override
  Future<QuizModel> showQuestionsDataSource({required ShowQuestionsParameters parameters}) async{
    try {
      final response = await ApiConstants.dio.get(
          "${ApiConstants.showQuestionsUrl}?quizid=${parameters.quizId}",

      );
      if (response.statusCode == 200) {
        return QuizModel.fromJson(response.data);
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
  Future<List<AnswerCorrectModel>> getModelAnswersDataSource({required GetModelAnswersParameters parameters}) async{
    try {
      final response = await ApiConstants.dio.get(
          "${ApiConstants.getModelAnswerUrl}?studentid=${parameters.studentId}\&quizid=${parameters.quizId}",
      );

      if (response.statusCode == 200) {
        return List<AnswerCorrectModel>.from((response.data["answers"]).map((e)=>AnswerCorrectModel.fromJson(e)));
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

  @override
  Future<AssignmentModel> showAssignmentQuestionDataSource({required ShowAssignmentsParameters parameters}) async{
    try {
      final response = await ApiConstants.dio.get(
        "${ApiConstants.showAssignmentsUrl}?assignmentid=${parameters.assignmentId}",

      );
      if (response.statusCode == 200) {
        return AssignmentModel.fromJson(response.data);
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

  @override
  Future<List<AssignmentAnswerModel>> getAssignmentModelAnswersDataSource({required GetAssignmentModelAnswersParameters parameters}) async{
    try {
      final response = await ApiConstants.dio.get(
        "${ApiConstants.getAssignmentModelAnswerUrl}?studentid=${parameters.studentId}\&assignmentid=${parameters.quizId}",
      );

      if (response.statusCode == 200) {
        return List<AssignmentAnswerModel>.from((response.data["answers"]).map((e)=>AssignmentAnswerModel.fromJson(e)));
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

  @override
  Future<VideoFileModel> showVideoFileDataSource({required ShowVideoFileParameters parameters}) async{
    try {
      final response = await ApiConstants.dio.get(
        "${ApiConstants.showVideoFileUrl}?contentid=${parameters.contentId}",
      );
      if (response.statusCode == 200) {
        return  VideoFileModel.fromJson(response.data);;
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





}
import 'package:falcon/core/core_exports.dart';

class ApiConstants {

  static const baseUrl = "https://optima-software-solutions.com/falcon";

  static const String encryptionKey = "zdcvbnhslkhgvnkl6432lhfs7n164kf9";
  static final dio = Dio(
    BaseOptions(baseUrl: baseUrl),
  );

  //--- Auth Urls --------------------------------------
  static const loginUrl = "/login.php";
  static const registerUrl = "/register.php";
  static const universitiesUrl = "/universitiesshow.php";

  //--- Modules --------------------------------------
  static const lastChaptersUrl = "/latestchapters.php";
  static const modulesUrl = "/modules.php";
  static const subjectsUrl = "/subjects.php";
  static const chaptersUrl = "/chapters.php";
  static const buyModuleUrl = "/buymodule.php";
  static const showStudentModuleUrl = "/showstudentmodules.php";
  static const ratingUrl = "/rating.php";

  //--- Contents --------------------------------------
  static const latestChaptersUrl = "/latestchapters.php";
  static const showAllContentUrl = "/showallcontent.php";
  static const showOrgContentsUrl = "/showcontent.php";
  static const showContentByIdUrl = "/showcontentbyid.php";
  static const countVideoViewUrl = "/countvideoview.php";
  static const showQuestionsUrl = "/showquestions.php";
  static const showAssignmentsUrl = "/showhomeworkquestions.php";
  static const getExamResultsUrl = "/getexamresults.php";
  static const getModelAnswerUrl = "/modelanswer.php";
  static const getAssignmentModelAnswerUrl = "/homeworkmodelanswer.php";
  static const showVideoFileUrl = "/showvideosmaterials.php";


  //--- General --------------------------------------
  static const adsShowUrl = "/adsshow.php";
  static const walletChargeUrl = "/walletcharge.php";
  static const showAllDoctorsUrl = "/showdoctors.php";
  static const editStudentProfileUrl = "/editstudent.php";
  static const reportScreenshotUrl = "/reportscreenshot.php";
  static const showWalletUrl = "/wallet.php";
  static const byAnyContentUrl = "/buymodule.php";
  static const deleteAccountUrl = "/removeaccount.php";
  static const requestContentUrl = "/requestmoduleorsubject.php";







//--------------------------- Dio Exception ---------------------------------

String connectionErrorMessage = "There is no internet , make sure your connection !";
String badResponseMessage = "There is a problem, try again !";
String cancelErrorMessage = "your process cancelled!";
String statusCode404Message = "Your request not found, try again later !";
String statusCode500Message = "Internal Server error, try again later !'";
String statusCode401Message = "There is a problem, try again !";
String otherErrorMessage = "There is a problem, try again later !";


String handelDioException({required DioException exception}) {
  if (exception.type == DioExceptionType.connectionError) {
    return connectionErrorMessage;
  }
  if (exception.type == DioExceptionType.badResponse) {
    return badResponseMessage;
  }
  if (exception.type == DioExceptionType.cancel) {
    return cancelErrorMessage;
  }
  if (exception.response?.statusCode == 404) {
    return statusCode404Message;
  }
  if (exception.response?.statusCode == 500) {
    return statusCode500Message;
  }
  if (exception.response?.statusCode == 401) {
    return statusCode401Message;
  }
  return otherErrorMessage;
}

}
import "dart:convert";
import "dart:developer";
import "dart:io";
import "dart:ui";
import 'dart:ui' as ui;
import "package:another_flushbar/flushbar.dart";
import "package:file_picker/file_picker.dart";
import "package:flutter/material.dart";
import "package:flutter/rendering.dart";
import "package:flutter/services.dart";
import 'package:geolocator/geolocator.dart';
import "package:get/get.dart";
import "package:get/get_core/src/get_main.dart";
import "package:image_picker/image_picker.dart";
import "package:open_filex/open_filex.dart";
import "package:path_provider/path_provider.dart";
import 'package:shared_preferences/shared_preferences.dart';
import "package:http/http.dart" as http;
import "package:url_launcher/url_launcher.dart";
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class Api {
  static List<dynamic> CategoryList_data = [];
  static List<dynamic> Sub_CategoryList_data = [];
  static List<dynamic> state_list = [];
  static List<dynamic> city_list = [];
  static var User_info;
  static Map<String, dynamic> H_Questions = {};
  static Map TermsAndConditions = {};
  static late SharedPreferences prefs;
  static bool loading = false;
  static Uint8List? user_logo;
  static Future<void> local_dataBase() async {
    prefs = await SharedPreferences.getInstance();
  }

  static Future<void> snack_bar(
      {required context, required String message}) async {
    Flushbar(
      // message:message,

      backgroundColor: Colors.transparent,
      borderRadius: BorderRadius.circular(20),
      messageText: Container(
        alignment: Alignment.center,
        color: Colors.transparent,
        child: IntrinsicWidth(
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            decoration: BoxDecoration(
                color: const Color.fromARGB(255, 255, 255, 255),
                borderRadius: BorderRadius.circular(10)),
            alignment: Alignment.center,
            child: Row(
              spacing: 10,
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  child: Image.asset(
                    "assets/logo/app logo.png",
                    height: 23,
                  ),
                  radius: 13,
                  backgroundColor: Colors.black,
                ),
                Text(
                  message,
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
        ),
      ),
      duration: Duration(seconds: 1),
      // margin: EdgeInsets.symmetric(horizontal: double.maxFinite),

      // icon: ,
      animationDuration: Duration(milliseconds: 500),
      // leftBarIndicatorColor: Colors.blue,
      flushbarPosition: FlushbarPosition.TOP, // Position from top
    ).show(context);
  }

  static Future<void> snack_bar2(
      {required context, required String message}) async {
    Get.snackbar(
      "",
      "",
      backgroundColor: Colors.transparent,
      barBlur: 0,
      messageText: Container(
        alignment: Alignment.center,
        color: Colors.transparent,
        child: IntrinsicWidth(
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            decoration: BoxDecoration(
                color: const Color.fromARGB(255, 255, 255, 255),
                borderRadius: BorderRadius.circular(10)),
            alignment: Alignment.center,
            child: Row(
              spacing: 10,
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  child: Image.asset(
                    "assets/logo/app logo.png",
                    height: 23,
                  ),
                  radius: 13,
                  backgroundColor: Colors.black,
                ),
                Text(
                  message,
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // -------------------------------------------------------------------------------------------  (send OTP)
  static Future<void> send_otp(String mob_no, context) async {
    // String url='https://wedingappapi.systranstechnology.com/MobApi.asmx/MobileApi?ParmCriteria={"MobileNo":'"'$mob_no'"',"ApiAdd":"MobileOTP","CallBy":"MobileApi","AuthKey":"SYS101"}&OrgID=0061&ApiAdd=MobileOtp';
    String url =
        'https://wedingappapi.systranstechnology.com/MobApi.asmx/MobileApi?ParmCriteria={"MobileNo":'
        "'$mob_no'"
        ',"ApiAdd":"MobileOTP","CallBy":"MobileApi","AuthKey":"SYS101"}&OrgID=0061&ApiAdd=MobileOTP';
    var res = await http.get(Uri.parse(url));
    if (res.statusCode == 200) {
      print(res.body.isNotEmpty);

      if (res.body.isNotEmpty) {
        var data = jsonDecode(res.body);
        // ScaffoldMessenger.of(context)
        //     .showSnackBar(SnackBar(content: Text("Duplicate data")));
      }
      // log("Done Send OTP API");
      // return data["Table1"][0]["OTPNo"];
    } else {
      log("Error........ on Send OTP API");
      // return 0;
    }
  }

  // -------------------------------------------------------------------------------------------  (phone number check )
  static Future<bool> mob_check(String mob_no) async {
    String url =
        'https://wedingappapi.systranstechnology.com/MobApi.asmx/MobileApi?ParmCriteria={"MobileNo":'
        "'$mob_no'"
        ',"ApiAdd":"MerchantMobileNoCheck","CallBy":"MobileApi","AuthKey":"SYS101"}&OrgID=0061&ApiAdd=MerchantMobileNoCheck';
    var res = await http.get(Uri.parse(url));
    if (res.statusCode == 200) {
      log("check mobile number regesterd or not");
      print(res);
      print(res.body);
      var data = jsonDecode(res.body);
      print(data);
      if (data["Table1"][0]["IsRegister"] == 0) {
        return false;
      } else {
        return true;
      }
    } else {
      log("Error........check mobile number regesterd or not API ");
      throw("Error........check mobile number regesterd or not API ");
      // return false;
    }
  }

  // -------------------------------------------------------------------------------------------  (OTP insert)
  static Future<bool> otp_insert(
      {required String mob_no, required String Otp}) async {
    String url =
        'https://wedingappapi.systranstechnology.com/MobApi.asmx/MobileApi?ParmCriteria={"MobileNo": '
        "'$mob_no'"
        ',"OTP":'
        "'$Otp'"
        ',"ApiAdd":"MOTPVerify","CallBy":"MobileApi","AuthKey":"SYS101"}&OrgID=0061&ApiAdd=MOTPVerify';
    var res = await http.get(Uri.parse(url));
    if (res.statusCode == 200) {
      log("otp_insert Api Call.............");
      print(res);
      print(res.body);
      var data = jsonDecode(res.body);
      if (data["Table"][0]["ResultCode"] == "R100") {
        return true;
      } else {
        return false;
      }
    } else {
      log("Error........ otp_insert Api ");
      return false;
    }
  }

  // -------------------------------------------------------------------------------------------  (Mpin check)
  static Future<String> Mpin_check(
      {required String mob_no, required String Mpin}) async {
    String url =
        'https://wedingappapi.systranstechnology.com/MobApi.asmx/MobileApi?ParmCriteria={"MPin":'
        "'$Mpin'"
        ',"MobileNo":'
        "'$mob_no'"
        ',"ApiAdd":"MpinCheck","CallBy":"MobileApi","AuthKey":"SYS101"}&OrgID=0061&ApiAdd=MpinCheck';
    print(url);
    var res = await http.get(Uri.parse(url));
    if (res.statusCode == 200) {
      log("Check Mpin Api Call.............");
      print(res);
      print(res.body);

      var data = jsonDecode(res.body);
      User_info = data;
      print(User_info);
      await prefs.setBool('login', true);
      await prefs.setString("mpin", Mpin);
      await prefs.setString("mobile_no", mob_no);
      return data["Table"][0]["ResultCode"];
    } else {
      log("Error........ Check_Mpin Api ");
      return " ";
    }
  }

  // -------------------------------------------------------------------------------------------  (Change Password)
  static Future<String> change_password(
      {required String mob_no, required String Mpin}) async {
    String url =
        'https://wedingappapi.systranstechnology.com/MobApi.asmx/MobileApi?ParmCriteria={"MobileNo": '
        "'$mob_no'"
        ',"UserPass":'
        "'$Mpin'"
        ',"ApiAdd":"ChangePass","CallBy":"MobileApi","AuthKey":"SYS101"}&OrgID=0061&ApiAdd=ChangePass';
    var res = await http.get(Uri.parse(url));
    if (res.statusCode == 200) {
      log("change_password Api Call.............");
      print(res);
      print(res.body);
      var data = jsonDecode(res.body);
      return data["Table"][0]["ResultCode"];
    } else {
      log("Error........ change_password Api ");
      return " ";
    }
  }

  // -------------------------------------------------------------------------------------------  (CategoryList)
  static Future<void> CategoryList() async {
    String url =
        'https://wedingappapi.systranstechnology.com/MobApi.asmx/MobileApi?ParmCriteria={"ApiAdd":"CategoryList","CallBy":"MobileApi","AuthKey":"SYS101"}&OrgID=0061&ApiAdd=CategoryList';
    var res = await http.get(Uri.parse(url));
    Map<String, dynamic> data;
    if (res.statusCode == 200) {
      log("change_password Api Call.............");
      // print(res);
      // print(res.body);
      data = jsonDecode(res.body);
      // print(data["Table1"]);
      CategoryList_data.clear();
      CategoryList_data = data["Table1"];
      // return ;
    } else {
      log("Error........ change_password Api ");
      // return [];
    }
  }

  // -------------------------------------------------------------------------------------------  (SubServiceCategoryList)
  static Future<void> Sub_CategoryList({required String id}) async {
    String url =
        'https://wedingappapi.systranstechnology.com/MobApi.asmx/MobileApi?ParmCriteria={"F_MerchentCategory":'
        "'$id'"
        ',"ApiAdd":"ServiceCategoryList","CallBy":"MobileApi","AuthKey":"SYS101"}&OrgID=0061&ApiAdd=ServiceCategoryList';
    var res = await http.get(Uri.parse(url));
    Map<String, dynamic> data;
    if (res.statusCode == 200) {
      log("SubServiceCategoryList Api Call.............");
      data = jsonDecode(res.body);
      Sub_CategoryList_data.clear();
      Sub_CategoryList_data = data["Table1"];
    } else {
      log("Error........ SubServiceCategoryList Api ");
    }
  }

  // -------------------------------------------------------------------------------------------  (StateList)
  static Future<void> StateList() async {
    String url =
        'https://wedingappapi.systranstechnology.com/MobApi.asmx/MobileApi?ParmCriteria={"ApiAdd":"StateList","CallBy":"MobileApi","AuthKey":"SYS101"}&OrgID=0061&ApiAdd=StateList';
    var res = await http.get(Uri.parse(url));
    Map<String, dynamic> data;
    if (res.statusCode == 200) {
      log("StateList Api Call.............");
      data = jsonDecode(res.body);
      state_list.clear();
      state_list = data["Table1"];
    } else {
      log("Error........ StateList Api ");
    }
  }

  // -------------------------------------------------------------------------------------------  (CityList)
  static Future<void> CityList() async {
    String url =
        'https://wedingappapi.systranstechnology.com/MobApi.asmx/MobileApi?ParmCriteria={"StateId": "1","ApiAdd":"CityList","CallBy":"MobileApi","AuthKey":"SYS101"}&OrgID=0061&ApiAdd=CityList';
    var res = await http.get(Uri.parse(url));
    Map<String, dynamic> data;
    if (res.statusCode == 200) {
      log("CityList Api Call.............");
      data = jsonDecode(res.body);
      city_list.clear();
      city_list = data["Table1"];
    } else {
      log("Error........ CityList Api ");
    }
  }

  static Future<Position> get_loc(context, Function loader) async {
    bool serviceEnable = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnable) {
      Geolocator.openLocationSettings();
      // Geolocator.openAppSettings();
      // Api.snack_bar(context: context, message: "turn on Location");

      snack_bar2(context: context, message: "turn on Location");
      loader(false);
      return Future.error("Location services are disabled.");
    }
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        loader(false);
        // snack_bar(context: context, message: "Location permissions are denied");
        // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Location permissions are denied")));
        snack_bar2(
            context: context, message: " Location permissions are denied");
        return Future.error("Location permissions are denied");
      }
    }
    if (permission == LocationPermission.deniedForever) {
      loader(false);
      //  snack_bar(context: context, message: "Location Permission are permanently denied");
      //  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Location Permission are permanently denied")));
      snack_bar2(
          context: context,
          message: "Location Permission are permanently denied");
      return Future.error(
          "Location Permission are permanently denied, we cannot request");
    }
    //  loader(false);
    return await Geolocator.getCurrentPosition();
  }

  // -------------------------------------------------------------------------------------------  (MerchantRegistration)
  static Future<String> MerchantRegistration({
    required String MName,
    required String BName,
    required String mobile,
    required String othermobileno,
    required String email,
    required String ServiceId,
    required String F_SubServiceCategory,
    required String OrgAddress,
    required String StateId,
    required String CityId,
    required String AreaId,
    required String MPin,
    required String Longitude,
    required String Latitude,
    required String IsMasterReferCode,
  }) async {
    String url =
        'https://wedingappapi.systranstechnology.com/MobApi.asmx/MobileApi?ParmCriteria={"MName":"$MName","BName":"$BName","Mobile":"$mobile","OtherMobileNo":"$othermobileno","Email":"$email","ServiceId":"$ServiceId","F_SubServiceCategory":"$F_SubServiceCategory","OrgAddress":"$OrgAddress","StateId":"$StateId","CityId":"$CityId","AreaId":"$AreaId","MPin":"$MPin","Longitude":"$Longitude","Latitude":"$Latitude","IsMasterReferCode":"$IsMasterReferCode","ApiAdd":"MerchantRegistration","CallBy":"MobileApi","AuthKey":"SYS101"}&OrgID=YourOrgID&ApiAdd=MerchantRegistration';
    print(url);
    var res = await http.get(Uri.parse(url));
    if (res.statusCode == 200) {
      log("MerchantRegistration Api Call.............");
      print(res);
      print(res.body);
      var data = jsonDecode(res.body);
      return data["Table"][0]["ResultCode"];
    } else {
      log("Error........ MerchantRegistration Api ");
      return " ";
    }
  }

  // ____________________________________________________________________   (Service Question List  )
  static Future<void> Service_Question_List() async {
    String url =
        'https://wedingappapi.systranstechnology.com/MobApi.asmx/MobileApi?ParmCriteria={"MemberMasterId":'
        "\"${User_info["Table"][0]["Id"].toInt()}\""
        ',"ServiceId":'
        "'${User_info["Table"][0]["ServiceID"]}'"
        ',"IsHindi":"${prefs.getInt("is_Hindi")??"0"}","ApiAdd":"ServiceQuestionList","CallBy":"MobileApi","AuthKey":"SYS101"}&OrgID=0061&ApiAdd=ServiceQuestionList';
    print(url);
    var res = await http.get(Uri.parse(url));

    if (res.statusCode == 200) {
      log("Service_Question_List Api Call.............");
      H_Questions.clear();
      H_Questions = jsonDecode(res.body);
      // city_list = data["Table1"];
      print(H_Questions);
    } else {
      log("Error........ Service_Question_List Api ");
    }
  }

  // ____________________________________________________________________   (MerchantAnswareInsert )
  static Future<void> MerchantAnswareInsert(
      {required int Q_id,
      required String Question,
      String Answer1 = "",
      String Answer2 = "",
      String Answer3 = "",
      String Answer4 = "",
      String Answer5 = "",
      String Answer6 = "",
      String Answer7 = ""}) async {
    //   Uint8List  ab =Uint8List.fromList(utf8.encode(Question));
    //  String encodedQuestion= utf8.decode(ab);
    // String encodedQuestion = URLEncoder.encode(Question, "UTF-8");
    String url =
        'https://wedingappapi.systranstechnology.com/MobApi.asmx/MobileApi?ParmCriteria={"F_MemberMaster":'
        "\"${User_info["Table"][0]["Id"].toInt()}\""
        ',"F_ServiceCatagory":'
        "\"${User_info["Table"][0]["ServiceID"]}\""
        ',"F_ServiceQuestionMaster":'
        "\"$Q_id\""
        ',"Question":'
        "\"$Question\""
        ',"Answer1":'
        "\"$Answer1\""
        ',"Answer2":'
        "\"$Answer2\""
        ',"Answer3":'
        "\"$Answer3\""
        ',"Answer4":'
        "\"$Answer4\""
        ',"Answer5":'
        "\"$Answer5\""
        ',"Answer6":'
        "\"$Answer6\""
        ',"Answer7":'
        "\"$Answer7\""
        ',"ApiAdd":"MerchantAnswareInsert","CallBy":"MobileApi","AuthKey":"SYS101"}&OrgID=0061&ApiAdd=MerchantAnswareInsert';
    print(url);
    var res = await http.get(Uri.parse(url));

    if (res.statusCode == 200) {
      log("MerchantAnswareInsert Api Call.............");
      var data = jsonDecode(res.body);
      await Service_Question_List();
      print(data);
    } else {
      log("Error........ MerchantAnswareInsert Api ");
    }
  }

  // ____________________________________________________________________   ( Event Booking Details List  )
  static Future<List<dynamic>> EventBookingDetailsList(
      {required String Which_APIcall_CompleteEvent_UpcomingEvent_TodayEvent,
      required String Is_booking}) async {
    String url =
        'https://wedingappapi.systranstechnology.com/MobApi.asmx/MobileApi?ParmCriteria={"EventList":'
        "'$Which_APIcall_CompleteEvent_UpcomingEvent_TodayEvent'"
        ',"MerchantId":'
        "\"${User_info["Table"][0]["Id"].toInt()}\""
        ',"IsBooking":"$Is_booking","ApiAdd":"EventBookingDetailsList","CallBy":"MobileApi","AuthKey":"SYS101"}&OrgID=0061&ApiAdd=EventBookingDetailsList';
    print(url);
    var res = await http.get(Uri.parse(url));

    if (res.statusCode == 200) {
      log("EventBookingDetailsList Api Call.............");
      var data = jsonDecode(res.body);
      // city_list = data["Table1"];
      log("EventBookingDetailsList Api DATA .............");
      print(data);
      return data["Table1"];
    } else {
      log("Error........ EventBookingDetailsList Api ");
      throw ("Error........ EventBookingDetailsList Api ");
    }
  }

  // ____________________________________________________________________   ( Event Booking Details List  )
  static Future<void> RecipitInsert(
      {required String Amount,
      required String Event_id,
      required String Remark}) async {
    String url =
        'https://wedingappapi.systranstechnology.com/MobApi.asmx/MobileApi?ParmCriteria={"Amount":\"$Amount\","EventId":\"$Event_id\","F_VoucherTypeMaster":"1","F_LedgerDr":\"${User_info["Table"][0]["Id"].toInt()}\","F_LedgerCr":"-1","Remarks":\"$Remark\","ApiAdd":"RecipitInsert","CallBy":"MobileApi","AuthKey":"SYS101"}&OrgID=0061&ApiAdd=RecipitInsert';
    print(url);
    var res = await http.get(Uri.parse(url));

    if (res.statusCode == 200) {
      log("RecipitInsert Api Call.............");
      var data = jsonDecode(res.body);
      // city_list = data["Table1"];
      log("RecipitInsert Api DATA .............");
      print(data);
      // return data["Table1"];
    } else {
      log("Error........ RecipitInsert Api ");
      throw ("Error........ RecipitInsert Api ");
    }
  }

  // ____________________________________________________________________   (Show service in event )
  static Future<List<dynamic>> FacilityReport() async {
    String url =
        'https://wedingappapi.systranstechnology.com/MobApi.asmx/MobileApi?ParmCriteria={"MerchantId":'
        "\"${User_info["Table"][0]["Id"].toInt()}\""
        ',"ApiAdd":"FacilityReport","CallBy":"MobileApi","AuthKey":"SYS101"}&OrgID=0061&ApiAdd=FacilityReport';
    print(url);
    var res = await http.get(Uri.parse(url));

    if (res.statusCode == 200) {
      log("FacilityReport Api Call.............");
      var data = jsonDecode(res.body);
      log("FacilityReport Api DATA .............");
      print(data);
      return data["Table1"];
    } else {
      log("Error........ FacilityReport Api ");
      throw ("Error........ FacilityReport Api ");
    }
  }

  // ____________________________________________________________________   (All images )
  static Future<List<dynamic>> AccountDocument() async {
    String url =
        'https://wedingappapi.systranstechnology.com/MobApi.asmx/MobileApi?ParmCriteria={"AccountId":'
        "\"${User_info["Table"][0]["Id"].toInt()}\""
        ',"ApiAdd":"AccountDocument","CallBy":"MobileApi","AuthKey":"SYS101"}&OrgID=0061&ApiAdd=AccountDocument';
    print(url);
    var res = await http.get(Uri.parse(url));

    if (res.statusCode == 200) {
      log("AccountDocument Api Call.............");
      var data = jsonDecode(res.body);
      log("AccountDocument Api DATA .............");
      print(data);
      return data["Table1"];
    } else {
      log("Error........ AccountDocument Api ");
      throw ("Error........ AccountDocument Api ");
    }
  }

  // ____________________________________________________________________   (ImageInsert )
  static Future<void> ImageInsert(
      {required File? img,
      required String DocType,
      required String ext,
      required String MemberAgreementUpload_UploadFile2,
      context}) async {
    String url =
        'https://wedingappapi.systranstechnology.com/MobApi.asmx/$MemberAgreementUpload_UploadFile2';
    print(
        "=================================================================================");
    print(url);
    final headers = {
      'Content-Type': 'application/json',
    };
    var request = http.MultipartRequest('POST', Uri.parse(url));
    if (DocType == "4") {
      request.files.add(
        await http.MultipartFile.fromPath(
          "UploadDoc", // Field name expected by the API
          img!.path,
        ),
      );
    } else {
      request.files.add(
        await http.MultipartFile.fromPath(
          "base64", // Field name expected by the API
          img!.path,
        ),
      );
    }

    request.fields["AccountId"] = "${User_info["Table"][0]["Id"].toInt()}";
    if (DocType != "4") {
      request.fields["DocType"] = DocType;
    }
    request.fields["fileExtention"] = ext;
    var res = await request.send();
    if (res.statusCode == 200) {
      log("ImageInsert Api Call.............");
      var data = await res.stream.bytesToString();
      log("ImageInsert Api DATA .............");
      print(data);
      if (data.contains("R200")) {
        snack_bar(context: context, message: "Duplicate pdf");
      } else {
        if (ext == ".pdf") {
          snack_bar(context: context, message: "PDF Upload Done");
        } else if (ext == ".mp4") {
        } else {}
      }
      // return data["Table1"];
    } else {
      log("Error........ ImageInsert Api ");
      throw ("Error........ ImageInsert Api ");
    }
  }

  // ____________________________________________________________________   (FacilityInsert with image )
  static Future<void> FacilityInsert(
      {
      // required String MerchantId,
      required String FacilityName,
      required String Amount,
      required File? img,
      required String Description,
      required String F_SubServiceCategory,
      required String ext,
      context}) async {
    String url =
        'https://wedingappapi.systranstechnology.com/MobApi.asmx/FacilityInsert';
    print(
        "=================================================================================");
    print(url);
    final headers = {
      'Content-Type': 'application/json',
    };
    var request = http.MultipartRequest('POST', Uri.parse(url));

    request.files.add(
      await http.MultipartFile.fromPath(
        "FacilityImg", // Field name expected by the API
        img!.path,
      ),
    );

    request.fields["MerchantId"] = "${User_info["Table"][0]["Id"].toInt()}";

    request.fields["FacilityName"] = FacilityName;
    request.fields["Amount"] = Amount;
    request.fields["Description"] = Description;
    request.fields["F_SubServiceCategory"] = F_SubServiceCategory;
    request.fields["fileExtention"] = ext;
    var res = await request.send();
    if (res.statusCode == 200) {
      log("ImageInsert Api Call.............");
      var data = await res.stream.bytesToString();
      log("ImageInsert Api DATA .............");
      print(data);
      if (data.contains("R200")) {
        snack_bar(context: context, message: "Duplicate pdf");
      } else {
        snack_bar(context: context, message: "Image Upload Done");
      }
      // return data["Table1"];
    } else {
      log("Error........ ImageInsert Api ");
      throw ("Error........ ImageInsert Api ");
    }
  }

  // ____________________________________________________________________   (add service in event )
  static Future<bool> RecipitFacilityInsert(
      {required List<Map> serviceAdd,
      required String EventId,
      required String Amount,
      required String Remarks}) async {
    String url =
        'https://wedingappapi.systranstechnology.com/MobApi.asmx/MobileApi?ParmCriteria={"Amount":"${double.parse(Amount).toInt()}","EventId":"${double.parse(EventId).toInt()}","F_VoucherTypeMaster":"1","F_LedgerDr":\"${double.parse(EventId).toInt()}\","F_LedgerCr":'
        "\"${User_info["Table"][0]["Id"].toInt()}\""
        ',"RequestJson":\'{"Services":$serviceAdd}\',"Remarks":"$Remarks","ApiAdd":"RecipitFacilityInsert","CallBy":"MobileApi","AuthKey":"SYS101"}&OrgID=0061&ApiAdd=RecipitFacilityInsert';
    print(url);
    var res = await http.get(Uri.parse(url));

    if (res.statusCode == 200) {
      log("RecipitFacilityInsert Api Call.............");
      // H_Questions.clear();
      // H_Questions = jsonDecode(res.body);
      // print(H_Questions);
      return true;
      // city_list = data["Table1"];
    } else {
      log("Error........ RecipitFacilityInsert Api ");
      throw ("Error........ RecipitFacilityInsert Api ");
    }
  }

  // ____________________________________________________________________   (MerchentLicanceDetail  )
  static Future<bool> MerchentLicanceDetail(
      {required String FassiLicNo,
      required String Gst,
      required String nigamlicanceNo}) async {
    String url =
        'https://wedingappapi.systranstechnology.com/MobApi.asmx/MobileApi?ParmCriteria={"FassiLicNo":\"$FassiLicNo\","nigamlicanceNo":\"$nigamlicanceNo\","GSTNo":\"$Gst\","MemberId":'
        "\"${User_info["Table"][0]["Id"].toInt()}\""
        ',"ApiAdd":"MerchentLicanceDetail","CallBy":"MobileApi","AuthKey":"SYS101"}&OrgID=0061&ApiAdd=MerchentLicanceDetail';
    print(url);
    var res = await http.get(Uri.parse(url));

    if (res.statusCode == 200) {
      log("MerchentLicanceDetail Api Call.............");

      var data = jsonDecode(res.body);
      print(data);
      return true;
      // city_list = data["Table1"];
    } else {
      log("Error........ MerchentLicanceDetail Api ");
      throw ("Error........ MerchentLicanceDetail Api ");
    }
  }

  // ____________________________________________________________________   (Merchent Bank Detail  )
  static Future<bool> MerchentBankDetail(
      {required String Mer_AcHolderName,
      required String Mer_bankAcc,
      required String Mer_IFSCCode,
      required String Mer_bankName}) async {
    String url =
        'https://wedingappapi.systranstechnology.com/MobApi.asmx/MobileApi?ParmCriteria={"Mer_AcHolderName":\"$Mer_AcHolderName\","Mer_bankAcc":\"$Mer_bankAcc\","Mer_IFSCCode":\"$Mer_IFSCCode\","Mer_bankName":\"$Mer_bankName\","ApiAdd":"MerchentBankDetail","MemberId":"242","CallBy":"MobileApi","AuthKey":"SYS101"}&OrgID=0061&ApiAdd=MerchentBankDetail';
    print(url);
    var res = await http.get(Uri.parse(url));

    if (res.statusCode == 200) {
      log("MerchentBankDetail Api Call.............");

      var data = jsonDecode(res.body);
      print(data);
      // Mpin_check(Mpin: ,mob_no: );
      return true;
      // city_list = data["Table1"];
    } else {
      log("Error........ MerchentBankDetail Api ");
      throw ("Error........ MerchentBankDetail Api ");
    }
  }

  // ____________________________________________________________________   (add service in event )
  static Future<bool> CustomerRegistration(
      {required String Mobile,
      required String CName,
      required String Email,
      required String Remarks,
      required String EventName,
      required String Longitude,
      required String Latitude,
      required String EventAddress,
      required String EventEndDate,
      required String Isbooking,
      required String EventStartDate,
      required String EventStartTime,
      required String EventEndTime,
      required String TotalAmount,
      required String BookingAmount,
      required String DueAmount,
      context}) async {
    String url =
        'https://wedingappapi.systranstechnology.com/MobApi.asmx/MobileApi?ParmCriteria={"Mobile":"$Mobile","CName":"$CName","Email":"$Email","ServiceId":"0","MerchantId":'
        "\"${User_info["Table"][0]["Id"].toInt()}\""
        ',"Isbooking":"$Isbooking","EventName":"$EventName","Longitude":"$Longitude","Latitude":"$Latitude","EventAddress":"$EventAddress","EventStartDate":"$EventStartDate","EventEndDate":"$EventEndDate","EventStartTime":"$EventStartTime","EventEndTime":"$EventEndTime","TotalAmount":"$TotalAmount","BookingAmount":"$BookingAmount","DueAmount":"$DueAmount","Remarks":"$Remarks","F_VoucherTypeMaster":"1","ApiAdd":"CustomerRegistration","CallBy":"MobileApi","AuthKey":"SYS101"}&OrgID=0061&ApiAdd=CustomerRegistration';
    print(url);
    var res = await http.get(Uri.parse(url));

    if (res.statusCode == 200) {
      var data = jsonDecode(res.body);
      print(data);
      if (data["Table"][0]["ResultCode"] == "R200") {
        snack_bar(context: context, message: "Duplicate User");
        return false;
      }
      log("RecipitFacilityInsert Api Call.............");
      return true;
    } else {
      log("Error........ RecipitFacilityInsert Api ");
      throw ("Error........ RecipitFacilityInsert Api ");
    }
  }

  // -------------------------------------------------------------- (send Image )
  static Future<Map<String, dynamic>> pickImage(
      {required ImageSource source, required bool img}) async {
    final ImagePicker _picker = ImagePicker();
    final XFile? pickedFile = img
        ? await _picker.pickImage(source: source)
        : await _picker.pickVideo(source: source);
    if (pickedFile != null) {
      print(pickedFile.path);
      String ext = pickedFile.path.split(".").last;
      return {
        "file": File(pickedFile.path),
        "ext": ext,
      };
    }
    return {"file": "", "ext": ""};
  }

  static Future<String> img_convert(File? img) async {
    final File imageFile = File(img!.path);
    final bytes = await imageFile.readAsBytes();
    final String base64Image = base64Encode(bytes);
    print(base64Image);
    return base64Image;
  }

  // __________________________________________________________________   ( download PDF )
  static Future<File?> downloadPdf(
      {required String url, required String fileName}) async {
    try {
      // Send HTTP request to get the file
      final response = await http.get(Uri.parse(url));
      String? directorys;
      if (response.statusCode == 200) {
        // Get the app's directory for storing files
        if (Platform.isAndroid) {
          // Use the external storage directory for Android
          final directory = Directory('/storage/emulated/0/Download');
          if (await directory.exists()) {
            directorys = directory.path;
          } else {
            var temp = await getDownloadsDirectory();
            directorys = temp!.path;
          }
        } else if (Platform.isIOS) {
          // Use the app's documents directory for iOS (iOS doesn't have a shared Downloads folder)
          final directory = await getApplicationDocumentsDirectory();
          directorys = directory.path;
        } else {
          // return null; // Unsupported platform
        }
        // final directory = await getDownloadsDirectory();
        final filePath = '$directorys/$fileName';

        // Save the file locally
        final file = File(filePath);
        await file.writeAsBytes(response.bodyBytes);
        print("File downloaded successfully to: $filePath");
        return file;
        // OpenFilex.open(filePath);
      } else {
        print("Failed to download file. HTTP Status: ${response.statusCode}");
        // return null;
        throw ("Failed to download file. HTTP Status: ${response.statusCode}");
      }
    } catch (e) {
      print("Error downloading file: $e");
    }
  }

  // _________________________________________________________________________________________
  static Future<File?> widget_to_img(final GlobalKey _globalKey) async {
    final RenderRepaintBoundary boundary =
        _globalKey.currentContext!.findRenderObject() as RenderRepaintBoundary;

    // Convert the boundary to an image
    final ui.Image image = await boundary.toImage(pixelRatio: 3.0);
    final ByteData? byteData =
        await image.toByteData(format: ui.ImageByteFormat.png);
    final Uint8List pngBytes = byteData!.buffer.asUint8List();

    // Save the image to a file
    final directory = await getTemporaryDirectory();
    final file = File('${directory.path}/widget_image.png');
    await file.writeAsBytes(pngBytes);
    print("Image saved to: ${file.path}");
    return file;
  }

  // _________________________________________________________________________________________________________
  static Future<String> getAccountPDF({required String url}) async {
    try {
       final response = await http.get(Uri.parse(url));
     if(response.statusCode==200){
       String? directorys;
      if (Platform.isAndroid) {
        final directory = Directory('/storage/emulated/0/Download');
        if (await directory.exists()) {
          directorys = directory.path;
        } else {
          var temp = await getDownloadsDirectory();
          directorys = temp!.path;
        }
      } else if (Platform.isIOS) {
        // Use the app's documents directory for iOS (iOS doesn't have a shared Downloads folder)
        final directory = await getApplicationDocumentsDirectory();
        directorys = directory.path;
      }
      // Create the file in the local storage
      final file = File('${directorys}/MMDD Document${DateTime.now().microsecondsSinceEpoch}.pdf');

      // Write the byte data to the file
      await file.writeAsBytes(response.bodyBytes);

      print('File moved to: ${file.path}');
      return file.path;
     }
     return "";
    } catch (e) {
      print('Error moving file: $e');
      throw 'Error moving file: $e';
    }
  }
  // // _________________________________________________________________________________________________________
  // static Future<String> moveFileToLocalStorage() async {
  //   try {
  //     // Load the file from the assets folder
  //     final byteData =
  //         await rootBundle.load('assets/images/main/downloadedFile.pdf');

  //     // Get the local directory path
  //     String? directorys;
  //     if (Platform.isAndroid) {
  //       // Use the external storage directory for Android
  //       final directory = Directory('/storage/emulated/0/Download');
  //       if (await directory.exists()) {
  //         directorys = directory.path;
  //       } else {
  //         var temp = await getDownloadsDirectory();
  //         directorys = temp!.path;
  //       }
  //     } else if (Platform.isIOS) {
  //       // Use the app's documents directory for iOS (iOS doesn't have a shared Downloads folder)
  //       final directory = await getApplicationDocumentsDirectory();
  //       directorys = directory.path;
  //     }
  //     // Create the file in the local storage
  //     final file = File(
  //         '${directorys}/MMDD Document${DateTime.now().microsecondsSinceEpoch}.pdf');

  //     // Write the byte data to the file
  //     await file.writeAsBytes(byteData.buffer.asUint8List(
  //       byteData.offsetInBytes,
  //       byteData.lengthInBytes,
  //     ));

  //     print('File moved to: ${file.path}');
  //     return file.path;
  //   } catch (e) {
  //     print('Error moving file: $e');
  //     throw 'Error moving file: $e';
  //   }
  // }

  // _______________________________________________________________
  static Future<String?> pickPDF() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null) {
      final filePath = result.files.single.path;
      print('Selected PDF path: $filePath');
      return filePath;
    } else {
      print('No file selected');
    }
  }

// ________________________________________________________________________ (banner images)
  static Future<List<dynamic>> BannerReport() async {
    String url =
        'https://wedingappapi.systranstechnology.com/MobApi.asmx/MobileApi?ParmCriteria={"MerchantId":\"${User_info["Table"][0]["Id"].toInt()}\","ApiAdd":"BannerReport","CallBy":"MobileApi","AuthKey":"SYS101"}&OrgID=0061&ApiAdd=BannerReport';
    print(url);
    var res = await http.get(Uri.parse(url));

    if (res.statusCode == 200) {
      log("BannerReport Api Call.............");
      var data = jsonDecode(res.body);
      log("BannerReport Api DATA .............");
      print(data);
      return data["Table1"];
    } else {
      log("Error........ BannerReport Api ");
      throw ("Error........ BannerReport Api ");
    }
  }

// ________________________________________________________________________ (service)
  static Future<List<dynamic>> service(String service_id) async {
    String url =
        'https://wedingappapi.systranstechnology.com/MobApi.asmx/MobileApi?ParmCriteria={"F_ServiceCategory":\"$service_id\","ApiAdd":"SubServiceCategoryList","CallBy":"MobileApi","AuthKey":"SYS101"}&OrgID=0061&ApiAdd=SubServiceCategoryList';
    print(url);
    var res = await http.get(Uri.parse(url));

    if (res.statusCode == 200) {
      log("service Api Call.............");
      var data = jsonDecode(res.body);
      log("service Api DATA .............");
      print(data);
      return data["Table1"];
    } else {
      log("Error........ service Api ");
      throw ("Error........ service Api ");
    }
  }

  // ____________________________________________________________________   (FacilityInsert_nonimg )
  static Future<bool> FacilityInsert_nonimg({
    required String FacilityName,
    required String F_SubServiceCategory,
    required String Amount,
    required String Description,
    // required String FacilityImg,
  }) async {
    String url =
        'https://wedingappapi.systranstechnology.com/MobApi.asmx/MobileApi?ParmCriteria={"FacilityName":"$FacilityName","MerchantId":\"${User_info["Table"][0]["Id"].toInt()}\","F_SubServiceCategory":"$F_SubServiceCategory","Amount":"$Amount","Description":"$Description","FacilityImg":"","ApiAdd":"FacilityInsert_nonimg","CallBy":"MobileApi","AuthKey":"SYS101"}&OrgID=0061&ApiAdd=FacilityInsert_nonimg';
    print(url);
    var res = await http.get(Uri.parse(url));

    if (res.statusCode == 200) {
      log("FacilityInsert_nonimg Api Call.............");
      return true;
    } else {
      log("Error........ FacilityInsert_nonimg Api ");
      throw ("Error........ FacilityInsert_nonimg Api ");
    }
  }

// ________________________________________________________________________ (service)
  static Future<List<dynamic>> ServiceList() async {
    String url =
        'https://wedingappapi.systranstechnology.com/MobApi.asmx/MobileApi?ParmCriteria={"ApiAdd":"ServiceList","CallBy":"MobileApi","AuthKey":"SYS101"}&OrgID=0061&ApiAdd=ServiceList';
    print(url);
    var res = await http.get(Uri.parse(url));

    if (res.statusCode == 200) {
      log("ServiceList Api Call.............");
      var data = jsonDecode(res.body);
      log("ServiceList Api DATA .............");
      print(data);
      return data["Table1"];
    } else {
      log("Error........ service Api ");
      throw ("Error........ service Api ");
    }
  }

  // ____________________________________________________________________   (ServiceEnquiryInsert )
  static Future<bool> ServiceEnquiryInsert({
    required String personName,
    required String serviceName,
    required String mobile,
  }) async {
    String url =
        'https://wedingappapi.systranstechnology.com/MobApi.asmx/MobileApi?ParmCriteria={"personName":"$personName","serviceName":"$serviceName","mobile":"$mobile","MerchantId":\"${User_info["Table"][0]["Id"].toInt()}\","ApiAdd":"ServiceEnquiryInsert","CallBy":"MobileApi","AuthKey":"SYS101"}&OrgID=0061&ApiAdd=ServiceEnquiryInsert';
    print(url);
    var res = await http.get(Uri.parse(url));

    if (res.statusCode == 200) {
      log("ServiceEnquiryInsert Api Call.............");
      return true;
    } else {
      log("Error........ ServiceEnquiryInsert Api ");
      return false;
      // throw("Error........ ServiceEnquiryInsert Api ");
    }
  }

  // ____________________________________________________________________   (Add_Merchant_TremAndCond )
  static Future<bool> Add_Merchant_TremAndCond(
      {required String TermsAndConditions}) async {
    String url =
        'https://wedingappapi.systranstechnology.com/MobApi.asmx/MobileApi?ParmCriteria={"MemberMasterId":\"${User_info["Table"][0]["Id"].toInt()}\","TermsAndConditions":"$TermsAndConditions","ApiAdd":"MemberAddTremAndCond","CallBy":"MobileApi","AuthKey":"SYS101"}&OrgID=0061&ApiAdd=MemberAddTremAndCond';
    print(url);
    var res = await http.get(Uri.parse(url));

    if (res.statusCode == 200) {
      log("Add_Merchant_TremAndCond Api Call.............");
      return true;
    } else {
      log("Error........ Add_Merchant_TremAndCond Api ");
      return false;
      // throw("Error........ ServiceEnquiryInsert Api ");
    }
  }

// ________________________________________________________________________ (Merchentwisecustomer)
  static Future<List<dynamic>> Merchentwisecustomer() async {
    String url =
        'https://wedingappapi.systranstechnology.com/MobApi.asmx/MobileApi?ParmCriteria={"MemberId":\"${User_info["Table"][0]["Id"].toInt()}\","ApiAdd":"Merchentwisecustomer","CallBy":"MobileApi","AuthKey":"SYS101"}&OrgID=0061&ApiAdd=Merchentwisecustomer';
    print(url);
    var res = await http.get(Uri.parse(url));

    if (res.statusCode == 200) {
      log("Merchentwisecustomer Api Call.............");
      var data = jsonDecode(res.body);
      log("Merchentwisecustomer Api DATA .............");
      print(data);
      return data["Table1"];
    } else {
      log("Error........ Merchentwisecustomer Api ");
      throw ("Error........ Merchentwisecustomer Api ");
    }
  }

// ________________________________________________________________________ (GetMerchentcustomerReview)
  static Future<List<dynamic>> GetMerchentcustomerReview() async {
    String url =
        'https://wedingappapi.systranstechnology.com/MobApi.asmx/MobileApi?ParmCriteria={"F_MemberMaster":\"${User_info["Table"][0]["Id"].toInt()}\","ApiAdd":"GetMerchentcustomerReview","CallBy":"MobileApi","AuthKey":"SYS101"}&OrgID=0061&ApiAdd=GetMerchentcustomerReview';
    print(url);
    var res = await http.get(Uri.parse(url));

    if (res.statusCode == 200) {
      log("GetMerchentcustomerReview Api Call.............");
      var data = jsonDecode(res.body);
      log("GetMerchentcustomerReview Api DATA .............");
      print(data);
      return data["Table1"];
    } else {
      log("Error........ GetMerchentcustomerReview Api ");
      throw ("Error........ GetMerchentcustomerReview Api ");
    }
  }

  // ___________________________________________________________________    (open phone dailer)
  static Future<void> launchDialer(String number) async {
    final Uri url = Uri(scheme: 'tel', path: number);
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  // ___________________________________________________________________    (open email)
  static Future<void> openEmail({
    required String toEmail,
    String? subject,
    String? body,
  }) async {
    String? encodeQueryParameters(Map<String, String> params) {
      return params.entries
          .map((MapEntry<String, String> e) =>
              '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
          .join('&');
    }

    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: toEmail,
      query: encodeQueryParameters(<String, String>{
        'subject': subject ?? "",
      }),
    );

    if (await canLaunchUrl(emailLaunchUri)) {
      await launchUrl(emailLaunchUri);
    } else {
      throw 'Could not launch $emailLaunchUri';
    }
  }

  // ____________________________________________________________   (add service pdf)
  static Future<pw.Document> createPdf({
    required String now_Date,
    required String event_name,
    required String event_date,
    required String compny_name,
    required String comp_mob_no,
    required String cust_mob_no,
    required String cust_name,
    required String Total,
    required List<Map> data,
    required bool add_service,
    String Amount = "",
    String Advance_Amount = "",
    String Du_Amount = "",
    String remark = "",
  }) async {
    // Create a PDF document

    final pd = pw.Document();

    final pdf = pw.Document();
    final fontData =
        await rootBundle.load('assets/fonts/Poppins/Poppins-SemiBold.ttf');
    final ttf = pw.Font.ttf(fontData);
    final ByteData imageData =
        await rootBundle.load('assets/logo/app logo.png');
    final Uint8List imageBytes = imageData.buffer.asUint8List();
    List<pw.TableRow> Rows = [
      pw.TableRow(
        decoration: pw.BoxDecoration(color: PdfColors.grey300),
        children: [
          pw.Padding(
              padding: pw.EdgeInsets.symmetric(vertical: 10),
              child: pw.Text('S.No.',
                  textAlign: pw.TextAlign.center,
                  style: pw.TextStyle(fontWeight: pw.FontWeight.bold))),
          pw.Padding(
              padding: pw.EdgeInsets.symmetric(vertical: 10),
              child: pw.Text('Service Name',
                  textAlign: pw.TextAlign.center,
                  style: pw.TextStyle(fontWeight: pw.FontWeight.bold))),
          pw.Padding(
              padding: pw.EdgeInsets.symmetric(vertical: 10),
              child: pw.Text('Remark',
                  textAlign: pw.TextAlign.center,
                  style: pw.TextStyle(fontWeight: pw.FontWeight.bold))),
          pw.Padding(
              padding: pw.EdgeInsets.symmetric(vertical: 10),
              child: pw.Text('Quantity',
                  textAlign: pw.TextAlign.center,
                  style: pw.TextStyle(fontWeight: pw.FontWeight.bold))),
          pw.Padding(
              padding: pw.EdgeInsets.symmetric(vertical: 10),
              child: pw.Text('Price',
                  textAlign: pw.TextAlign.center,
                  style: pw.TextStyle(fontWeight: pw.FontWeight.bold))),
          pw.Padding(
              padding: pw.EdgeInsets.symmetric(vertical: 10),
              child: pw.Text('Total',
                  textAlign: pw.TextAlign.center,
                  style: pw.TextStyle(fontWeight: pw.FontWeight.bold))),
        ],
      ),
    ];
    if (add_service) {
      for (var i = 0; i < data.length; i++) {
        try {
          Rows.add(
            pw.TableRow(
              children: [
                pw.Padding(
                    padding: pw.EdgeInsets.symmetric(vertical: 10),
                    child: pw.Text(
                      "${i + 1}",
                      textAlign: pw.TextAlign.center,
                    )),
                pw.Padding(
                    padding: pw.EdgeInsets.symmetric(vertical: 10),
                    child: pw.Text(
                      data[i]["\"Name\""]
                          .substring(1, data[i]["\"Name\""].length - 1),
                      textAlign: pw.TextAlign.center,
                    )),
                pw.Padding(
                    padding: pw.EdgeInsets.symmetric(vertical: 10),
                    child: pw.Text(
                      data[i]["\"Remark\""]
                          .substring(1, data[i]["\"Remark\""].length - 1),
                      textAlign: pw.TextAlign.center,
                    )),
                pw.Padding(
                    padding: pw.EdgeInsets.symmetric(vertical: 10),
                    child: pw.Text(
                      data[i]["\"Quantity\""]
                          .substring(1, data[i]["\"Quantity\""].length - 1),
                      textAlign: pw.TextAlign.center,
                    )),
                pw.Padding(
                    padding: pw.EdgeInsets.symmetric(vertical: 10),
                    child: pw.Text(
                      data[i]["\"Price\""],
                      textAlign: pw.TextAlign.center,
                    )),
                pw.Padding(
                    padding: pw.EdgeInsets.symmetric(vertical: 10),
                    child: pw.Text(
                      data[i]["\"Total\""]
                          .substring(1, data[i]["\"Total\""].length - 1),
                      textAlign: pw.TextAlign.center,
                    )),
              ],
            ),
          );
        } catch (e) {
          continue;
        }
      }
    }
    // Add a page
    pdf.addPage(pw.Page(
        // pageFormat: PdfPageFormat.a4,
        margin: pw.EdgeInsets.only(top: 20, left: 20, right: 20,bottom: 0),
        build: (pw.Context context) => pw.Stack(children: [
              pw.Align(
                alignment: pw.Alignment.center,
                child: pw.Opacity(
                  opacity: 0.3,
                  child: pw.Image(
                    pw.MemoryImage(imageBytes),
                    width: 250,
                    height: 250,
                  ),
                ),
              ),
              pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  // Left Corner Heading

                  pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.start,
                      children: [
                        // pw.Image(pw.MemoryImage(user_logo!),width: 50,height: 50,),// MMDD logo add
                        pw.SizedBox(width: 20),
                        if(user_logo!=null)
                        pw.Image(pw.MemoryImage(user_logo!),
                            width: 50, height: 50), // user logo add
                        if(user_logo==null)
                            pw.SizedBox(width: 50),

                            pw.SizedBox(width: 110),
                        pw.Text(
                          compny_name,
                          style: pw.TextStyle(
                            fontSize: 30,
                            fontWeight: pw.FontWeight.bold,
                          ),
                        ),
                        
                        
                        // pw.Container(
                        //     padding: pw.EdgeInsets.symmetric(
                        //         vertical: 5, horizontal: 10),
                        //     color: PdfColors.blue,
                        //     child: pw.Text("INVOICE",
                        //         style: pw.TextStyle(color: PdfColors.white)))
                      ]),
                  pw.SizedBox(height: 5),
                  pw.Row(
                      crossAxisAlignment: pw.CrossAxisAlignment.end,
                      mainAxisAlignment: pw.MainAxisAlignment.start,
                      children: [
                        //  pw.SizedBox(width: 50),
                        pw.Text(
                          'Mobile : ',
                          style: pw.TextStyle(
                              //  color:  PdfColor(0.5, 0.5, 0.5)
                              // fontSize: 15,
                              // fontWeight: pw.FontWeight.bold,
                              ),
                        ),
                        pw.Text(
                          User_info["Table"][0]["MobileNo"],
                          style: pw.TextStyle(color: PdfColor(0.5, 0.5, 0.5)
                              // fontSize: 15,
                              // fontWeight: pw.FontWeight.bold,
                              ),
                        ),
                        // pw.SizedBox(width: 20),
                        // pw.Text("Email : ",
                        //         style: pw.TextStyle()),
                        // pw.Text("Info@makemydreamday.in",
                        //         style: pw.TextStyle(color:  PdfColor(0.5, 0.5, 0.5))),
                      ]),

                  // Main content
                  // pw.SizedBox(height: 5),
                  pw.Divider(
                    height: 3,
                    thickness: 0.5, // Thickness of the divider
                    color: PdfColors.black, // Color of the divider
                  ),
                  pw.Container(
                      height: 60,
                      margin: pw.EdgeInsets.symmetric(vertical: 5),
                      // color: PdfColors.amber,
                      child: pw.Column(
                      
                          mainAxisAlignment: pw.MainAxisAlignment.spaceAround,
                          children: [
                            pw.SizedBox(height: 5),
                            pw.Row(children: [
                              pw.Text("Invoice Date: ",
                                  style: pw.TextStyle(
                                      color: PdfColor(0.5, 0.5, 0.5))),
                              pw.Text(now_Date,
                                  style: pw.TextStyle(color: PdfColors.black))
                            ]),
                            pw.SizedBox(height: 5),
                            pw.Row(children: [
                              pw.Text("Event Name: ",
                                  style: pw.TextStyle(
                                      color: PdfColor(0.5, 0.5, 0.5))),
                              pw.Text(event_name,
                                  style: pw.TextStyle(color: PdfColors.black))
                            ]),
                            pw.SizedBox(height: 5),
                            pw.Row(children: [
                              pw.Text("Event Date:   ",
                                  style: pw.TextStyle(
                                      color: PdfColor(0.5, 0.5, 0.5))),
                              pw.Text(event_date,
                                  style: pw.TextStyle(color: PdfColors.black))
                            ]),
                          ])),
                  pw.SizedBox(height: 5),
                  pw.Row(children: [
                    pw.Container(
                        width: 350,
                        height: 60,
                        // color: PdfColors.amber,
                        child: pw.Column(
                            mainAxisAlignment: pw.MainAxisAlignment.spaceAround,
                            crossAxisAlignment: pw.CrossAxisAlignment.start,
                            children: [
                              pw.SizedBox(height: 5),
                              pw.Text("Company",
                                  style: pw.TextStyle(
                                      color: PdfColor(0.5, 0.5, 0.5))),
                                      pw.SizedBox(height: 5),
                              pw.Text(
                                compny_name,
                              ),
                              pw.SizedBox(height: 5),
                              pw.Text(
                                "Phone: $comp_mob_no",
                                // style: pw.TextStyle(
                                //     color: PdfColor(0.5, 0.5, 0.5))
                              ),
                              pw.SizedBox(height: 5),
                            ])),
                    pw.Container(
                        child: pw.Column(
                            crossAxisAlignment: pw.CrossAxisAlignment.start,
                            children: [
                              pw.SizedBox(height: 5),
                          pw.Text("Customer",
                              style:
                                  pw.TextStyle(color: PdfColor(0.5, 0.5, 0.5))),
                                  pw.SizedBox(height: 5),
                          pw.Text(
                            cust_name,
                          ),
                          pw.SizedBox(height: 5),
                          pw.Text(
                            "Phone: $cust_mob_no ",
                          ),
                          pw.SizedBox(height: 5),
                        ])),
                  ]),
                  pw.SizedBox(height: 5),
                  if (add_service == false)
                    pw.Table(
                        border: pw.TableBorder.all(color: PdfColor(.5, .5, .5)),
                        columnWidths: {
                        0: pw.FixedColumnWidth(200), // Fixed width for column 1
                        // 1: pw.FlexColumnWidth(1), // Flexible width for column 2
                        // 2: pw.FlexColumnWidth(1), // Flexible width for column 3
                        // 3: pw.FlexColumnWidth(1), // Flexible width for column 3
                        // 4: pw.FlexColumnWidth(1), // Flexible width for column 3
                        // 5: pw.FlexColumnWidth(1), // Flexible width for column 3
                      },
                        children: [
                          pw.TableRow(children: [
                            pw.Padding(padding: pw.EdgeInsets.symmetric(horizontal: 5,vertical: 2),child: pw.Text("Total Amount",                                
                                style: pw.TextStyle(
                                    fontWeight: pw.FontWeight.bold)),),
                            pw.Padding(padding: pw.EdgeInsets.symmetric(horizontal: 5,vertical: 2),child: pw.Text("₹${Total}",
                            textAlign: pw.TextAlign.end,
                                style: pw.TextStyle(
                                    fontWeight: pw.FontWeight.bold, font: ttf)),)
                          ]),
                          pw.TableRow(children: [
                            pw.Padding(padding: pw.EdgeInsets.symmetric(horizontal: 5,vertical: 2),child: pw.Text("Advance Amount"),),
                            pw.Padding(padding: pw.EdgeInsets.symmetric(horizontal: 5,vertical: 2),child: pw.Text("₹${Advance_Amount}",
                            textAlign: pw.TextAlign.end,
                                style: pw.TextStyle(
                                    fontWeight: pw.FontWeight.bold, font: ttf)),)
                          ]),
                          pw.TableRow(children: [
                            pw.Padding(padding: pw.EdgeInsets.symmetric(horizontal: 5,vertical: 2),child: pw.Text("Due Amount"),),
                            pw.Padding(padding: pw.EdgeInsets.symmetric(horizontal: 5,vertical: 2),child: pw.Text("₹${Du_Amount}",
                            textAlign: pw.TextAlign.end,
                                style: pw.TextStyle(
                                    fontWeight: pw.FontWeight.bold, font: ttf)),)
                          ]),
                          ]),
                    if(add_service==false)
                      pw.Table(
                        border: pw.TableBorder.all(
                          color:
                              PdfColor(.5, .5, .5)),
                               columnWidths: {
                        0: pw.FixedColumnWidth(6), // Fixed width for column 1
                        // 1: pw.FlexColumnWidth(2), // Flexible width for column 2
                        // 2: pw.FlexColumnWidth(1), // Flexible width for column 3
                        // 3: pw.FlexColumnWidth(1), // Flexible width for column 3
                        // 4: pw.FlexColumnWidth(1), // Flexible width for column 3
                        // 5: pw.FlexColumnWidth(1), // Flexible width for column 3
                      },
                        children: [pw.TableRow(children: [
                            pw.Padding(padding: pw.EdgeInsets.symmetric(horizontal: 5,vertical: 2),child: pw.Text("Remark"),),
                            pw.Padding(padding: pw.EdgeInsets.symmetric(horizontal: 5,vertical: 2),child:  pw.Text("${remark}",
                            textAlign: pw.TextAlign.start,
                                style: pw.TextStyle(
                                    fontWeight: pw.FontWeight.bold, font: ttf)),),
                           
                          ]),]),
                  // pw.Container(
                  //     alignment: pw.Alignment.centerLeft,
                  //     height: 70,
                  //     width: double.infinity,
                  //     child: pw.Column(
                  //       mainAxisAlignment: pw.MainAxisAlignment.center,
                  //       children: [
                  //         pw.Row(
                  //             mainAxisAlignment:
                  //                 pw.MainAxisAlignment.spaceBetween,
                  //             children: [
                  //               pw.Text("Remark"),
                  //               pw.Text("${remark}",
                  //                   style: pw.TextStyle(
                  //                       fontWeight: pw.FontWeight.bold,
                  //                       font: ttf)),
                  //             ]),
                  //         // pw.Row(
                  //         //     mainAxisAlignment:
                  //         //         pw.MainAxisAlignment.spaceBetween,
                  //         //     children: [
                  //         //       pw.Text(
                  //         //         "Today Amount",
                  //         //       ),
                  //         //       pw.Text("₹${Amount}",
                  //         //           style: pw.TextStyle(
                  //         //               fontWeight: pw.FontWeight.bold,
                  //         //               font: ttf)),
                  //         //     ]),
                  //         pw.Row(
                  //             mainAxisAlignment:
                  //                 pw.MainAxisAlignment.spaceBetween,
                  //             children: [
                  //               pw.Text("Advance Amount"),
                  //               pw.Text("₹${Advance_Amount}",
                  //                   style: pw.TextStyle(
                  //                       fontWeight: pw.FontWeight.bold,
                  //                       font: ttf)),
                  //             ]),
                  //         pw.Row(
                  //             mainAxisAlignment:
                  //                 pw.MainAxisAlignment.spaceBetween,
                  //             children: [
                  //               pw.Text("Remark"),
                  //               pw.Text("${remark}",
                  //                   style: pw.TextStyle(
                  //                       fontWeight: pw.FontWeight.bold,
                  //                       font: ttf)),
                  //             ])
                  //       ],
                  //     )),

                  if (add_service == false)
                    pw.Container(
                        margin: pw.EdgeInsets.symmetric(
                            vertical: 11, horizontal: 10),
                        height: 40,
                        width: double.maxFinite,
                        alignment: pw.Alignment.center,
                        color: PdfColors.blue,
                        child: pw.Text("Due Amount: ₹${Du_Amount}",
                            style: pw.TextStyle(
                                color: PdfColors.white,
                                fontSize: 20,
                                font: ttf))),
                  pw.SizedBox(height: 10),
                  if (add_service)
                    pw.Table(
                      border: pw.TableBorder.all(
                          color:
                              PdfColor(.5, .5, .5)), // Add border to the table
                      // defaultColumnWidth: pw.FixedColumnWidth(20),
                      columnWidths: {
                        0: pw.FixedColumnWidth(100), // Fixed width for column 1
                        1: pw.FlexColumnWidth(2), // Flexible width for column 2
                        2: pw.FlexColumnWidth(1), // Flexible width for column 3
                        3: pw.FlexColumnWidth(1), // Flexible width for column 3
                        4: pw.FlexColumnWidth(1), // Flexible width for column 3
                        5: pw.FlexColumnWidth(1), // Flexible width for column 3
                      },
                      children: Rows,
                    ),
                  pw.SizedBox(height: 5),
                  if (add_service)
                    pw.Container(
                      margin:
                          pw.EdgeInsets.symmetric(vertical: 5, horizontal: 0),
                      padding:
                          pw.EdgeInsets.symmetric(vertical: 5, horizontal: 7),
                      decoration: pw.BoxDecoration(
                          border: pw.Border.all(
                              // color: PdfColor(.5, .5, .5)
                              )),
                      child: pw.Row(
                          mainAxisAlignment: pw.MainAxisAlignment.end,
                          children: [
                            pw.Text("Total :",
                                style: pw.TextStyle(
                                    fontWeight: pw.FontWeight.bold)),
                            pw.SizedBox(width: 50),
                            pw.Text(Total,
                                style: pw.TextStyle(
                                    // fontWeight: pw.FontWeight.bold
                                    )),
                          ]),
                    )
                  // pw.Text("Terms & Conditions:"),
                  // pw.Text(cust_name,
                  //     style: pw.TextStyle(color: PdfColor(0.5, 0.5, 0.5))),
                ],
              ),
              //  pw.Positioned(
              //   bottom: 50, // Position text at the bottom
              //   left: 0,
              //   right: 0,
              //   child:   ),
              pw.Positioned(
                  bottom: 30, // Position text at the bottom
                  left: 0,
                  right: 0,
                  child: pw.Column(children: [
                    // pw.Image(pw. ),
                    pw.Row(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.Text(
                            "Terms & Conditions : ",
                            textAlign: pw.TextAlign.center,
                            style: pw.TextStyle(
                                fontSize: 12, fontWeight: pw.FontWeight.bold),
                          ),
                          pw.Container(
                            padding: pw.EdgeInsets.symmetric(horizontal: 3),
                            width: 430,
                            child: pw.Text(
                              '${TermsAndConditions["Table1"][0]["TermsAndConditions"]}' ??
                                  "",
                              textAlign: pw.TextAlign.justify,
                              style: pw.TextStyle(fontSize: 12),
                            ),
                          ),
                        ]),
                    pw.Divider(),
                    
                    pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.center,
                      children: [
                      pw.Image(
                    pw.MemoryImage(imageBytes),
                    width: 50,
                    height: 50,
                  
                  ),
                  pw.SizedBox(width: 10),
                  pw.Column(children: [
pw.Text("* This is computer generated invoice does not require signatures *",
                        textAlign: pw.TextAlign.center),
                  pw.Text("Co- powered by MMDD (Make My Dream Day)",style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                  pw.Row(children: [ pw.Container(child: pw.Row(children: [pw.Text("Mobile :"),pw.Text("18005700102",style: pw.TextStyle(color: PdfColor(0.5, 0.5, 0.5)))])),
                 pw.SizedBox(width: 10),
                  pw.Container(child: pw.Row(children: [pw.Text("Email:"),pw.Text("info@makemydreamday.in",style: pw.TextStyle(color: PdfColor(0.5, 0.5, 0.5)))]))
                 ])
                  ])

                    ])
                  ])),
            ])));
    // final directory = Directory('/storage/emulated/0/Download');
    // final file = File("${directory!.path}/${DateTime.now().millisecondsSinceEpoch}.pdf");

    // await file.writeAsBytes(await pdf.save());
    log("Save done");
    return pdf;
    // OpenFilex.open(file.path);
  }

  // ____________________________________________________________________   (FacilityDiscountInsert )
  static Future<bool> FacilityDiscountInsert(
      {required String FacilityId,
      required String DiscountAmount,
      required String DiscountStartDate,
      required String DiscountEndDate,
      required String IsDiscount}) async {
    String url =
        'https://wedingappapi.systranstechnology.com/MobApi.asmx/MobileApi?ParmCriteria={"DiscountStartDate":"2025-01-01","DiscountEndDate":"2025-01-31","FacilityId":"$FacilityId","IsDiscount":"$IsDiscount","DiscountAmount":"$DiscountAmount","ApiAdd":"FacilityDiscountInsert","CallBy":"MobileApi","AuthKey":"SYS101"}&OrgID=0061&ApiAdd=FacilityDiscountInsert';
    print(url);
    var res = await http.get(Uri.parse(url));

    if (res.statusCode == 200) {
      log("RecipitFacilityInsert Api Call.............");
      var data = jsonDecode(res.body);
      print(data);
      // H_Questions.clear();
      // H_Questions = jsonDecode(res.body);
      // print(H_Questions);
      return true;
      // city_list = data["Table1"];
    } else {
      log("Error........ RecipitFacilityInsert Api ");
      throw ("Error........ RecipitFacilityInsert Api ");
    }
  }

// _________________________________________________________________________________
  static Future<List<dynamic>> SubscriptionList() async {
    String url =
        'https://wedingappapi.systranstechnology.com/MobApi.asmx/MobileApi?ParmCriteria={"ApiAdd":"SubscriptionList","CallBy":"MobileApi","AuthKey":"SYS101"}&OrgID=0061&ApiAdd=SubscriptionList';
    print(url);
    var res = await http.get(Uri.parse(url));

    if (res.statusCode == 200) {
      log("SubscriptionList Api Call.............");
      var data = jsonDecode(res.body);
      // city_list = data["Table1"];
      log("SubscriptionList Api DATA .............");
      print(data);
      return data["Table1"];
    } else {
      log("Error........ SubscriptionList Api ");
      throw ("Error........ SubscriptionList Api ");
    }
  }

// _________________________________________________________________________________
  static Future<List<dynamic>> Packagelist() async {
    String url =
        'https://wedingappapi.systranstechnology.com/MobApi.asmx/MobileApi?ParmCriteria={"ApiAdd":"Packagelist","CallBy":"MobileApi","AuthKey":"SYS101"}&OrgID=0061&ApiAdd=Packagelist';
    print(url);
    var res = await http.get(Uri.parse(url));

    if (res.statusCode == 200) {
      log("Packagelist Api Call.............");
      var data = jsonDecode(res.body);
      // city_list = data["Table1"];
      log("Packagelist Api DATA .............");
      print(data);
      return data["Table1"];
    } else {
      log("Error........ Packagelist Api ");
      throw ("Error........ Packagelist Api ");
    }
  }

// _________________________________________________________________________________
  static Future<String> SubscriptionInsert(
      {required String PaymentMode,
      required String SubscriberId,
      required String Remarks,
      required String Amount,
      required String TransctionNo,
      required String BankRefNo}) async {
    String url =
        'https://wedingappapi.systranstechnology.com/MobApi.asmx/MobileApi?ParmCriteria={"MemberId":\"${User_info["Table"][0]["Id"].toInt()}\","F_LedgerDr":"-1","PaymentMode":"$PaymentMode","SubscriberId":"$SubscriberId","Remarks":"$Remarks","Amount":"$Amount","TransctionNo":"$TransctionNo","BankRefNo":"$BankRefNo","ApiAdd":"SubscriptionInsert","CallBy":"MobileApi","AuthKey":"SYS101"}&OrgID=0061&ApiAdd=SubscriptionInsert';
    print(url);
    var res = await http.get(Uri.parse(url));

    if (res.statusCode == 200) {
      log("Packagelist Api Call.............");
      var data = jsonDecode(res.body);
      // city_list = data["Table1"];
      log("Packagelist Api DATA .............");
      print(data);
      return data["Table"][0]["ResultCode"];
    } else {
      log("Error........ Packagelist Api ");
      throw ("Error........ Packagelist Api ");
    }
  }

  static Future<Map> get_Merchent_Trem_And_Condition() async {
    String url =
        'https://wedingappapi.systranstechnology.com/MobApi.asmx/MobileApi?ParmCriteria={"MerchantId":\"${User_info["Table"][0]["Id"].toInt()}\","ApiAdd":"MerchentTNC","CallBy":"MobileApi","AuthKey":"SYS101"}&OrgID=0061&ApiAdd=MerchentTNC';
    print(url);
    var res = await http.get(Uri.parse(url));
    if (res.statusCode == 200) {
      log("get_Merchent_Trem_And_Condition Api call.....");
      var data = jsonDecode(res.body);
      TermsAndConditions.clear();
      TermsAndConditions = data;
      return data;
    } else {
      throw "Error:- get_Merchent_Trem_And_Condition";
    }
  }

  // _____________________________________________________________
  static Future<String> downloadAndSaveImage([String imageUrl = ""]) async {
    try {
      // Get the app's documents directory
      final directory = await getTemporaryDirectory();
      final filePath = '${directory.path}/${imageUrl.split('/').last}';

      // Check if the file already exists
      final file = File(filePath);
      if (await file.exists()) {
        return filePath; // Return the existing file path
      }

      // Fetch the image from the URL
      final response = await http.get(Uri.parse(imageUrl));

      // Check if the response was successful
      if (response.statusCode == 200) {
        // Write the image bytes to a file
        await file.writeAsBytes(response.bodyBytes);
        return filePath; // Return the file path
      } else {
        throw Exception('Failed to download image');
      }
    } catch (e) {
      throw Exception('Error downloading image: $e');
    }
  }

  // ____________________________________________________________________   (FacilityDiscountInsert )
  static Future<bool> DeleteImgvideo({
    required String Id,
  }) async {
    String url =
        'https://wedingappapi.systranstechnology.com/MobApi.asmx/MobileApi?ParmCriteria={"ImageId":"$Id","ApiAdd":"DeleteImgvideo","CallBy":"MobileApi","AuthKey":"SYS101"}&OrgID=0061&ApiAdd=DeleteImgvideo';
    print(url);
    var res = await http.get(Uri.parse(url));

    if (res.statusCode == 200) {
      log("RecipitFacilityInsert Api Call.............");
      var data = jsonDecode(res.body);
      print(data);
      return true;
    } else {
      log("Error........ RecipitFacilityInsert Api ");
      throw ("Error........ RecipitFacilityInsert Api ");
    }
  }

  // ____________________________________________________________________   (EventBooking )
  static Future<bool> EventBooking({
    required String EventStartDate,
    required String EventEndDate,
    required String EventStartTime,
    required String EventEndTime,
    required String TotalAmount,
    required String DueAmount,
    required String BookingAmount,
    required String IsBooking,
    required String EventId,
    required String Remarks,
  }) async {
    String url =
        'https://wedingappapi.systranstechnology.com/MobApi.asmx/MobileApi?ParmCriteria={"EventStartDate":"$EventStartDate","EventEndDate":"$EventEndDate","EventStartTime":"$EventStartTime","EventEndTime":"$EventEndTime","TotalAmount":"$TotalAmount","DueAmount":"$DueAmount","BookingAmount":"$BookingAmount","IsBooking":"$IsBooking","EventId":"$EventId","F_VoucherTypeMaster":"1","Remarks":"$Remarks","ApiAdd":"EventBooking","CallBy":"MobileApi","AuthKey":"SYS101"}&OrgID=0061&ApiAdd=EventBooking';
    print(url);
    var res = await http.get(Uri.parse(url));

    if (res.statusCode == 200) {
      log("EventBooking Api Call.............");

      return true;
    } else {
      log("Error........ EventBooking Api ");
      throw ("Error........ EventBooking Api ");
    }
  }

  // ________________________________________________________________________________________
  static Future<void> UpdateProfileImg({required String img}) async {
    //  List<int> imageBytes = await img.readAsBytes();
    //   String base64String = base64Encode(imageBytes);
    String url =
        'https://wedingappapi.systranstechnology.com/MobApi.asmx/MobileApi?ParmCriteria={"ProfileImg":"$img","MerchantId":\"${User_info["Table"][0]["Id"].toInt()}\","ApiAdd":"UpdateProfileImg","CallBy":"MobileApi","AuthKey":"SYS101"}&OrgID=0061&ApiAdd=UpdateProfileImg';
    print(url);
    var res = await http.get(Uri.parse(url));

    if (res.statusCode == 200) {
      log("BannerReport Api Call.............");
      var data = jsonDecode(res.body);
      log("BannerReport Api DATA .............");
      print(data);
      // return data["Table1"];
    } else {
      log("Error........ BannerReport Api ");
      throw ("Error........ BannerReport Api ");
    }
  }
  // ________________________________________________________________________________________
  static Future<void> FacilityUpdate({required String FacilityId,required String FacilityName,required String Amount,required String F_SubServiceCategory}) async {
    //  List<int> imageBytes = await img.readAsBytes();
    //   String base64String = base64Encode(imageBytes);
    String url =
        'https://wedingappapi.systranstechnology.com/MobApi.asmx/MobileApi?ParmCriteria={"FacilityId":"$FacilityId",F_SubServiceCategory:"$F_SubServiceCategory","FacilityName":"$FacilityName","MerchantId":\"${User_info["Table"][0]["Id"].toInt()}\","Amount":"$Amount","ApiAdd":"FacilityUpdate","CallBy":"MobileApi","AuthKey":"SYS101"}&OrgID=0061&ApiAdd=FacilityUpdate';
    print(url);
    var res = await http.get(Uri.parse(url));

    if (res.statusCode == 200) {
      log("FacilityUpdate Api Call.............");
      var data = jsonDecode(res.body);
      log("FacilityUpdate Api DATA .............");
      print(data);
      // return data["Table1"];
    } else {
      log("Error........ FacilityUpdate Api ");
      throw ("Error........ FacilityUpdate Api ");
    }
  }

  // _____________________________________________________________________________________(get logo)
  static Future<void> getLogo({required String url}) async {
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      user_logo = response.bodyBytes;
      log("Get logo Api call ......... Make by me");
    } else {
      print('Failed to fetch the image. Status code: ${response.statusCode}');
      return;
    }
  }
  
  // ____________________________________________________________________   (Show service in event )
  static Future<List<dynamic>> MMDDOrderList() async {
    String url =
        'https://wedingappapi.systranstechnology.com/MobApi.asmx/MobileApi?ParmCriteria={"MerchantId":\"${User_info["Table"][0]["Id"].toInt()}\","ApiAdd":"MMDDOrderList","CallBy":"MobileApi","AuthKey":"SYS101"}&OrgID=0061&ApiAdd=MMDDOrderList';
    print(url);
    var res = await http.get(Uri.parse(url));

    if (res.statusCode == 200) {
      log("MMDDOrderList Api Call.............");
      var data = jsonDecode(res.body);
      log("MMDDOrderList Api DATA .............");
      print(data);
      return data["Table1"];
    } else {
      log("Error........ MMDDOrderList Api ");
      throw ("Error........ MMDDOrderList Api ");
    }
  }
// ______________________________________________________________________________   ( social account api)
static Future<void> AddSocialAccount({required String FacebookLink,required String InstagramLink,required String YouTudeLink,}) async {
    //  List<int> imageBytes = await img.readAsBytes();
    //   String base64String = base64Encode(imageBytes);
    String url =
        'https://wedingappapi.systranstechnology.com/MobApi.asmx/MobileApi?ParmCriteria={"FacebookLink":"$FacebookLink","InstagramLink":"$InstagramLink","YouTudeLink":"$YouTudeLink","MerchantId":\"${User_info["Table"][0]["Id"].toInt()}\","ApiAdd":"AddSocialAccount","CallBy":"MobileApi","AuthKey":"SYS101"}&OrgID=0061&ApiAdd=AddSocialAccount';
    print(url);
    var res = await http.get(Uri.parse(url));

    if (res.statusCode == 200) {
      log("AddSocialAccount Api Call.............");
      var data = jsonDecode(res.body);
      log("AddSocialAccount Api DATA .............");
      print(data);
      // return data["Table1"];
    } else {
      log("Error........ AddSocialAccount Api ");
      throw ("Error........ AddSocialAccount Api ");
    }
  }

}

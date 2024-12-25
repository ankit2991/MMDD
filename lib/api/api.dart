import "dart:convert";
import "dart:developer";
import "dart:io";
import "dart:typed_data";
import "package:flutter/material.dart";
import "package:flutter/rendering.dart";
import "package:flutter/services.dart";
import 'package:geolocator/geolocator.dart';
import "package:image_picker/image_picker.dart";
import "package:open_filex/open_filex.dart";
import "package:path_provider/path_provider.dart";
import 'package:shared_preferences/shared_preferences.dart';
import "package:http/http.dart" as http;
import 'dart:ui' as ui;

class Api {
  static List<dynamic> CategoryList_data = [];
  static List<dynamic> Sub_CategoryList_data = [];
  static List<dynamic> state_list = [];
  static List<dynamic> city_list = [];
  static var User_info;
  static Map<String, dynamic> H_Questions={};
  static late SharedPreferences prefs ;
  static Future<void> local_dataBase()async{
    prefs= await SharedPreferences.getInstance();
  }
  // -------------------------------------------------------------------------------------------  (send OTP)
  static Future<void> send_otp(String mob_no) async {
    // String url='https://wedingappapi.systranstechnology.com/MobApi.asmx/MobileApi?ParmCriteria={"MobileNo":'"'$mob_no'"',"ApiAdd":"MobileOTP","CallBy":"MobileApi","AuthKey":"SYS101"}&OrgID=0061&ApiAdd=MobileOtp';
    String url =
        'https://wedingappapi.systranstechnology.com/MobApi.asmx/MobileApi?ParmCriteria={"MobileNo":'
        "'$mob_no'"
        ',"ApiAdd":"MobileOTP","CallBy":"MobileApi","AuthKey":"SYS101"}&OrgID=0061&ApiAdd=MobileOTP';
    var res = await http.get(Uri.parse(url));
    if (res.statusCode == 200) {
      print(res.body);
      // var data= jsonDecode(res.body);
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
      if (data["Table1"][0]["IsRegister"] == 0) {
        return false;
      } else {
        return true;
      }
    } else {
      log("Error........check mobile number regesterd or not API ");
      return false;
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
    var res = await http.get(Uri.parse(url));
    if (res.statusCode == 200) {
      log("Check Mpin Api Call.............");
      print(res);
      print(res.body);
      
      var data = jsonDecode(res.body);
      User_info=data;
      
      await prefs.setBool('login',true);
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

  static Future<Position> get_loc() async {
    bool serviceEnable = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnable) {
      Geolocator.openLocationSettings();
      return Future.error("Location services are disabled.");
    }
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error("Location permissions are denied");
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          "Location Permission are permanently denied, we cannot request");
    }
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
        'https://wedingappapi.systranstechnology.com/MobApi.asmx/MobileApi?ParmCriteria={"MemberMasterId":'"\"${User_info["Table"][0]["Id"].toInt()}\""',"ServiceId":'"'${User_info["Table"][0]["ServiceID"]}'"',"IsHindi":"${prefs.getInt("is_Hindi")}","ApiAdd":"ServiceQuestionList","CallBy":"MobileApi","AuthKey":"SYS101"}&OrgID=0061&ApiAdd=ServiceQuestionList';
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
  static Future<void> MerchantAnswareInsert({required int Q_id,required String Question,String Answer1 ="",String Answer2="",String Answer3="",String Answer4="",String Answer5="",String Answer6="",String Answer7=""}) async {
    String url =
        'https://wedingappapi.systranstechnology.com/MobApi.asmx/MobileApi?ParmCriteria={"F_MemberMaster":'"\"${User_info["Table"][0]["Id"].toInt()}\""',"F_ServiceCatagory":'"\"${User_info["Table"][0]["ServiceID"]}\""',"F_ServiceQuestionMaster":'"\"$Q_id\""',"Question":'"\"$Question\""',"Answer1":'"\"$Answer1\""',"Answer2":'"\"$Answer2\""',"Answer3":'"\"$Answer3\""',"Answer4":'"\"$Answer4\""',"Answer5":'"\"$Answer5\""',"Answer6":'"\"$Answer6\""',"Answer7":'"\"$Answer7\""',"ApiAdd":"MerchantAnswareInsert","CallBy":"MobileApi","AuthKey":"SYS101"}&OrgID=0061&ApiAdd=MerchantAnswareInsert';
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
  static Future<List<dynamic>> EventBookingDetailsList({required String Which_APIcall_CompleteEvent_UpcomingEvent_TodayEvent ,required String Is_booking}) async {
    String url =
        'https://wedingappapi.systranstechnology.com/MobApi.asmx/MobileApi?ParmCriteria={"EventList":'"'$Which_APIcall_CompleteEvent_UpcomingEvent_TodayEvent'"',"MerchantId":'"\"${User_info["Table"][0]["Id"].toInt()}\""',"IsBooking":'"'$Is_booking'"',"MerchantId":'"\"${User_info["Table"][0]["Id"].toInt()}\""',"ApiAdd":"EventBookingDetailsList","CallBy":"MobileApi","AuthKey":"SYS101"}&OrgID=0061&ApiAdd=EventBookingDetailsList';
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
      throw("Error........ EventBookingDetailsList Api ");
    }
  }
 // ____________________________________________________________________   ( Event Booking Details List  )
  static Future<void> RecipitInsert({required String Amount,required String Event_id,required String Remark}) async {
    String url =
        'https://wedingappapi.systranstechnology.com/MobApi.asmx/MobileApi?ParmCriteria={"Amount":\"$Amount\","EventId":\"$Event_id\","F_VoucherTypeMaster":"1","F_LedgerDr":\"$Event_id\","F_LedgerCr":'"\"${User_info["Table"][0]["Id"].toInt()}\""',"Remarks":\"$Remark\","ApiAdd":"RecipitInsert","CallBy":"MobileApi","AuthKey":"SYS101"}&OrgID=0061&ApiAdd=RecipitInsert';
   print(url);
    var res = await http.get(Uri.parse(url));
    
    if (res.statusCode == 200) {
      log("RecipitInsert Api Call.............");
      var data = jsonDecode(res.body);
      // city_list = data["Table1"];
      log("RecipitInsert Api DATA .............");
      // print(data);
      // return data["Table1"];
    } else {
      log("Error........ RecipitInsert Api ");
      throw("Error........ RecipitInsert Api ");
    }
  }

  
 // ____________________________________________________________________   (Show service in event )
  static Future<List<dynamic>> FacilityReport() async {
    String url =
        'https://wedingappapi.systranstechnology.com/MobApi.asmx/MobileApi?ParmCriteria={"MerchantId":'"\"${User_info["Table"][0]["Id"].toInt()}\""',"ApiAdd":"FacilityReport","CallBy":"MobileApi","AuthKey":"SYS101"}&OrgID=0061&ApiAdd=FacilityReport';
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
      throw("Error........ FacilityReport Api ");
    }
  }
  
 // ____________________________________________________________________   (All images )
  static Future<List<dynamic>> AccountDocument() async {
    String url =
        'https://wedingappapi.systranstechnology.com/MobApi.asmx/MobileApi?ParmCriteria={"AccountId":'"\"${User_info["Table"][0]["Id"].toInt()}\""',"ApiAdd":"AccountDocument","CallBy":"MobileApi","AuthKey":"SYS101"}&OrgID=0061&ApiAdd=AccountDocument';
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
      throw("Error........ AccountDocument Api ");
    }
  }
  
 // ____________________________________________________________________   (ImageInsert )
  static Future<void> ImageInsert({required File ?img,required String DocType,required String ext}) async {
    String url =
        'https://wedingappapi.systranstechnology.com/MobApi.asmx/UploadFile2';
   print("=================================================================================");
   print(url);
  final headers = {
      'Content-Type': 'application/json',
    };
      var request = http.MultipartRequest('POST', Uri.parse(url));
       request.files.add(
        await http.MultipartFile.fromPath(
          "base64", // Field name expected by the API
          img!.path,
        ),
      );
      request.fields["AccountId"] ="${User_info["Table"][0]["Id"].toInt()}";
      request.fields["DocType"] = DocType;
      request.fields["fileExtention"] = ext;
      var res= await request.send();    
    if (res.statusCode == 200) {
      log("ImageInsert Api Call.............");
      var data =  await res.stream.bytesToString();;
      log("ImageInsert Api DATA .............");
      print(data);
      // return data["Table1"];
    } else {
      log("Error........ FacilityReport Api ");
      throw("Error........ FacilityReport Api ");
    }
  }

  
  // ____________________________________________________________________   (add service in event )
  static Future<bool> RecipitFacilityInsert({required List<Map> serviceAdd,required String EventId ,required String Amount,required String Remarks}) async {
    String url =
        'https://wedingappapi.systranstechnology.com/MobApi.asmx/MobileApi?ParmCriteria={"Amount":"${double.parse(Amount).toInt()}","EventId":"${double.parse(EventId).toInt()}","F_VoucherTypeMaster":"1","F_LedgerDr":\"${double.parse(EventId).toInt()}\","F_LedgerCr":'"\"${User_info["Table"][0]["Id"].toInt()}\""',"RequestJson":{"Services":$serviceAdd},"Remarks":"$Remarks","ApiAdd":"RecipitFacilityInsert","CallBy":"MobileApi","AuthKey":"SYS101"}&OrgID=0061&ApiAdd=RecipitFacilityInsert';
   print(url);
    var res = await http.get(Uri.parse(url));
    
    if (res.statusCode == 200) {
      log("RecipitFacilityInsert Api Call.............");
      H_Questions.clear();
      H_Questions = jsonDecode(res.body);
      print(H_Questions);
      return true;
      // city_list = data["Table1"];
    } else {
      log("Error........ RecipitFacilityInsert Api ");
      throw("Error........ RecipitFacilityInsert Api ");
    }
  }
  // ____________________________________________________________________   (MerchentLicanceDetail  )
  static Future<bool> MerchentLicanceDetail({required String FassiLicNo ,required String Gst,required String nigamlicanceNo}) async {
    String url =
        'https://wedingappapi.systranstechnology.com/MobApi.asmx/MobileApi?ParmCriteria={"FassiLicNo":\"$FassiLicNo\","nigamlicanceNo":\"$nigamlicanceNo\","GSTNo":\"$Gst\","MemberId":'"\"${User_info["Table"][0]["Id"].toInt()}\""',"ApiAdd":"MerchentLicanceDetail","CallBy":"MobileApi","AuthKey":"SYS101"}&OrgID=0061&ApiAdd=MerchentLicanceDetail';
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
      throw("Error........ MerchentLicanceDetail Api ");
    }
  }
  // ____________________________________________________________________   (Merchent Bank Detail  )
  static Future<bool> MerchentBankDetail({required String Mer_AcHolderName ,required String Mer_bankAcc,required String Mer_IFSCCode,required String Mer_bankName}) async {
    String url =
        'https://wedingappapi.systranstechnology.com/MobApi.asmx/MobileApi?ParmCriteria={"Mer_AcHolderName":\"$Mer_AcHolderName\","Mer_bankAcc":\"$Mer_bankAcc\","Mer_IFSCCode":\"$Mer_IFSCCode\","Mer_bankName":\"$Mer_bankName\","ApiAdd":"MerchentBankDetail","MemberId":"242","CallBy":"MobileApi","AuthKey":"SYS101"}&OrgID=0061&ApiAdd=MerchentBankDetail';
   print(url);
    var res = await http.get(Uri.parse(url));
    
    if (res.statusCode == 200) {
      log("MerchentBankDetail Api Call.............");
     
      var data = jsonDecode(res.body);
      print(data);
      return true;
      // city_list = data["Table1"];
    } else {
      log("Error........ MerchentBankDetail Api ");
      throw("Error........ MerchentBankDetail Api ");
    }
  }
  // ____________________________________________________________________   (add service in event )
  static Future<bool> CustomerRegistration({required String Mobile,required String CName ,required String Email,required String Remarks,required String EventName,required String Longitude,required String Latitude,required String EventAddress,required String EventEndDate, required String Isbooking ,required String EventStartDate,required String EventStartTime,required String EventEndTime,required String TotalAmount,required String BookingAmount,required String DueAmount,}) async {
    String url =
        'https://wedingappapi.systranstechnology.com/MobApi.asmx/MobileApi?ParmCriteria={"Mobile":"$Mobile","CName":"$CName","Email":"$Email","ServiceId":"0","MerchantId":'"\"${User_info["Table"][0]["Id"].toInt()}\""',"Isbooking":"$Isbooking","EventName":"$EventName","Longitude":"$Longitude","Latitude":"$Latitude","EventAddress":"$EventAddress","EventStartDate":"$EventStartDate","EventEndDate":"$EventEndDate","EventStartTime":"$EventStartTime","EventEndTime":"$EventEndTime","TotalAmount":"$TotalAmount","BookingAmount":"$BookingAmount","DueAmount":"$DueAmount","Remarks":"$Remarks","F_VoucherTypeMaster":"1","ApiAdd":"CustomerRegistration","CallBy":"MobileApi","AuthKey":"SYS101"}&OrgID=0061&ApiAdd=CustomerRegistration';
   print(url);
    var res = await http.get(Uri.parse(url));
    
    if (res.statusCode == 200) {
      log("RecipitFacilityInsert Api Call.............");
      H_Questions.clear();
      H_Questions = jsonDecode(res.body);
      print(H_Questions);
      return true;
      // city_list = data["Table1"];
    } else {
      log("Error........ RecipitFacilityInsert Api ");
      throw("Error........ RecipitFacilityInsert Api ");
    }
  }
  // -------------------------------------------------------------- (send Image )
 static Future<Map<String,dynamic>> pickImage({required ImageSource source,required bool img}) async {
  final ImagePicker _picker = ImagePicker();
    final XFile? pickedFile =img? await _picker.pickImage(source: source):await _picker.pickVideo(source: source);
    if (pickedFile != null) {
      print(pickedFile.path);
      String ext=pickedFile.path.split(".").last;
       return {"file": File(pickedFile.path),
                "ext":ext,
       };
    }
    return{"file":"","ext":""};
  }
 static Future<String> img_convert(File? img)async{
        final File imageFile = File(img!.path);
    final bytes = await imageFile.readAsBytes();
    final String base64Image = base64Encode(bytes);
    print(base64Image);
    return base64Image;
  }
  // __________________________________________________________________   ( download PDF )
  static Future<File?> downloadPdf({required String url,required String fileName}) async {
    try {
      // Send HTTP request to get the file
      final response = await http.get(Uri.parse(url));
      String ?directorys ;
      if (response.statusCode == 200) {
        // Get the app's directory for storing files
         if (Platform.isAndroid) {
      // Use the external storage directory for Android
      final directory = Directory('/storage/emulated/0/Download');
      if (await directory.exists()) {
        directorys=directory.path;
      } else {
        var temp= await getDownloadsDirectory(); 
       directorys=temp!.path;
      }
    } else if (Platform.isIOS) {
      // Use the app's documents directory for iOS (iOS doesn't have a shared Downloads folder)
      final directory = await getApplicationDocumentsDirectory();
      directorys= directory.path;
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
        throw("Failed to download file. HTTP Status: ${response.statusCode}");
        
      }
    } catch (e) {
      print("Error downloading file: $e");
    }
  }
  // _________________________________________________________________________________________
  static Future<File?> widget_to_img(final GlobalKey _globalKey)async{
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
 static Future<void> moveFileToLocalStorage() async {
    try {
      // Load the file from the assets folder
      final byteData = await rootBundle.load('assets/images/main/dummy.pdf');

      // Get the local directory path
      String ?directorys ;
    if (Platform.isAndroid) {
      // Use the external storage directory for Android
      final directory = Directory('/storage/emulated/0/Download');
      if (await directory.exists()) {
        directorys=directory.path;
      } else {
        var temp= await getDownloadsDirectory(); 
       directorys=temp!.path;
      }
    } else if (Platform.isIOS) {
      // Use the app's documents directory for iOS (iOS doesn't have a shared Downloads folder)
      final directory = await getApplicationDocumentsDirectory();
      directorys= directory.path;
    }
      // Create the file in the local storage
      final file = File('${directorys}/sample.pdf');

      // Write the byte data to the file
      await file.writeAsBytes(byteData.buffer.asUint8List(
        byteData.offsetInBytes,
        byteData.lengthInBytes,
      ));

      print('File moved to: ${file.path}');
    } catch (e) {
      print('Error moving file: $e');
    }
  }
}

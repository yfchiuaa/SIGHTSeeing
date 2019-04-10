import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

//// Classes for vision and optomatry

/*
  # Function that will take the body as a map and POST it to the server as json format
  @parameter
  body: the body of the content that is needed to be posted  as the format of map
  @return
  http.post
*/
Future<VisionTest> createVisionTest({Map body}) async {
  String url = 'http://localhost:3030/check-record';

  return http.post(url, body: body).then((http.Response response) {
    final int statusCode = response.statusCode;
 
    if (statusCode < 200 || statusCode > 400 || json == null) {
      throw new Exception("Error while fetching data");
    }
    return VisionTest.fromJson(json.decode(response.body));
  });
}

class VisionTest{
  final String patient_id;
  final String left_vision_livingEyeSight;
  final String right_vision_livingEyeSight;
  final String left_vision_bareEyeSight;
  final String right_vision_bareEyeSight;
  final String left_vision_eyeGlasses;
  final String right_vision_eyeGlasses;
  final String left_vision_bestEyeSight;
  final String right_vision_bestEyeSight;

  VisionTest({this.left_vision_livingEyeSight, this.right_vision_livingEyeSight, this.left_vision_bareEyeSight, this.right_vision_bareEyeSight, this.left_vision_eyeGlasses, this.right_vision_eyeGlasses, this.left_vision_bestEyeSight, this.right_vision_bestEyeSight, this.patient_id});

  factory VisionTest.fromJson(Map<String, dynamic> json){
    return VisionTest(
      patient_id: json['patient_id'],

      left_vision_livingEyeSight: json['left_vision_livingEyeSight'],
      left_vision_bareEyeSight: json['left_vision_bareEyeSight'],
      left_vision_eyeGlasses: json['left_vision_eyeGlasses'],
      left_vision_bestEyeSight: json['left_vision_bestEyeSight'],

      right_vision_livingEyeSight: json['right_vision_livingEyeSight'],
      right_vision_bareEyeSight: json['right_vision_bareEyeSight'],
      right_vision_eyeGlasses: json['right_vision_eyeGlasses'],
      right_vision_bestEyeSight: json['right_vision_bestEyeSight']
    );
  }

  Map toMap(){
    var map = new Map<String, dynamic>();
    map['patient_id'] = patient_id;

    map['left_vision_livingEyeSight'] = left_vision_livingEyeSight;
    map['left_vision_bareEyeSight'] = left_vision_bareEyeSight;
    map['left_vision_eyeGlasses'] = left_vision_eyeGlasses;
    map['left_vision_bestEyeSight'] = left_vision_bestEyeSight;

    map['right_vision_livingEyeSight'] = right_vision_livingEyeSight;
    map['right_vision_bareEyeSight'] = right_vision_bareEyeSight;
    map['right_vision_eyeGlasses'] = right_vision_eyeGlasses;
    map['right_vision_bestEyeSight'] = right_vision_bestEyeSight;

    return map;
  }
}

Future<OptTest> createOptTest({Map body}) async {
  String url = 'http://localhost:3030/check-record';

  return http.post(url, body: body).then((http.Response response) {
    final int statusCode = response.statusCode;
 
    if (statusCode < 200 || statusCode > 400 || json == null){
      throw new Exception("Error while fetching data");
    }
    return OptTest.fromJson(json.decode(response.body));
  });
}

class OptTest{
  final String patient_id;
  final String opto_diopter; 
  final String opto_astigmatism;
  final String opto_astigmatismaxis;

  OptTest({this.opto_diopter, this.opto_astigmatism, this.opto_astigmatismaxis, this.patient_id});

  factory OptTest.fromJson(Map<String, dynamic> json){
    return OptTest(
      patient_id: json['patient_id'],
      opto_diopter: json['opto_diopter'],
      opto_astigmatism: json['opto_astigmatism'],
      opto_astigmatismaxis: json['opto_astigmatismaxis'],
    );
  }

  Map toMap(){
    var map = new Map<String, dynamic>();
    map['patient_id'] = patient_id;
    map['opto_diopter'] = opto_diopter;
    map['opto_astigmatism'] = opto_astigmatism;
    map['opto_astigmatismaxis'] = opto_astigmatismaxis;

    return map;
  }
  
}

//// Classes for patient data

/*
  # The function that will make use of the http.get method to do GET operation
*/
Future<BasicInfo> getBasicInfo() async{
  String url = 'http://localhost:3030/students';
  final response = await http.get(url, headers: {"Accept": "application/json"});

  if (response.statusCode == 200) {
      return BasicInfo.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load post');
    }
}

/*
  The class contains all the information needed in the basic information section
*/
class BasicInfo{
  final String name;
  final String number;
  final String sex;
  final String birth;

  BasicInfo({this.name, this.number,this.sex, this.birth});

  // Method that take a 
  factory BasicInfo.fromJson(Map<String, dynamic> json) {
    return BasicInfo(
        name: json['data'][0]['studentName'],
        number: json['data'][0]['studentNumber'],
        sex: json['data'][0]['studentSex'],
        birth: json['data'][0]['studentBirth'],
    );
  }
}

Future<CheckInfo> getCheckInfo(bool isLeft) async{
  String url = 'http://localhost:3030/check-record';
  final response = await http.get(url, headers: {"Accept": "application/json"});

  if (response.statusCode == 200) {
      return CheckInfo.fromJson(json.decode(response.body), isLeft);
    } else {
      throw Exception('Failed to load post');
    }
}

class CheckInfo{
  final String vision_livingEyeSight;
  final String vision_bareEyeSight;
  final String vision_eyeGlasses;
  final String vision_bestEyeSight;
  final String opto_diopter;
  final String opto_astigmatism;
  final String opto_astigmatismaxis;

  CheckInfo({this.vision_livingEyeSight, this.vision_bareEyeSight, this.vision_eyeGlasses, this.vision_bestEyeSight, this.opto_diopter, this.opto_astigmatism, this.opto_astigmatismaxis});

  factory CheckInfo.fromJson(Map<String, dynamic> json, bool isLeft) {
    if (isLeft){
      return CheckInfo(
        vision_livingEyeSight: json['data'][0]['left_vision_livingEyeSight'],
        vision_bareEyeSight: json['data'][0]['left_vision_bareEyeSight'],
        vision_eyeGlasses: json['data'][0]['left_vision_eyeGlasses'],
        vision_bestEyeSight: json['data'][0]['left_vision_bestEyeSight'],
        opto_diopter: json['data'][0]['left_opto_diopter'],
        opto_astigmatism: json['data'][0]['left_opto_astigmatism'],
        opto_astigmatismaxis: json['data'][0]['left_opto_astigmatismaxis']
      );
    }
    else{
      return CheckInfo(
        vision_livingEyeSight: json['data'][0]['right_result']['vision_livingEyeSight'],
        vision_bareEyeSight: json['data'][0]['right_vision_bareEyeSight'],
        vision_eyeGlasses: json['data'][0]['right_vision_eyeGlasses'],
        vision_bestEyeSight: json['data'][0]['right_vision_bestEyeSight'],
        opto_diopter: json['data'][0]['right_opto_diopter'],
        opto_astigmatism: json['data'][0]['right_opto_astigmatism'],
        opto_astigmatismaxis: json['data'][0]['right_opto_astigmatismaxis']
      );
    }
  }
}
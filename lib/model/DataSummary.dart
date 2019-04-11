import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';


const URL_STU = 'http://localhost:3030/students';
const URL_RECORD = 'http://localhost:3030/check-record';

/*
  # The function that will make use of the http.get method to do GET operation
*/
Future<BasicInfo> getBasicInfo(String patientID) async{
  final response = await http.get('${URL_STU}?studentNumber=${patientID}', headers: {"Accept": "application/json"});

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

Future<CheckInfo> getCheckInfo(bool isLeft, String patientID) async{
  final response = await http.get('${URL_RECORD}?patient_id=${patientID}', headers: {"Accept": "application/json"});

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
  final String slit_eyelid;
  final String slit_conjunctiva;
  final String slit_cornea;
  final String slit_lens;
  final String slit_Hirschbergtest;
  final String slit_exchange;
  final String slit_eyeballshivering;
  

  CheckInfo({this.vision_livingEyeSight, this.vision_bareEyeSight, this.vision_eyeGlasses, this.vision_bestEyeSight, this.opto_diopter, this.opto_astigmatism, this.opto_astigmatismaxis, this.slit_conjunctiva, this.slit_cornea, this.slit_exchange, this.slit_eyeballshivering, this.slit_eyelid, this.slit_Hirschbergtest, this.slit_lens});

  factory CheckInfo.fromJson(Map<String, dynamic> json, bool isLeft) {
    if (isLeft){
      return CheckInfo(
        vision_livingEyeSight: json['data'][0]['left_vision_livingEyeSight'],
        vision_bareEyeSight: json['data'][0]['left_vision_bareEyeSight'],
        vision_eyeGlasses: json['data'][0]['left_vision_eyeGlasses'],
        vision_bestEyeSight: json['data'][0]['left_vision_bestEyeSight'],
        opto_diopter: json['data'][0]['left_opto_diopter'],
        opto_astigmatism: json['data'][0]['left_opto_astigmatism'],
        opto_astigmatismaxis: json['data'][0]['left_opto_astigmatismaxis'],
        slit_cornea: json['data'][0]['left_slit_cornea'],
        slit_conjunctiva: json['data'][0]['left_slit_conjunctiva'],
        slit_eyelid: json['data'][0]['left_slit_eyelid'],
        slit_Hirschbergtest: json['data'][0]['left_slit_Hirschbergtest'],
        slit_lens: json['data'][0]['left_slit_lens']
        //// TODO: Add the slit_exchage and slit_eyeball
      );
    }
    else{
      return CheckInfo(
        vision_livingEyeSight: json['data'][0]['right_vision_livingEyeSight'],
        vision_bareEyeSight: json['data'][0]['right_vision_bareEyeSight'],
        vision_eyeGlasses: json['data'][0]['right_vision_eyeGlasses'],
        vision_bestEyeSight: json['data'][0]['right_vision_bestEyeSight'],
        opto_diopter: json['data'][0]['right_opto_diopter'],
        opto_astigmatism: json['data'][0]['right_opto_astigmatism'],
        opto_astigmatismaxis: json['data'][0]['right_opto_astigmatismaxis'],
        slit_conjunctiva: json['data'][0]['right_slit_conjunctiva'],
        slit_cornea: json['data'][0]['right_slit_cornea'],
        slit_eyelid: json['data'][0]['right_slit_eyelid'],
        slit_Hirschbergtest: json['data'][0]['right_slit_Hirschbergtest'],
        slit_lens: json['data'][0]['right_slit_lens']
      );
    }
  }
}
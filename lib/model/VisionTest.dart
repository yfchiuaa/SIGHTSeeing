import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

const URL_RECORD = 'http://localhost:3030/check-record';

/*
  # Function that will take the body as a map and POST it to the server as json format
  @parameter
  patientID: the patient ID of the taget that we want to write data to
  body: the body of the content that is needed to be posted  as the format of map
  @return
  http.post
*/
Future<VisionTest> createVisionTest(String patientID, Map body) async {
  final response = await http.patch('${URL_RECORD}?patient_id=${patientID}', body: body);

  if (response.statusCode == 200) {
    return VisionTest.fromJson(json.decode(response.body));
  } else {
    throw Exception('Failed to update a Task');
  } 
}

class VisionTest{
  //final String patient_id;
  final String left_vision_livingEyeSight;
  final String right_vision_livingEyeSight;
  final String left_vision_bareEyeSight;
  final String right_vision_bareEyeSight;
  final String left_vision_eyeGlasses;
  final String right_vision_eyeGlasses;
  final String left_vision_bestEyeSight;
  final String right_vision_bestEyeSight;

  VisionTest({this.left_vision_livingEyeSight, this.right_vision_livingEyeSight, this.left_vision_bareEyeSight, this.right_vision_bareEyeSight, this.left_vision_eyeGlasses, this.right_vision_eyeGlasses, this.left_vision_bestEyeSight, this.right_vision_bestEyeSight});

  // Convert the json of the content of the http response to a VisionTest object
  factory VisionTest.fromJson(Map<String, dynamic> json){
    return VisionTest(
      //patient_id: json['patient_id'],

      left_vision_livingEyeSight: json['data'][0]['left_vision_livingEyeSight'],
      left_vision_bareEyeSight: json['data'][0]['left_vision_bareEyeSight'],
      left_vision_eyeGlasses: json['data'][0]['left_vision_eyeGlasses'],
      left_vision_bestEyeSight: json['data'][0]['left_vision_bestEyeSight'],

      right_vision_livingEyeSight: json['data'][0]['right_vision_livingEyeSight'],
      right_vision_bareEyeSight: json['data'][0]['right_vision_bareEyeSight'],
      right_vision_eyeGlasses: json['data'][0]['right_vision_eyeGlasses'],
      right_vision_bestEyeSight: json['data'][0]['right_vision_bestEyeSight']
    );
  }

  // Convert the content of the VisionTest object into a map
  Map toMap(){
    var map = new Map<String, dynamic>();
    //map['patient_id'] = patient_id;

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
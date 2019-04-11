import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

const URL_RECORD = 'http://localhost:3030/check-record';

Future<SlitlampTest> createSlitLampTest(String patientID, Map body) async{
  return http.patch('${URL_RECORD}?patient_id=${patientID}', body: body).then((http.Response response){
    final int statusCode = response.statusCode;

    if (statusCode < 200 || statusCode > 400 || json == null){
      throw new Exception("Error while fetching data");
    }
    return SlitlampTest.fromJson(json.decode(response.body));
  });
}

class SlitlampTest{
  final String left_slit_eyelid;
  final String right_slit_eyelid;
  final String left_slit_conjunctiva;
  final String right_slit_conjunctiva;
  final String left_slit_cornea;
  final String right_slit_cornea;
  final String left_slit_lens;
  final String right_slit_lens;
  final String left_slit_Hirschbergtest;
  final String right_slit_Hirschbergtest;
  final String slit_exchange;
  final String slit_eyeballshivering;
  
  SlitlampTest({this.left_slit_conjunctiva, this.left_slit_cornea, this.left_slit_eyelid, this.left_slit_Hirschbergtest, this.left_slit_lens, this.right_slit_conjunctiva, this.right_slit_cornea, this.right_slit_eyelid, this.right_slit_Hirschbergtest, this.right_slit_lens, this.slit_exchange, this.slit_eyeballshivering});

  factory SlitlampTest.fromJson(Map<String, dynamic> json){
    return SlitlampTest(
      left_slit_eyelid: json['data'][0]['left_slit_eyelid'],
      right_slit_eyelid: json['data'][0]['right_slit_eyelid'],
      left_slit_conjunctiva: json['data'][0]['left_slit_conjunctiva'],
      right_slit_conjunctiva: json['data'][0]['right_slit_conjunctiva'],
      left_slit_cornea: json['data'][0]['left_slit_cornea'],
      right_slit_cornea: json['data'][0]['right_slit_cornea'],
      left_slit_lens: json['data'][0]['left_slit_lens'],
      right_slit_lens: json['data'][0]['right_slit_lens'],
      left_slit_Hirschbergtest: json['data'][0]['left_slit_Hirschbergtest'],
      right_slit_Hirschbergtest: json['data'][0]['right_slit_Hirschbergtest'],
      slit_exchange: json['data'][0]['slit_exchange'],
      slit_eyeballshivering: json['data'][0]['slit_eyeballshivering']
    );
  }

  Map toMap(){
    var map = new Map<String, dynamic>();
    map['left_slit_eyelid'] = left_slit_eyelid;
    map['right_slit_eyelid'] = right_slit_eyelid;
    map['left_slit_conjunctiva'] = left_slit_conjunctiva;
    map['right_slit_conjunctiva'] = right_slit_conjunctiva;
    map['left_slit_cornea'] = left_slit_cornea;
    map['right_slit_cornea'] = right_slit_cornea;
    map['left_slit_lens'] = left_slit_lens;
    map['right_slit_lens'] = right_slit_lens;
    map['left_slit_Hirschbergtest'] = left_slit_Hirschbergtest;
    map['right_slit_Hirschbergtest'] = right_slit_Hirschbergtest;
    map['slit_exchange'] = slit_exchange;
    map['slit_eyeballshivering'] = slit_eyeballshivering;

    return map;
  }
}
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

const URL_RECORD = 'http://localhost:3030/check-record';

Future<ConsultRecord> createConsultRecord(String patientID, Map body) async{
   return http.patch('${URL_RECORD}?patient_id=${patientID}', body: body).then((http.Response response){
    final int statusCode = response.statusCode;

    if (statusCode < 200 || statusCode > 400 || json == null){
      throw new Exception("Error while fetching data");
    }
    return ConsultRecord.fromJson(json.decode(response.body));
  });
}

class ConsultRecord{
  final String problmes;
  final String handle;
  final String furtherreview;
  final String furtheropt;

  ConsultRecord({this.problmes, this.handle, this.furtheropt, this.furtherreview});

  factory ConsultRecord.fromJson(Map<String, dynamic> json){
    return ConsultRecord(
      problmes: json['data'][0]['problems'],
      handle: json['data'][0]['handle'],
      furtherreview: json['data'][0]['furtherreview'],
      furtheropt: json['data'][0]['furtheropt']
    );
  }

  Map toMap(){
    var map = new Map<String, dynamic>();
    map['problems'] = problmes;
    map['handle'] = handle;
    map['furtheropt'] = furtheropt;
    map['furtherreview'] = furtherreview;

    return map;
  }
}
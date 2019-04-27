import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

const URL_RECORD = 'https://api.sightseeing.projects.sight.ust.hk/check-record';

//const URL_RECORD = '';


Future<ConsultRecord> createConsultRecord(String patientID, Map body) async{
   return http.patch('${URL_RECORD}?patient_id=${patientID}', body: body).then((http.Response response){
    final int statusCode = response.statusCode;

    if (statusCode < 200 || statusCode > 400 || json == null){
      throw new Exception("Error while fetching data");
    }
    final rep = json.decode(response.body);
    final repJson = rep[0];
    return ConsultRecord.fromJson(repJson);
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
      problmes: json['problems'],
      handle: json['handle'],
      furtherreview: json['furtherreview'],
      furtheropt: json['furtheropt']
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

// Updated

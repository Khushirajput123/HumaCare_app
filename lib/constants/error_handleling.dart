import 'dart:convert';


import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:huma_care/constants/util.dart';


void httpErrorHandle({ // for every request we are going to use this
  required http.Response response, // required http response 
  required BuildContext context, // need to Buildcontext so that we can return snackbar
  required VoidCallback onSuccess, // it means function()??
}) {
  switch (response.statusCode) { // based on the statuscode are judgeing that request has error , some warning and succcesss
    case 200:
      onSuccess();
      break;
    case 400:
      showSnackBar(context, jsonDecode(response.body)['msg']); // because when we go to auth.js file we are going msg when status cod is 400
      break;
    case 500:
      showSnackBar(context, jsonDecode(response.body)['error']);
      break;
    default:
      showSnackBar(context, response.body);
  }
}

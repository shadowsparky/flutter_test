import 'package:flutter_app/GetPojo.dart';

class AddressPojo {
  final String street;
  final String suite;
  final String city;
  final String zipcode;
  final GeoPojo geo;

  AddressPojo(this.street, this.suite, this.city, this.zipcode, this.geo);
}
import 'package:flutter_app/AddressPojo.dart';
import 'package:flutter_app/GetPojo.dart';

class Pojo {
  final int id;
  final String name;
  final String username;
  final String email;
  final AddressPojo address;
  final String phone;
  final String website;

  Pojo({this.id, this.name, this.username, this.email, this.address, this.phone, this.website});

  static List<Pojo> fromJsonList(List<dynamic> data) {
    var result = new List<Pojo>();
    for (int i = 0; i < data.length - 1; i++) {
      result.add(Pojo.fromJson(data[i]));
    }
    return result; 
  }

  factory Pojo.fromJson(Map<String, dynamic> json) {
    return Pojo(
      id: json['id'],
      name: json['name'],
      username: json['username'],
      email: json['email'],
      address: new AddressPojo(
          json['address']['street'],
          json['address']['suite'],
          json['address']['city'],
          json['address']['zipcode'],
          new GeoPojo(
            json['address']['geo']['lat'],
            json['address']['geo']['lng'],
          )
      ),
      phone: json['phone'],
      website: json['website'],
    );
  }
}
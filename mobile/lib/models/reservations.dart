import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Reservation{

  static DateFormat formatter = DateFormat('yyyy-MM-dd');
  int? id;
  String? matricule;
  int? noHours;
  int? price;
  String? name;
  int? placeId;
  String? reservationDate;
  Reservation({this.id, this.matricule, this.name, this.price, this.noHours, this.placeId, required String date}){
    reservationDate = formatter.format(DateTime.parse(date));
    print(reservationDate);
  }

  set setReservation(Map<String, dynamic> r){
    id = r["id"];
    matricule = r["matricule"];
    noHours = r["noHours"];
    price = r["price"];
    name = r["name"];
    placeId = r["placeId"];
    reservationDate = r["created"];
  }
}

class Reservations extends ChangeNotifier{
  List<Reservation> _list = [];

  set setList(List<Reservation> r){
    _list = r;
    notifyListeners();
  }
  List<Reservation> get getList => _list.reversed.toList();

  addReservation(Reservation r){
    _list.add(r);
    notifyListeners();
  }

  removeReservation(Reservation r){
    _list.remove(r);
    notifyListeners();
  }

  clearAll(){
    _list.clear();
    notifyListeners();
  }

}
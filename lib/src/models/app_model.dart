class AppModel {
  AppModel({
    this.status = "progress",
    this.step = 1,
    this.user,
    this.id,
    this.fullname,
    this.finished_time,
    this.canceled_reason,
    this.orders,
    this.middlename,
    this.image,
    this.percent,
    this.graph,
    this.adress,
    this.phone1,
    this.phone2,
    this.card,
  }) {
    if (id == null) {
      id = DateTime.now().millisecondsSinceEpoch.toString();
    }
  }
  String? status;
  String? id;
  int? step;
  String? finished_time = null;
  String? canceled_reason = null;
  User? user;
  String? fullname;
  String? middlename;

  List<Order>? orders;

  String? image;

  double? percent;
  String? graph;
  Adress? adress;
  String? phone1;
  String? phone2;
  Card? card;

  Map toJson() {
    return {
      "status": status,
      "step": step,
      "user": user?.toJson(),
      "id": id,
      "fullname": fullname,
      "finished_time": finished_time,
      "canceled_reason": canceled_reason,
      "orders": orders?.map((e) => e.toJson()).toList(),
      "middlename": middlename,
      "image": image,
      "percent": percent,
      "graph": graph,
      "adress": adress?.toJson(),
      "phone1": phone1,
      "phone2": phone2,
      "card": card?.toJson(),
    };
  }

  factory AppModel.fromJson(Map json) {
    return AppModel(
        status: json["status"],
        step: json["step"],
        user: User.fromJson(json["user"]),
        id: json["id"],
        fullname: json["fullname"],
        
        finished_time: json["created_time"],
        canceled_reason: json["canceled_reason"],
        orders:json["orders"]==null ? null :  (json["orders"] as List)
            .map((e) => Order(
                  name: e["name"],
                  price: e["price"],
                ))
            .toList(),
        middlename: json["middlename"],
        image: json["image"],
        percent: json["percent"],
        graph: json["graph"],
        adress: Adress.fromJson(json["adress"]),
        phone1: json["phone1"],
        phone2: json["phone2"],
        card: Card.fromJson(json["card"]));
  }
}

class Order {
  String? name;
  String? price;
  Order({this.name, this.price});
  Map toJson() {
    return {
      "name": name,
      "price": price,
    };
  }

  factory Order.fromJson(json) {
    if (json == null) {
      return Order();
    }
    return Order(
      name: json["name"],
      price: json["price"],
    );
  }
}

class User {
  String? id;
  String? fullname;
  User({this.id, this.fullname});
  Map toJson() {
    return {
      "id": id,
      "fullname": fullname,
    };
  }

  factory User.fromJson(json) {
    if (json == null) {
      return User();
    }
    return User(
      id: json["id"],
      fullname: json["fullname"],
    );
  }
}

class Adress {
  String? region;
  String? region_id;
  String? district;
  String? district_id;
  String? home;
  Adress({
    this.region,
    this.region_id,
    this.district,
    this.district_id,
    this.home,
  });
  Map toJson() {
    return {
      "region": region,
      "region_id": region_id,
      "district": district,
      "district_id": district_id,
      "home": home,
    };
  }

  factory Adress.fromJson(json) {
    if (json == null) {
      return Adress();
    }
    return Adress(
      region: json["region"],
      region_id: json["region_id"],
      district: json["district"],
      district_id: json["district_id"],
      home: json["home"],
    );
  }
}

class Card {
  String? number;
  String? expired_date;
  Card({this.number, this.expired_date});
  Map toJson() {
    return {
      "number": number,
      "expired_date": expired_date,
    };
  }

  factory Card.fromJson(json) {
    if (json == null) {
      return Card();
    }
    return Card(
      number: json["number"],
      expired_date: json["expired_date"],
    );
  }
}

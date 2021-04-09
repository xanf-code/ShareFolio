class CardsModel {
  String type;
  String status;
  String totalResults;
  bool isFilled;
  String uUID;
  List<Cards> cards;

  CardsModel(
      {this.type,
      this.status,
      this.totalResults,
      this.isFilled,
      this.uUID,
      this.cards});

  CardsModel.fromJson(Map<String, dynamic> json) {
    type = json['Type'] as String;
    status = json['status'] as String;
    totalResults = json['totalResults'] as String;
    isFilled = json['isFilled'] as bool;
    uUID = json['UUID'] as String;
    if (json['cards'] != null) {
      cards = <Cards>[];
      json['cards'].forEach((v) {
        cards.add(Cards.fromJson(v as Map<String, dynamic>));
      });
    }
  }
}

class Cards {
  String sId;
  String uUID;
  String name;
  String title;
  String company;
  String email;
  String phoneNumber;
  Socials socials;
  String time;

  Cards(
      {this.sId,
      this.uUID,
      this.name,
      this.title,
      this.company,
      this.email,
      this.phoneNumber,
      this.socials,
      this.time});

  Cards.fromJson(Map<String, dynamic> json) {
    sId = json['_id'] as String;
    uUID = json['UUID'] as String;
    name = json['name'] as String;
    title = json['title'] as String;
    company = json['company'] as String;
    email = json['email'] as String;
    phoneNumber = json['phoneNumber'] as String;
    socials = json['socials'] != null
        ? Socials.fromJson(json['socials'] as Map<String, dynamic>)
        : null;
    time = json['time'] as String;
  }
}

class Socials {
  String facebook;
  String twitter;
  String instagram;
  String linkedin;
  String sharefolio;

  Socials(
      {this.facebook,
      this.twitter,
      this.instagram,
      this.linkedin,
      this.sharefolio});

  Socials.fromJson(Map<String, dynamic> json) {
    facebook = json['facebook'] as String;
    twitter = json['twitter'] as String;
    instagram = json['instagram'] as String;
    linkedin = json['linkedin'] as String;
    sharefolio = json['sharefolio'] as String;
  }
}

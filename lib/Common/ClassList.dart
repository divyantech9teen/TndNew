class SaveDataClass {
  String Message;
  bool IsSuccess;
  String Data;

  SaveDataClass({this.Message, this.IsSuccess, this.Data});
}

class OfferClassData {
  String Message;
  bool IsSuccess;
  List<OfferClass> Data;

  OfferClassData({
    this.Message,
    this.IsSuccess,
    this.Data,
  });

  factory OfferClassData.fromJson(Map<String, dynamic> json) {
    return OfferClassData(
        Message: json['Message'] as String,
        IsSuccess: json['IsSuccess'] as bool,
        Data: json['Data']
            .map<OfferClass>((singleJson) => OfferClass.fromJson(singleJson))
            .toList());
  }
}

class Visitorclass {
  int id;
  String Name;
  String Company_Name;
  String Email;
  String Image;
  String Phone;

  Visitorclass(
      this.Name, this.Company_Name, this.Email, this.Image, this.Phone);

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'id': id,
      'Name': Name,
      'Company_Name': Company_Name,
      'Email': Email,
      'Image': Image,
      'Phone': Phone,
    };
    return map;
  }

  Visitorclass.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    Name = map['Name'];
    Company_Name = map['Company_Name'];
    Email = map['Email'];
    Image = map['Image'];
    Phone = map['Phone'];
  }
}

class OfferClass {
  String offerId;
  String offerName;

  OfferClass({this.offerId, this.offerName});

  factory OfferClass.fromJson(Map<String, dynamic> json) {
    return OfferClass(
        offerId: json['_id'] as String,
        offerName: json['categoryName'] as String);
  }
}

class MemberCategoryData {
  String Message;
  bool IsSuccess;
  List<CategoryData> Data;

  MemberCategoryData({
    this.Message,
    this.IsSuccess,
    this.Data,
  });

  factory MemberCategoryData.fromJson(Map<String, dynamic> json) {
    return MemberCategoryData(
        Message: json['Message'] as String,
        IsSuccess: json['IsSuccess'] as bool,
        Data: json['Data']
            .map<CategoryData>(
                (singleJson) => CategoryData.fromJson(singleJson))
            .toList());
  }
}

class CategoryData {
  String Id;
  String memberShipName;

  CategoryData({this.Id, this.memberShipName});

  factory CategoryData.fromJson(Map<String, dynamic> json) {
    return CategoryData(
        Id: json['_id'] as String,
        memberShipName: json['memberShipName'] as String);
  }
}

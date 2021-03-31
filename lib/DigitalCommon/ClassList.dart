class SaveDataClass {
  String MESSAGE;
  String ORIGINAL_ERROR;
  bool ERROR_STATUS;
  bool RECORDS;

  SaveDataClass(
      {this.MESSAGE, this.ORIGINAL_ERROR, this.ERROR_STATUS, this.RECORDS});

  factory SaveDataClass.fromJson(Map<String, dynamic> json) {
    return SaveDataClass(
        MESSAGE: json['MESSAGE'] as String,
        ORIGINAL_ERROR: json['ORIGINAL_ERROR'] as String,
        ERROR_STATUS: json['ERROR_STATUS'] as bool,
        RECORDS: json['RECORDS'] as bool);
  }
}

class SaveDataClass2 {
  String Message;
  bool IsSuccess;
  String Data;

  SaveDataClass2({this.Message, this.IsSuccess, this.Data});
}

class PaymentDataClass {
  int code;
  String message;

  PaymentDataClass({this.code, this.message});

  factory PaymentDataClass.fromJson(Map<String, dynamic> json) {
    return PaymentDataClass(
        code: json['code'] as int, message: json['message'] as String);
  }
}

class UpdateDigitalProfile {
  String MESSAGE;
  String ORIGINAL_ERROR;
  bool ERROR_STATUS;
  bool RECORDS;

  UpdateDigitalProfile({
    this.MESSAGE,
    this.ORIGINAL_ERROR,
    this.ERROR_STATUS,
    this.RECORDS,
  });

  factory UpdateDigitalProfile.fromJson(Map<String, dynamic> json) {
    return UpdateDigitalProfile(
      MESSAGE: json['MESSAGE'] as String,
      ORIGINAL_ERROR: json['ORIGINAL_ERROR'] as String,
      ERROR_STATUS: json['ERROR_STATUS'] as bool,
      RECORDS: json['RECORDS'] as bool,
    );
  }
}

class LoginDataClass {
  String MESSAGE;
  String ORIGINAL_ERROR;
  bool ERROR_STATUS;
  bool RECORDS;
  List<LoginClass> Data;

  LoginDataClass(
      {this.MESSAGE,
      this.ORIGINAL_ERROR,
      this.ERROR_STATUS,
      this.RECORDS,
      this.Data});

  factory LoginDataClass.fromJson(Map<String, dynamic> json) {
    return LoginDataClass(
        MESSAGE: json['MESSAGE'] as String,
        ORIGINAL_ERROR: json['ORIGINAL_ERROR'] as String,
        ERROR_STATUS: json['ERROR_STATUS'] as bool,
        RECORDS: json['RECORDS'] as bool,
        Data: json['Data']
            .map<LoginClass>((json) => LoginClass.fromJson(json))
            .toList());
  }
}

class LoginClass {
  String Id;
  String Name;

  LoginClass({this.Id, this.Name});

  factory LoginClass.fromJson(Map<String, dynamic> json) {
    return LoginClass(Id: json['Id'] as String, Name: json['Name'] as String);
  }
}

class DigitalDataClass {
  String MESSAGE;
  String ORIGINAL_ERROR;
  bool ERROR_STATUS;
  bool RECORDS;
  List<DigitalClass> Data;

  DigitalDataClass(
      {this.MESSAGE,
      this.ORIGINAL_ERROR,
      this.ERROR_STATUS,
      this.RECORDS,
      this.Data});

  factory DigitalDataClass.fromJson(Map<String, dynamic> json) {
    return DigitalDataClass(
        MESSAGE: json['MESSAGE'] as String,
        ORIGINAL_ERROR: json['ORIGINAL_ERROR'] as String,
        ERROR_STATUS: json['ERROR_STATUS'] as bool,
        RECORDS: json['RECORDS'] as bool,
        Data: json['Data']
            .map<DigitalClass>((json) => DigitalClass.fromJson(json))
            .toList());
  }
}

class DigitalClass {
  String Id;

  DigitalClass({this.Id});

  factory DigitalClass.fromJson(Map<String, dynamic> json) {
    return DigitalClass(Id: json['Id'] as String);
  }
}

class DashboardCountDataClass {
  String MESSAGE;
  String ORIGINAL_ERROR;
  bool ERROR_STATUS;
  bool RECORDS;
  List<DashboardCountClass> Data;

  DashboardCountDataClass(
      {this.MESSAGE,
      this.ORIGINAL_ERROR,
      this.ERROR_STATUS,
      this.RECORDS,
      this.Data});

  factory DashboardCountDataClass.fromJson(Map<String, dynamic> json) {
    return DashboardCountDataClass(
        MESSAGE: json['MESSAGE'] as String,
        ORIGINAL_ERROR: json['ORIGINAL_ERROR'] as String,
        ERROR_STATUS: json['ERROR_STATUS'] as bool,
        RECORDS: json['RECORDS'] as bool,
        Data: json['Data']
            .map<DashboardCountClass>(
                (json) => DashboardCountClass.fromJson(json))
            .toList());
  }
}

class DashboardCountClass {
  String visitors;
  String share;
  String calls;
  String cardAmount;

  DashboardCountClass({this.visitors, this.share, this.calls, this.cardAmount});

  factory DashboardCountClass.fromJson(Map<String, dynamic> json) {
    return DashboardCountClass(
        visitors: json['visitors'] as String,
        share: json['share'] as String,
        calls: json['calls'] as String,
        cardAmount: json['cardAmount'] as String);
  }
}

class ShareDataClass {
  String MESSAGE;
  String ORIGINAL_ERROR;
  bool ERROR_STATUS;
  bool RECORDS;
  List<ShareClass> Data;

  ShareDataClass(
      {this.MESSAGE,
      this.ORIGINAL_ERROR,
      this.ERROR_STATUS,
      this.RECORDS,
      this.Data});

  factory ShareDataClass.fromJson(Map<String, dynamic> json) {
    return ShareDataClass(
        MESSAGE: json['MESSAGE'] as String,
        ORIGINAL_ERROR: json['ORIGINAL_ERROR'] as String,
        ERROR_STATUS: json['ERROR_STATUS'] as bool,
        RECORDS: json['RECORDS'] as bool,
        Data: json['Data']
            .map<ShareClass>((json) => ShareClass.fromJson(json))
            .toList());
  }
}

class SaveDataClass1 {
  String Message;
  bool IsSuccess;
  String Data;

  SaveDataClass1({this.Message, this.IsSuccess, this.Data});

  factory SaveDataClass1.fromJson(Map<String, dynamic> json) {
    return SaveDataClass1(
        Message: json['Message'] as String,
        IsSuccess: json['IsSuccess'] as bool,
        Data: json['Data'] as String);
  }
}

class ChangeThemeData {
  String MESSAGE;
  String ORIGINAL_ERROR;
  bool ERROR_STATUS;
  bool RECORDS;
  List<ThemeChange> Data;

  ChangeThemeData(
      {this.MESSAGE,
      this.ORIGINAL_ERROR,
      this.ERROR_STATUS,
      this.RECORDS,
      this.Data});

  factory ChangeThemeData.fromJson(Map<String, dynamic> json) {
    return ChangeThemeData(
        MESSAGE: json['MESSAGE'] as String,
        ORIGINAL_ERROR: json['ORIGINAL_ERROR'] as String,
        ERROR_STATUS: json['ERROR_STATUS'] as bool,
        RECORDS: json['RECORDS'] as bool,
        Data: json['Data']
            .map<ThemeChange>((json) => ThemeChange.fromJson(json))
            .toList());
  }
}

class ShareClass {
  String Id;
  String Name;
  String MobileNo;
  String Date;

  ShareClass({this.Id, this.Name, this.MobileNo, this.Date});

  factory ShareClass.fromJson(Map<String, dynamic> json) {
    return ShareClass(
        Id: json['Id'] as String,
        Name: json['Name'] as String,
        MobileNo: json['MobileNo'] as String,
        Date: json['Date'] as String);
  }
}

class ThemeChange {
  String Id;
  String ThemeName;
  String Image;

  ThemeChange({this.Id, this.ThemeName, this.Image});

  factory ThemeChange.fromJson(Map<String, dynamic> json) {
    return ThemeChange(
        Id: json['Id'] as String,
        ThemeName: json['ThemeName'] as String,
        Image: json['Image'] as String);
  }
}

class OfferDataClass {
  String MESSAGE;
  String ORIGINAL_ERROR;
  bool ERROR_STATUS;
  bool RECORDS;
  List<OfferClass> Data;

  OfferDataClass(
      {this.MESSAGE,
      this.ORIGINAL_ERROR,
      this.ERROR_STATUS,
      this.RECORDS,
      this.Data});

  factory OfferDataClass.fromJson(Map<String, dynamic> json) {
    return OfferDataClass(
        MESSAGE: json['MESSAGE'] as String,
        ORIGINAL_ERROR: json['ORIGINAL_ERROR'] as String,
        ERROR_STATUS: json['ERROR_STATUS'] as bool,
        RECORDS: json['RECORDS'] as bool,
        Data: json['Data']
            .map<OfferClass>((json) => OfferClass.fromJson(json))
            .toList());
  }
}

class OfferClass {
  String Id;
  String Title;
  String Descri;
  String Image;
  String Date;
  String ValidTill;

  OfferClass(
      {this.Id,
      this.Title,
      this.Descri,
      this.Image,
      this.Date,
      this.ValidTill});

  factory OfferClass.fromJson(Map<String, dynamic> json) {
    return OfferClass(
        Id: json['Id'] as String,
        Title: json['Title'] as String,
        Descri: json['Descri'] as String,
        Image: json['Image'] as String,
        Date: json['Date'] as String,
        ValidTill: json['ValidTill'] as String);
  }
}

class ServicesDataClass {
  String MESSAGE;
  String ORIGINAL_ERROR;
  bool ERROR_STATUS;
  bool RECORDS;
  List<ServicesClass> Data;

  ServicesDataClass(
      {this.MESSAGE,
      this.ORIGINAL_ERROR,
      this.ERROR_STATUS,
      this.RECORDS,
      this.Data});

  factory ServicesDataClass.fromJson(Map<String, dynamic> json) {
    return ServicesDataClass(
        MESSAGE: json['MESSAGE'] as String,
        ORIGINAL_ERROR: json['ORIGINAL_ERROR'] as String,
        ERROR_STATUS: json['ERROR_STATUS'] as bool,
        RECORDS: json['RECORDS'] as bool,
        Data: json['Data']
            .map<ServicesClass>((json) => ServicesClass.fromJson(json))
            .toList());
  }
}

class ServicesClass {
  String Id;
  String Title;
  String Description;

  ServicesClass({this.Id, this.Title, this.Description});

  factory ServicesClass.fromJson(Map<String, dynamic> json) {
    return ServicesClass(
        Id: json['Id'] as String,
        Title: json['Title'] as String,
        Description: json['Description'] as String);
  }
}

class ServiceDigitalClass {
  String MESSAGE;
  String ORIGINAL_ERROR;
  bool ERROR_STATUS;
  bool RECORDS;
  List<ServiceDigital> Data;

  ServiceDigitalClass(
      {this.MESSAGE,
      this.ORIGINAL_ERROR,
      this.ERROR_STATUS,
      this.RECORDS,
      this.Data});

  factory ServiceDigitalClass.fromJson(Map<String, dynamic> json) {
    return ServiceDigitalClass(
        MESSAGE: json['MESSAGE'] as String,
        ORIGINAL_ERROR: json['ORIGINAL_ERROR'] as String,
        ERROR_STATUS: json['ERROR_STATUS'] as bool,
        RECORDS: json['RECORDS'] as bool,
        Data: json['Data']
            .map<ServiceDigital>((json) => ServiceDigital.fromJson(json))
            .toList());
  }
}

class ServiceDigital {
  String Id;

  ServiceDigital({this.Id});

  factory ServiceDigital.fromJson(Map<String, dynamic> json) {
    return ServiceDigital(Id: json['Id'] as String);
  }
}

class MemberDataClass {
  String MESSAGE;
  String ORIGINAL_ERROR;
  bool ERROR_STATUS;
  bool RECORDS;
  List<MemberClass> Data;

  MemberDataClass(
      {this.MESSAGE,
      this.ORIGINAL_ERROR,
      this.ERROR_STATUS,
      this.RECORDS,
      this.Data});

  factory MemberDataClass.fromJson(Map<String, dynamic> json) {
    return MemberDataClass(
        MESSAGE: json['MESSAGE'] as String,
        ORIGINAL_ERROR: json['ORIGINAL_ERROR'] as String,
        ERROR_STATUS: json['ERROR_STATUS'] as bool,
        RECORDS: json['RECORDS'] as bool,
        Data: json['Data']
            .map<MemberClass>((json) => MemberClass.fromJson(json))
            .toList());
  }
}

class MemberClass {
  String Id;
  String Name;
  String Company;
  String Role;
  String website;
  String About;
  String Image;
  String Mobile;
  String Email;
  String Whatsappno;
  String Facebooklink;
  String CompanyAddress;
  String CompanyPhone;
  String CompanyUrl;
  String CompanyEmail;
  String GMap;
  String Twitter;
  String Google;
  String Linkedin;
  String Youtube;
  String Instagram;
  String CoverImage;
  String MyReferralCode;
  String RegistrationRefCode;
  String JoinDate;
  String ExpDate;
  String MemberType;
  String RegistrationPoints;
  String PersonalPAN;
  String CompanyPAN;
  String GstNo;
  String AboutCompany;
  String ShareMsg;
  bool IsActivePayment;

  MemberClass({
    this.Id,
    this.Name,
    this.Company,
    this.Role,
    this.website,
    this.About,
    this.Image,
    this.Mobile,
    this.Email,
    this.Whatsappno,
    this.Facebooklink,
    this.CompanyAddress,
    this.CompanyPhone,
    this.CompanyUrl,
    this.CompanyEmail,
    this.GMap,
    this.Twitter,
    this.Google,
    this.Linkedin,
    this.Youtube,
    this.Instagram,
    this.CoverImage,
    this.MyReferralCode,
    this.RegistrationRefCode,
    this.JoinDate,
    this.ExpDate,
    this.MemberType,
    this.RegistrationPoints,
    this.PersonalPAN,
    this.CompanyPAN,
    this.GstNo,
    this.AboutCompany,
    this.ShareMsg,
    this.IsActivePayment,
  });

  factory MemberClass.fromJson(Map<String, dynamic> json) {
    return MemberClass(
      Id: json['Id'] as String,
      Name: json['Name'] as String,
      Company: json['Company'] as String,
      Role: json['Role'] as String,
      website: json['website'] as String,
      About: json['About'] as String,
      Image: json['Image'] as String,
      Mobile: json['Mobile'] as String,
      Email: json['Email'] as String,
      Whatsappno: json['Whatsappno'] as String,
      Facebooklink: json['Facebooklink'] as String,
      CompanyAddress: json['CompanyAddress'] as String,
      CompanyPhone: json['CompanyPhone'] as String,
      CompanyUrl: json['CompanyUrl'] as String,
      CompanyEmail: json['CompanyEmail'] as String,
      GMap: json['Map'] as String,
      Twitter: json['Twitter'] as String,
      Google: json['Google'] as String,
      Linkedin: json['Linkedin'] as String,
      Youtube: json['Youtube'] as String,
      Instagram: json['Instagram'] as String,
      CoverImage: json['CoverImage'] as String,
      MyReferralCode: json['MyReferralCode'] as String,
      RegistrationRefCode: json['RegistrationRefCode'] as String,
      JoinDate: json['JoinDate'] as String,
      ExpDate: json['ExpDate'] as String,
      MemberType: json['MemberType'] as String,
      RegistrationPoints: json['RegistrationPoints'] as String,
      PersonalPAN: json['PersonalPAN'] as String,
      CompanyPAN: json['CompanyPAN'] as String,
      GstNo: json['GstNo'] as String,
      AboutCompany: json['AboutCompany'] as String,
      ShareMsg: json['ShareMsg'] as String,
      IsActivePayment: json['IsActivePayment'] as bool,
    );
  }
}

class OfferInterestedDataClass {
  String MESSAGE;
  String ORIGINAL_ERROR;
  bool ERROR_STATUS;
  bool RECORDS;
  List<OfferInterestedClass> Data;

  OfferInterestedDataClass(
      {this.MESSAGE,
      this.ORIGINAL_ERROR,
      this.ERROR_STATUS,
      this.RECORDS,
      this.Data});

  factory OfferInterestedDataClass.fromJson(Map<String, dynamic> json) {
    return OfferInterestedDataClass(
        MESSAGE: json['MESSAGE'] as String,
        ORIGINAL_ERROR: json['ORIGINAL_ERROR'] as String,
        ERROR_STATUS: json['ERROR_STATUS'] as bool,
        RECORDS: json['RECORDS'] as bool,
        Data: json['Data']
            .map<OfferInterestedClass>(
                (json) => OfferInterestedClass.fromJson(json))
            .toList());
  }
}

class Updatetheme {
  String MESSAGE;
  String ORIGINAL_ERROR;
  bool ERROR_STATUS;
  bool RECORDS;

  Updatetheme({
    this.MESSAGE,
    this.ORIGINAL_ERROR,
    this.ERROR_STATUS,
    this.RECORDS,
  });

  factory Updatetheme.fromJson(Map<String, dynamic> json) {
    return Updatetheme(
      MESSAGE: json['MESSAGE'] as String,
      ORIGINAL_ERROR: json['ORIGINAL_ERROR'] as String,
      ERROR_STATUS: json['ERROR_STATUS'] as bool,
      RECORDS: json['RECORDS'] as bool,
    );
  }
}

class OfferInterestedClass {
  String Id;
  String InterestedMemberId;
  String Name;
  String Company;
  String Image;
  String Mobileno;
  String Date;

  OfferInterestedClass(
      {this.Id,
      this.InterestedMemberId,
      this.Name,
      this.Company,
      this.Image,
      this.Mobileno,
      this.Date});

  factory OfferInterestedClass.fromJson(Map<String, dynamic> json) {
    return OfferInterestedClass(
        Id: json['Id'] as String,
        InterestedMemberId: json['MemberId'] as String,
        Name: json['Name'] as String,
        Company: json['Company'] as String,
        Image: json['Image'] as String,
        Mobileno: json['Mobile'] as String,
        Date: json['Date'] as String);
  }
}

class EarnHistoryDataClass {
  String MESSAGE;
  String ORIGINAL_ERROR;
  bool ERROR_STATUS;
  bool RECORDS;
  List<EarnHistoryClass> Data;

  EarnHistoryDataClass(
      {this.MESSAGE,
      this.ORIGINAL_ERROR,
      this.ERROR_STATUS,
      this.RECORDS,
      this.Data});

  factory EarnHistoryDataClass.fromJson(Map<String, dynamic> json) {
    return EarnHistoryDataClass(
        MESSAGE: json['MESSAGE'] as String,
        ORIGINAL_ERROR: json['ORIGINAL_ERROR'] as String,
        ERROR_STATUS: json['ERROR_STATUS'] as bool,
        RECORDS: json['RECORDS'] as bool,
        Data: json['Data']
            .map<EarnHistoryClass>((json) => EarnHistoryClass.fromJson(json))
            .toList());
  }
}

class EarnHistoryClass {
  String Id;
  String Name;
  String Image;
  String RegistrationPoints;
  String JoinDate;

  EarnHistoryClass(
      {this.Id, this.Name, this.Image, this.RegistrationPoints, this.JoinDate});

  factory EarnHistoryClass.fromJson(Map<String, dynamic> json) {
    return EarnHistoryClass(
        Id: json['Id'] as String,
        Name: json['Name'] as String,
        Image: json['Image'] as String,
        RegistrationPoints: json['RegistrationPoints'] as String,
        JoinDate: json['JoinDate'] as String);
  }
}

class RedeemHistoryDataClass {
  String MESSAGE;
  String ORIGINAL_ERROR;
  bool ERROR_STATUS;
  bool RECORDS;
  List<RedeemHistoryClass> Data;

  RedeemHistoryDataClass(
      {this.MESSAGE,
      this.ORIGINAL_ERROR,
      this.ERROR_STATUS,
      this.RECORDS,
      this.Data});

  factory RedeemHistoryDataClass.fromJson(Map<String, dynamic> json) {
    return RedeemHistoryDataClass(
        MESSAGE: json['MESSAGE'] as String,
        ORIGINAL_ERROR: json['ORIGINAL_ERROR'] as String,
        ERROR_STATUS: json['ERROR_STATUS'] as bool,
        RECORDS: json['RECORDS'] as bool,
        Data: json['Data']
            .map<RedeemHistoryClass>(
                (json) => RedeemHistoryClass.fromJson(json))
            .toList());
  }
}

class RedeemHistoryClass {
  String Id;
  String Title;
  String Points;
  String Date;
  String OrderNo;

  RedeemHistoryClass(
      {this.Id, this.Title, this.Points, this.Date, this.OrderNo});

  factory RedeemHistoryClass.fromJson(Map<String, dynamic> json) {
    return RedeemHistoryClass(
        Id: json['Id'] as String,
        Title: json['Title'] as String,
        Points: json['Points'] as String,
        Date: json['Date'] as String,
        OrderNo: json['OrderNo'] as String);
  }
}

class EarnRedeemCountDataClass {
  String MESSAGE;
  String ORIGINAL_ERROR;
  bool ERROR_STATUS;
  bool RECORDS;
  List<EarnRedeemCountClass> Data;

  EarnRedeemCountDataClass(
      {this.MESSAGE,
      this.ORIGINAL_ERROR,
      this.ERROR_STATUS,
      this.RECORDS,
      this.Data});

  factory EarnRedeemCountDataClass.fromJson(Map<String, dynamic> json) {
    return EarnRedeemCountDataClass(
        MESSAGE: json['MESSAGE'] as String,
        ORIGINAL_ERROR: json['ORIGINAL_ERROR'] as String,
        ERROR_STATUS: json['ERROR_STATUS'] as bool,
        RECORDS: json['RECORDS'] as bool,
        Data: json['Data']
            .map<EarnRedeemCountClass>(
                (json) => EarnRedeemCountClass.fromJson(json))
            .toList());
  }
}

class EarnRedeemCountClass {
  String EarnCount;
  String RedeemCount;

  EarnRedeemCountClass({this.EarnCount, this.RedeemCount});

  factory EarnRedeemCountClass.fromJson(Map<String, dynamic> json) {
    return EarnRedeemCountClass(
        EarnCount: json['EarnCount'] as String,
        RedeemCount: json['RedeemCount'] as String);
  }
}

class CouponDataClass {
  String MESSAGE;
  String ORIGINAL_ERROR;
  bool ERROR_STATUS;
  bool RECORDS;
  List<CouponClass> Data;

  CouponDataClass(
      {this.MESSAGE,
      this.ORIGINAL_ERROR,
      this.ERROR_STATUS,
      this.RECORDS,
      this.Data});

  factory CouponDataClass.fromJson(Map<String, dynamic> json) {
    return CouponDataClass(
        MESSAGE: json['MESSAGE'] as String,
        ORIGINAL_ERROR: json['ORIGINAL_ERROR'] as String,
        ERROR_STATUS: json['ERROR_STATUS'] as bool,
        RECORDS: json['RECORDS'] as bool,
        Data: json['Data']
            .map<CouponClass>((json) => CouponClass.fromJson(json))
            .toList());
  }
}

class CouponClass {
  String CouponId;
  String CouponCode;
  String CouponType;
  String CouponAmt;
  String StartDate;
  String EndDate;

  CouponClass({
    this.CouponId,
    this.CouponCode,
    this.CouponType,
    this.CouponAmt,
    this.StartDate,
    this.EndDate,
  });

  factory CouponClass.fromJson(Map<String, dynamic> json) {
    return CouponClass(
      CouponId: json['CouponId'] as String,
      CouponCode: json['CouponCode'] as String,
      CouponType: json['CouponType'] as String,
      CouponAmt: json['CouponAmt'] as String,
      StartDate: json['StartDate'] as String,
      EndDate: json['EndDate'] as String,
    );
  }
}

class PackageClassData {
  String MESSAGE;
  String ORIGINAL_ERROR;
  bool ERROR_STATUS;
  bool RECORDS;
  List<PackageClass> Data;

  PackageClassData({
    this.MESSAGE,
    this.ORIGINAL_ERROR,
    this.ERROR_STATUS,
    this.RECORDS,
    this.Data,
  });

  factory PackageClassData.fromJson(Map<String, dynamic> json) {
    return PackageClassData(
        MESSAGE: json['MESSAGE'] as String,
        ORIGINAL_ERROR: json['ORIGINAL_ERROR'] as String,
        ERROR_STATUS: json['ERROR_STATUS'] as bool,
        RECORDS: json['RECORDS'] as bool,
        Data: json['Data']
            .map<PackageClass>((json) => PackageClass.fromJson(json))
            .toList());
  }
}

class PackageClass {
  String id;
  String name, durationYears, amount;

  PackageClass({
    this.id,
    this.name,
    this.durationYears,
    this.amount,
  });

  factory PackageClass.fromJson(Map<String, dynamic> json) {
    return PackageClass(
      id: json["Id"] as String,
      name: json['Name'] as String,
      durationYears: json['DurationYears'] as String,
      amount: json['Amount'] as String,
    );
  }
}

class PaymentOrderIdClass {
  String MESSAGE;
  String ORIGINAL_ERROR;
  bool ERROR_STATUS;
  bool RECORDS;
  String Data;

  PaymentOrderIdClass(
      {this.MESSAGE,
      this.ORIGINAL_ERROR,
      this.ERROR_STATUS,
      this.RECORDS,
      this.Data});

  factory PaymentOrderIdClass.fromJson(Map<String, dynamic> json) {
    return PaymentOrderIdClass(
        MESSAGE: json['MESSAGE'] as String,
        ORIGINAL_ERROR: json['ORIGINAL_ERROR'] as String,
        ERROR_STATUS: json['ERROR_STATUS'] as bool,
        RECORDS: json['RECORDS'] as bool,
        Data: json['Data'] as String);
  }
}

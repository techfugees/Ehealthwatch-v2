import 'dart:convert';

Usermodel usermodelFromJson(String str) => Usermodel.fromJson(json.decode(str));

// String usermodelToJson(Usermodel data) => json.encode(data.toJson());

class Usermodel {
  String id;
  String userroleid;
  String fullname;
  String email;
  String mobile;
  dynamic password;
  String activationcode;
  String resettoken;
  dynamic loginagent;
  String loginip;
  String profileimage;
  dynamic status;
  dynamic createdby;
  dynamic createdon;
  dynamic updatedby;
  dynamic updatedon;

  Usermodel(
      {this.id,
      this.userroleid,
      this.mobile,
      this.password,
      this.fullname,
      this.status,
      this.createdby,
      this.createdon,
      this.updatedby,
      this.updatedon,
      this.activationcode,
      this.resettoken,
      this.email,
      this.profileimage,
      this.loginip,
      this.loginagent});

  Usermodel.fromJson(Map<String, dynamic> json) {
    print('json');
    print(json);
    id = json['_id'];
    userroleid = json['user_role_id'];
    fullname = json['full_name'];
    activationcode = json['activation_code'];
    resettoken = json['reset_token'];
    email = json['email'];
    loginip = json['login_ip'];
    profileimage = json['profile_image'];
    password = json['password'];
    createdby = json['created_by'];
    createdon = json['created_on'];
    updatedby = json['updated_by'];
    updatedon = json['updated_on'];
    status = json['status'];
    loginagent = json['login_agent'];
  }
}

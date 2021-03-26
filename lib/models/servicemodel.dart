class ServicesModel {
  String id;
  String name;
  bool isactive;
  String imageurl;
  Function onPress;

  ServicesModel({this.onPress, this.imageurl, this.id, this.name, this.isactive});

  ServicesModel.fromJson(Map<String, dynamic> json) {
    onPress = json['onPress'];
    id = json['_id'];
    imageurl = json['imageurl'];
    name = json['name'];
    isactive = json['isactive'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['onPress'] = this.onPress;
    data['_id'] = this.id;
    data['imageurlault'] = this.imageurl;
    data['name'] = this.name;
    data['isactive'] = this.isactive;
    return data;
  }
}

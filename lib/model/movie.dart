class Movie {
  String ten;
  String trangthai;
  String danganime;
  String season;
  String imageurl;
  List<String> theloai;
  int nam;
  int view;
  String noidung;
  List<dynamic> episode;

  Movie(this.ten, this.trangthai, this.danganime, this.season, this.imageurl,
      this.theloai, this.nam, this.view, this.noidung, this.episode);

  Movie.fromJson(Map<String, dynamic> json) {
    this.ten = json['ten'];
    this.trangthai = json['trangthai'];
    this.danganime = json['danganime'];
    this.season = json['season'];
    this.theloai = json['theloai'] as List;
    this.nam = json['nam'].toInt();
    this.view = json['view'].toInt();
    this.noidung = json['noidung'];
    this.episode = json["episode"];
  }
}

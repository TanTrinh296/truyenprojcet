class MovieTitle {
  String ten;
  String imageurl;
  String trailerurl;

  MovieTitle(this.ten,this.imageurl,this.trailerurl);
  MovieTitle.fromJson(Map<String, dynamic> json) {
    this.ten = json['ten'];
    this.imageurl = json['imageurl'];
    this.trailerurl = json['trailerurl'];
  }
}

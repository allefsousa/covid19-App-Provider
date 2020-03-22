import 'package:meta/meta.dart';
import 'dart:convert';

HistoryModel historyModelFromJson(String str) => HistoryModel.fromMap(json.decode(str));

String historyModelToJson(HistoryModel data) => json.encode(data.toMap());

class HistoryModel {
  List<Node> nodes;
  List<Link> links;

  HistoryModel({
    @required this.nodes,
    @required this.links,
  });

  factory HistoryModel.fromMap(Map<String, dynamic> json) => HistoryModel(
    nodes: json["nodes"] == null ? null : List<Node>.from(json["nodes"].map((x) => Node.fromMap(x))),
    links: json["links"] == null ? null : List<Link>.from(json["links"].map((x) => Link.fromMap(x))),
  );

  Map<String, dynamic> toMap() => {
    "nodes": nodes == null ? null : List<dynamic>.from(nodes.map((x) => x.toMap())),
    "links": links == null ? null : List<dynamic>.from(links.map((x) => x.toMap())),
  };
}

class Link {
  int source;
  int target;

  Link({
    @required this.source,
    @required this.target,
  });

  factory Link.fromMap(Map<String, dynamic> json) => Link(
    source: json["source"] == null ? null : json["source"],
    target: json["target"] == null ? null : json["target"],
  );

  Map<String, dynamic> toMap() => {
    "source": source == null ? null : source,
    "target": target == null ? null : target,
  };
}

class Node {
  int id;
  String kasus;
  String wn;
  String gender;
  int umur;
  String umurtext;
  String pengumuman;
  String penularan;
  String klaster;
  int klasterid;
  int genderid;
  int wnid;
  String status;
  int statusid;
  String rs;
  int rsid;

  Node({
    @required this.id,
    @required this.kasus,
    @required this.wn,
    @required this.gender,
    @required this.umur,
    @required this.umurtext,
    @required this.pengumuman,
    @required this.penularan,
    @required this.klaster,
    @required this.klasterid,
    @required this.genderid,
    @required this.wnid,
    @required this.status,
    @required this.statusid,
    @required this.rs,
    @required this.rsid,
  });

  factory Node.fromMap(Map<String, dynamic> json) => Node(
    id: json["id"] == null ? null : json["id"],
    kasus: json["kasus"] == null ? null : json["kasus"],
    wn: json["wn"] == null ? null : json["wn"],
    gender: json["gender"] == null ? null : json["gender"],
    umur: json["umur"] == null ? null : json["umur"],
    umurtext: json["umurtext"] == null ? null : json["umurtext"],
    pengumuman: json["pengumuman"] == null ? null : json["pengumuman"],
    penularan: json["penularan"] == null ? null : json["penularan"],
    klaster: json["klaster"] == null ? null : json["klaster"],
    klasterid: json["klasterid"] == null ? null : json["klasterid"],
    genderid: json["genderid"] == null ? null : json["genderid"],
    wnid: json["wnid"] == null ? null : json["wnid"],
    status: json["status"] == null ? null : json["status"],
    statusid: json["statusid"] == null ? null : json["statusid"],
    rs: json["rs"] == null ? null : json["rs"],
    rsid: json["rsid"] == null ? null : json["rsid"],
  );

  Map<String, dynamic> toMap() => {
    "id": id == null ? null : id,
    "kasus": kasus == null ? null : kasus,
    "wn": wn == null ? null : wn,
    "gender": gender == null ? null : gender,
    "umur": umur == null ? null : umur,
    "umurtext": umurtext == null ? null : umurtext,
    "pengumuman": pengumuman == null ? null : pengumuman,
    "penularan": penularan == null ? null : penularan,
    "klaster": klaster == null ? null : klaster,
    "klasterid": klasterid == null ? null : klasterid,
    "genderid": genderid == null ? null : genderid,
    "wnid": wnid == null ? null : wnid,
    "status": status == null ? null : status,
    "statusid": statusid == null ? null : statusid,
    "rs": rs == null ? null : rs,
    "rsid": rsid == null ? null : rsid,
  };
}
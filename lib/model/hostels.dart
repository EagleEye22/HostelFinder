class HostelField {
  static String hostelName = "name";
  static String hostelLocation = "location";
  static String hostelcover = "cover_url";
  static String hosteldescription = "description";
  static String hostelfacilities = "facilities";
  static String hostelgallery = "gallery";
  static String hostelshortdescription = "short_description";
}

class Hostels {
  String hostelName = "";
  String hostelLocation = "";
  String hostelcover = "";
  String hosteldescription = "";
  String hostelfacilities = "";
  String hostelshortdescription = "";
  Hostels(
      {required this.hostelName,
      required this.hostelLocation,
      required this.hostelcover,
      required this.hosteldescription,
      required this.hostelfacilities,
      required this.hostelshortdescription});

  Hostels.fromJson(Map<String, dynamic> map) {
    hostelLocation = map[HostelField.hostelLocation];
    hostelName = map[HostelField.hostelName];
    hostelcover = map[HostelField.hostelcover];
    hosteldescription = map[HostelField.hosteldescription];
    hostelfacilities = map[HostelField.hostelfacilities];
    hostelshortdescription = map[HostelField.hostelshortdescription];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data[HostelField.hostelLocation] = hostelLocation;
    data[HostelField.hostelName] = hostelName;
    data[HostelField.hostelcover] = hostelcover;
    data[HostelField.hosteldescription] = hosteldescription;
    data[HostelField.hostelfacilities] = hostelfacilities;
    data[HostelField.hostelshortdescription] = hostelshortdescription;
    return data;
  }
}

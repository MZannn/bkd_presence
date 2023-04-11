// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);
class UserModel {
  UserModel({
    this.code,
    this.status,
    this.message,
    this.data,
  });

  int? code;
  String? status;
  String? message;
  Data? data;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        code: json["code"],
        status: json["status"],
        message: json["message"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );
}

class Data {
  Data({
    this.user,
    this.presences,
  });

  UserClass? user;
  List<Presence>? presences;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        user: json["user"] == null ? null : UserClass.fromJson(json["user"]),
        presences: json["presences"] == null
            ? []
            : List<Presence>.from(
                json["presences"]!.map((x) => Presence.fromJson(x))),
      );
}

class Presence {
  Presence({
    this.id,
    this.employeeId,
    this.officeId,
    this.attendanceClock,
    this.attendanceClockOut,
    this.presenceDate,
    this.attendanceEntryStatus,
    this.attendanceExitStatus,
    this.entryPosition,
    this.entryDistance,
    this.exitPosition,
    this.exitDistance,
  });

  int? id;
  String? employeeId;
  String? officeId;
  dynamic attendanceClock;
  dynamic attendanceClockOut;
  DateTime? presenceDate;
  String? attendanceEntryStatus;
  String? attendanceExitStatus;
  String? entryPosition;
  String? entryDistance;
  String? exitPosition;
  String? exitDistance;

  factory Presence.fromJson(Map<String, dynamic> json) => Presence(
        id: json["id"],
        employeeId: json["employee_id"],
        officeId: json["office_id"],
        attendanceClock: json["attendance_clock"],
        attendanceClockOut: json["attendance_clock_out"],
        presenceDate: json["presence_date"] == null
            ? null
            : DateTime.parse(json["presence_date"]),
        attendanceEntryStatus: json["attendance_entry_status"],
        attendanceExitStatus: json["attendance_exit_status"],
        entryPosition: json["entry_position"],
        entryDistance: json["entry_distance"],
        exitPosition: json["exit_position"],
        exitDistance: json["exit_distance"],
      );
}

class UserClass {
  UserClass({
    this.nip,
    this.name,
    this.position,
    this.phoneNumber,
    this.profilePhotoPath,
    this.deviceId,
    this.officeId,
    this.office,
  });

  String? nip;
  String? name;
  String? position;
  String? phoneNumber;
  String? profilePhotoPath;
  String? deviceId;
  String? officeId;
  Office? office;

  factory UserClass.fromJson(Map<String, dynamic> json) => UserClass(
        nip: json["nip"],
        name: json["name"],
        position: json["position"],
        phoneNumber: json["phone_number"],
        profilePhotoPath: json["profile_photo_path"],
        deviceId: json["device_id"],
        officeId: json["office_id"],
        office: json["office"] == null ? null : Office.fromJson(json["office"]),
      );
}

class Office {
  Office({
    this.id,
    this.name,
    this.address,
    this.latitude,
    this.longitude,
  });

  int? id;
  String? name;
  String? address;
  String? latitude;
  String? longitude;

  factory Office.fromJson(Map<String, dynamic> json) => Office(
        id: json["id"],
        name: json["name"],
        address: json["address"],
        latitude: json["latitude"],
        longitude: json["longitude"],
      );
}

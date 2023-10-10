class ServantModel {
  String? uid;
  String? userName;
  String? email;
  String? password;
  String? jobType;
  int? experience;

  // Define the jobTypes list
  static final List<String> jobTypes = [
    "Cooking Servant",
    "Gardening",
    "Babysitting",
    "Pet Care",
    "House Cleaning",
    "Personal Chef",
    "Elderly Care",
    "Personal Trainer",
    "Tutoring",
    "Laundry and Ironing Service",
    "Personal Shopper",
    "Home Security",
    "Event Planner",
    "Housekeeper",
    "Private Nurse",
    "Home Organizer",
    " Waitstaff/Catering",
    "Massage Therapist",
    "Home Decorator",
    "Dog Walker",
    "Pool Maintenance"
  ];

  ServantModel({
    required this.uid,
    required this.userName,
    required this.email,
    required this.password,
    this.jobType,
    this.experience,
  });

  factory ServantModel.fromMap(Map<String, dynamic> map) {
    return ServantModel(
      uid: map['uid'],
      userName: map['userName'],
      email: map['email'],
      password: map['password'],
      jobType: map['jobType'],
      experience: map['experience'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'userName': userName,
      'email': email,
      'password': password,
      'jobType': jobType,
      'experience': experience,
    };
  }
}

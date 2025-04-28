class UserSymptomsScoreMaster {
  SymptomsScoreData? _data;
  bool? _success;
  String? _message;

  UserSymptomsScoreMaster(
      {SymptomsScoreData? data, bool? success, String? message}) {
    if (data != null) {
      _data = data;
    }
    if (success != null) {
      _success = success;
    }
    if (message != null) {
      _message = message;
    }
  }

  SymptomsScoreData? get data => _data;
  set data(SymptomsScoreData? data) => _data = data;
  bool? get success => _success;
  set success(bool? success) => _success = success;
  String? get message => _message;
  set message(String? message) => _message = message;

  UserSymptomsScoreMaster.fromJson(Map<String, dynamic> json) {
    _data = json['data'] != null
        ? SymptomsScoreData.fromJson(json['data'])
        : null;
    _success = json['success'];
    _message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (_data != null) {
      data['data'] = _data!.toJson();
    }
    data['success'] = _success;
    data['message'] = _message;
    return data;
  }
}

class SymptomsScoreData {
  int? _id;
  int? _userId;
  int? _staining;
  int? _clotSize;
  int? _workingAbility;
  int? _location;
  int? _cramps;
  int? _days;
  int? _collectionMethod;
  int? _frequencyOfChangeDay;
  int? _mood;
  int? _energy;
  int? _stress;
  int? _lifestyle;
  int? _acne;
  int? _stainingScore;
  int? _clotSizeScore;
  int? _workingAbilityScore;
  int? _locationScore;
  int? _periodCrampsScore;
  int? _daysScore;
  String? _createdAt;
  String? _updatedAt;
  int? _totalScore;
  int? _totalPainScore;

  SymptomsScoreData(
      {int? id,
      int? userId,
      int? staining,
      int? clotSize,
      int? workingAbility,
      int? location,
      int? cramps,
      int? days,
      int? collectionMethod,
      int? frequencyOfChangeDay,
      int? mood,
      int? energy,
      int? stress,
      int? lifestyle,
      int? acne,
      int? stainingScore,
      int? clotSizeScore,
      int? workingAbilityScore,
      int? locationScore,
      int? periodCrampsScore,
      int? daysScore,
      String? createdAt,
      String? updatedAt,
      int? totalScore,
      int? totalPainScore}) {
    if (id != null) {
      _id = id;
    }
    if (userId != null) {
      _userId = userId;
    }
    if (staining != null) {
      _staining = staining;
    }
    if (clotSize != null) {
      _clotSize = clotSize;
    }
    if (workingAbility != null) {
      _workingAbility = workingAbility;
    }
    if (location != null) {
      _location = location;
    }
    if (cramps != null) {
      _cramps = cramps;
    }
    if (days != null) {
      _days = days;
    }
    if (collectionMethod != null) {
      _collectionMethod = collectionMethod;
    }
    if (frequencyOfChangeDay != null) {
      _frequencyOfChangeDay = frequencyOfChangeDay;
    }
    if (mood != null) {
      _mood = mood;
    }
    if (energy != null) {
      _energy = energy;
    }
    if (stress != null) {
      _stress = stress;
    }
    if (lifestyle != null) {
      _lifestyle = lifestyle;
    }
    if (acne != null) {
      _acne = acne;
    }
    if (stainingScore != null) {
      _stainingScore = stainingScore;
    }
    if (clotSizeScore != null) {
      _clotSizeScore = clotSizeScore;
    }
    if (workingAbilityScore != null) {
      _workingAbilityScore = workingAbilityScore;
    }
    if (locationScore != null) {
      _locationScore = locationScore;
    }
    if (periodCrampsScore != null) {
      _periodCrampsScore = periodCrampsScore;
    }
    if (daysScore != null) {
      _daysScore = daysScore;
    }
    if (createdAt != null) {
      _createdAt = createdAt;
    }
    if (updatedAt != null) {
      _updatedAt = updatedAt;
    }
    if (totalScore != null) {
      _totalScore = totalScore;
    }
    if (totalPainScore != null) {
      _totalPainScore = totalPainScore;
    }
  }

  int? get id => _id;
  set id(int? id) => _id = id;
  int? get userId => _userId;
  set userId(int? userId) => _userId = userId;
  int? get staining => _staining;
  set staining(int? staining) => _staining = staining;
  int? get clotSize => _clotSize;
  set clotSize(int? clotSize) => _clotSize = clotSize;
  int? get workingAbility => _workingAbility;
  set workingAbility(int? workingAbility) => _workingAbility = workingAbility;
  int? get location => _location;
  set location(int? location) => _location = location;
  int? get cramps => _cramps;
  set cramps(int? cramps) => _cramps = cramps;
  int? get days => _days;
  set days(int? days) => _days = days;
  int? get collectionMethod => _collectionMethod;
  set collectionMethod(int? collectionMethod) =>
      _collectionMethod = collectionMethod;
  int? get frequencyOfChangeDay => _frequencyOfChangeDay;
  set frequencyOfChangeDay(int? frequencyOfChangeDay) =>
      _frequencyOfChangeDay = frequencyOfChangeDay;
  int? get mood => _mood;
  set mood(int? mood) => _mood = mood;
  int? get energy => _energy;
  set energy(int? energy) => _energy = energy;
  int? get stress => _stress;
  set stress(int? stress) => _stress = stress;
  int? get lifestyle => _lifestyle;
  set lifestyle(int? lifestyle) => _lifestyle = lifestyle;
  int? get acne => _acne;
  set acne(int? acne) => _acne = acne;
  int? get stainingScore => _stainingScore;
  set stainingScore(int? stainingScore) => _stainingScore = stainingScore;
  int? get clotSizeScore => _clotSizeScore;
  set clotSizeScore(int? clotSizeScore) => _clotSizeScore = clotSizeScore;
  int? get workingAbilityScore => _workingAbilityScore;
  set workingAbilityScore(int? workingAbilityScore) =>
      _workingAbilityScore = workingAbilityScore;
  int? get locationScore => _locationScore;
  set locationScore(int? locationScore) => _locationScore = locationScore;
  int? get periodCrampsScore => _periodCrampsScore;
  set periodCrampsScore(int? periodCrampsScore) =>
      _periodCrampsScore = periodCrampsScore;
  int? get daysScore => _daysScore;
  set daysScore(int? daysScore) => _daysScore = daysScore;
  String? get createdAt => _createdAt;
  set createdAt(String? createdAt) => _createdAt = createdAt;
  String? get updatedAt => _updatedAt;
  set updatedAt(String? updatedAt) => _updatedAt = updatedAt;
  int? get totalScore => _totalScore;
  set totalScore(int? totalScore) => _totalScore = totalScore;
  int? get totalPainScore => _totalPainScore;
  set totalPainScore(int? totalPainScore) => _totalPainScore = totalPainScore;

  SymptomsScoreData.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _userId = json['user_id'];
    _staining = json['staining'];
    _clotSize = json['clot_size'];
    _workingAbility = json['working_ability'];
    _location = json['location'];
    _cramps = json['cramps'];
    _days = json['days'];
    _collectionMethod = json['collection_method'];
    _frequencyOfChangeDay = json['frequency_of_change_day'];
    _mood = json['mood'];
    _energy = json['energy'];
    _stress = json['stress'];
    _lifestyle = json['lifestyle'];
    _acne = json['acne'];
    _stainingScore = json['staining_score'];
    _clotSizeScore = json['clot_size_score'];
    _workingAbilityScore = json['working_ability_score'];
    _locationScore = json['location_score'];
    _periodCrampsScore = json['period_cramps_score'];
    _daysScore = json['days_score'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _totalScore = json['total_score'];
    _totalPainScore = json['total_pain_score'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = _id;
    data['user_id'] = _userId;
    data['staining'] = _staining;
    data['clot_size'] = _clotSize;
    data['working_ability'] = _workingAbility;
    data['location'] = _location;
    data['cramps'] = _cramps;
    data['days'] = _days;
    data['collection_method'] = _collectionMethod;
    data['frequency_of_change_day'] = _frequencyOfChangeDay;
    data['mood'] = _mood;
    data['energy'] = _energy;
    data['stress'] = _stress;
    data['lifestyle'] = _lifestyle;
    data['acne'] = _acne;
    data['staining_score'] = _stainingScore;
    data['clot_size_score'] = _clotSizeScore;
    data['working_ability_score'] = _workingAbilityScore;
    data['location_score'] = _locationScore;
    data['period_cramps_score'] = _periodCrampsScore;
    data['days_score'] = _daysScore;
    data['created_at'] = _createdAt;
    data['updated_at'] = _updatedAt;
    data['total_score'] = _totalScore;
    data['total_pain_score'] = _totalPainScore;
    return data;
  }
}

class MoodDayModel {
  String? title;
  String? imagePath;
  bool? isSelected;

  MoodDayModel({required String title, required bool isSelected, String? imagePath}) {
    this.title= title;
    this.isSelected = isSelected;
    this.imagePath = imagePath;
  }
}
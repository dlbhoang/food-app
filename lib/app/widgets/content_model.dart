class ContentModel {
  late String image;
  late String titile;
  late String desc;

  ContentModel({required this.desc, required this.image, required this.titile});
}

List<ContentModel> contents = [
  ContentModel(
      desc: 'Pick your food from our menu\n  More than 30-35 times',
      image: 'assets/images/screen1.png',
      titile: 'Select from our\n  Best Menu '),
  ContentModel(
      desc: 'Pick your food from our menu\n  More than 30-35 times',
      image: 'assets/images/screen2.png',
      titile: 'Select from our\n  Best Menu '),
  ContentModel(
      desc: 'Pick your food from our menu\n  More than 30-35 times',
      image: 'assets/images/screen3.png',
      titile: 'Select from our\n  Best Menu '),
];

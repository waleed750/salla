class BoardingModel
{
  final String image ;
  final String title;
  final String body ;

  BoardingModel(this.image, this.title, this.body);

  static List<BoardingModel> boardingList = [
    BoardingModel('assets/images/boarding_1.png', 'SEARCH ONLINE', 'Welcome to Salla') ,
    BoardingModel('assets/images/boarding_2.png', 'order now', 'you can order from any where you want '),
    BoardingModel('assets/images/boarding_3.png', 'Delivery', 'your order will get to you in short time ')

  ];
}
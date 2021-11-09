class BannerModel {
  final String id;
  final String urlImage;

  const BannerModel({
    this.id,
    this.urlImage,
  });
}

const bannerList = [
  BannerModel(
    id: '1',
    urlImage: 'assets/svg/banner1.png',
  ), BannerModel(
    id: '2',
    urlImage: 'assets/svg/banner2.png',
  ), BannerModel(
    id: '3',
    urlImage: 'assets/svg/banner3.png',
  ),
];

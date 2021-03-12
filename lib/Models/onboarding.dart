class StepModel {
  final int id;
  final String text;
  final String url;
  StepModel({
    this.id,
    this.text,
    this.url,
  });

  static List<StepModel> list = [
    StepModel(
      id: 1,
      text: "Page 1",
      url:
          "https://img.pngio.com/imagenes-random-png-5-png-image-random-png-451_326.png",
    ),
    StepModel(
      id: 2,
      text: "Page 2",
      url:
          "https://img.pngio.com/imagenes-random-png-5-png-image-random-png-451_326.png",
    ),
    StepModel(
      id: 3,
      text: "Page 3",
      url:
          "https://img.pngio.com/imagenes-random-png-5-png-image-random-png-451_326.png",
    ),
  ];
}

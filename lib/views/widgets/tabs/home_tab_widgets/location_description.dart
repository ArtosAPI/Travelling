import 'package:flutter/material.dart';
import 'package:travelling/utils/texts.dart';

class LocationDescription extends StatelessWidget {
  const LocationDescription({
    super.key,
    required this.imagePath,
    required this.name,
    required this.star,
    required this.description,
    required this.liked,
    required this.like,
  });
  final String imagePath;
  final String name;
  final double star;
  final String description;
  final bool liked;
  final void Function()? like;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        decoration: const BoxDecoration(color: Colors.white),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: ListView(
            children: [
              SizedBox(
                height: 375,
                width: double.infinity,
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: SizedBox(
                        height: 340,
                        width: double.infinity,
                        child: Image(
                          image: AssetImage(imagePath),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 10,
                      left: 10,
                      child: IconButton(
                        icon: const Icon(Icons.arrow_back),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        style: const ButtonStyle(
                          maximumSize: MaterialStatePropertyAll(Size(40, 40)),
                          shape: MaterialStatePropertyAll(
                              RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8)))),
                          backgroundColor:
                              MaterialStatePropertyAll(Colors.white),
                        ),
                      ),
                    ),
                    Positioned(
                        top: 315,
                        left: MediaQuery.of(context).size.width / 1.45,
                        child: Container(
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Color.fromARGB(255, 146, 186, 255),
                                  blurRadius: 15,
                                )
                              ]),
                          child: IconButton(
                            style: const ButtonStyle(
                                iconSize: MaterialStatePropertyAll(35),
                                fixedSize: MaterialStatePropertyAll(
                                    Size.fromRadius(25)),
                                backgroundColor:
                                    MaterialStatePropertyAll(Colors.white),
                                shape:
                                    MaterialStatePropertyAll(CircleBorder())),
                            icon: Icon(
                              Icons.favorite,
                              color: liked ? Colors.red : Colors.grey,
                            ),
                            onPressed: like,
                          ),
                        )),
                  ],
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    name,
                    style: Texts.instance.textStyle1.copyWith(
                        fontSize: 24, fontWeight: FontWeight.bold, height: 0),
                  ),
                  ShaderMask(
                      blendMode: BlendMode.srcIn,
                      shaderCallback: (bounds) => const LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                Color.fromRGBO(23, 111, 242, 1),
                                Color.fromRGBO(25, 110, 238, 1),
                              ]).createShader(
                            Rect.fromLTWH(0, 0, bounds.width, bounds.height),
                          ),
                      child: Text(
                        'Show map',
                        style: Texts.instance.textStyle2
                            .copyWith(fontWeight: FontWeight.bold, height: 0),
                      ))
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16, bottom: 32),
                child: Row(
                  children: [
                    ShaderMask(
                        blendMode: BlendMode.srcIn,
                        shaderCallback: (bounds) => const LinearGradient(
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                                colors: [
                                  Color.fromRGBO(180, 120, 32, 1),
                                  Color.fromRGBO(223, 150, 82, 1),
                                ]).createShader(Rect.fromLTWH(
                                0, 0, bounds.width, bounds.height)),
                        child: const Icon(Icons.star)),
                    Text(
                      '   $star',
                      style: Texts.instance.textStyle2
                          .copyWith(height: 0, color: Colors.black54),
                    )
                  ],
                ),
              ),
              Text(description, style: Texts.instance.textStyle2),
              Padding(
                padding: const EdgeInsets.only(top: 30, bottom: 12),
                child: Text('Facilities',
                    style: Texts.instance.textStyle1
                        .copyWith(fontWeight: FontWeight.bold)),
              ),
              SizedBox(
                height: 77,
                child:
                    ListView(scrollDirection: Axis.horizontal, children: const [
                  Facility(icon: Icons.connected_tv, text: '1 Heater'),
                  SizedBox(
                    width: 14,
                  ),
                  Facility(icon: Icons.dinner_dining, text: 'Dinner'),
                  SizedBox(
                    width: 14,
                  ),
                  Facility(icon: Icons.hot_tub, text: '1 Tub'),
                  SizedBox(
                    width: 14,
                  ),
                  Facility(icon: Icons.pool, text: 'Pool'),
                  SizedBox(
                    width: 14,
                  ),
                ]),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class Facility extends StatelessWidget {
  const Facility({super.key, required this.icon, required this.text});
  final IconData icon;
  final String text;
  final Color _mainColor = Colors.grey;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(16)),
        child: Container(
          width: 77,
          height: 77,
          color: Color.fromRGBO(23, 111, 242, 0.171),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: _mainColor,
                size: 32,
              ),
              Text(text,
                  style: Texts.instance.textStyle2.copyWith(color: _mainColor)),
            ],
          ),
        ),
      ),
    );
  }
}

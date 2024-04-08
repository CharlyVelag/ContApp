import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../provider/providerCategorias.dart';

class CarruselScreen extends StatefulWidget {
  final String categoria;
  final String id;
  const CarruselScreen({Key? key, required this.categoria, required this.id})
      : super(key: key);
  @override
  State<CarruselScreen> createState() => _CarruselScreenState();
}

class _CarruselScreenState extends State<CarruselScreen> {
  List meses = [
    "Enero",
    "Febrero",
    "Marzo",
    "Abril",
    "Mayo",
    "Junio",
    "Julio",
    "Agosto",
    "Septiembre",
    "Octubre",
    "Noviembre",
    "Diciembre"
  ];

  int activateMes = 0;

  var dt = DateTime.now();
  @override
  void initState() {
    activateMes = dt.month - 1;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProviderCategoria>(context);

    return Column(
      children: [
        CarouselSlider.builder(
            itemCount: meses.length,
            itemBuilder: (context, index, indexreal) {
              final mes = meses[index];
              return elementoCarrusel(mes, index);
            },
            options: CarouselOptions(
                height: 25,
                initialPage: dt.month - 1,
                enlargeFactor: 100,
                aspectRatio: 50,
                disableCenter: true,
                viewportFraction: 0.3,
                onPageChanged: (index, reason) => {
                      provider.modelSelecmes.clear(),
                      setState((() {
                        activateMes = index;
                      })),
                      provider.mesSelect = index + 1,
                      provider.obtenerDatosCarruselMes(
                          widget.categoria,
                          widget.id,
                          index + 1,
                          provider.valorCheck ? provider.yearProvider : 0)
                    },
                autoPlayInterval: const Duration(seconds: 2))),
        const Divider(
          height: 8,
          endIndent: 20,
          indent: 20,
        ),
        indicator()
      ],
    );
  }

  Widget elementoCarrusel(String mes, int i) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          colors: i != activateMes
              ? <Color>[
                  Colors.grey,
                  Colors.grey,
                ]
              : <Color>[
                  const Color(0xff0097B2),
                  const Color(0xff0E6EC9),
                ],
        ),
        borderRadius: const BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      child: Center(
          child: Text(
        mes,
        style: const TextStyle(color: Colors.white),
      )),
    );
  }

  Widget indicator() => AnimatedSmoothIndicator(
        activeIndex: activateMes,
        count: meses.length,
        effect: WormEffect(
            dotHeight: 5,
            dotWidth: 8,
            spacing: 1,
            activeDotColor: const Color(0xff0E6EC9),
            dotColor: Colors.black.withOpacity(0.2)),
      );
}

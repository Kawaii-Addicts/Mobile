import 'package:drinkify/widgets/custom_floating_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:go_router/go_router.dart';
import 'package:latlong2/latlong.dart';

import '../utils/theming.dart';

class ChooseLocationPage extends StatelessWidget {
  const ChooseLocationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theming.bgColor,
      body: Stack(
        children: [
          FlutterMap(
            options: MapOptions(
              center: LatLng(52.237049, 21.017532),
              zoom: 15,
              interactiveFlags: InteractiveFlag.all -
                  InteractiveFlag.doubleTapZoom -
                  InteractiveFlag.rotate,
            ),
            children: [
              TileLayer(
                urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
                userAgentPackageName: "app.drinkify",
              ),
            ],
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    top: MediaQuery.of(context).padding.top - 15,
                  ),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width -
                        (MediaQuery.of(context).size.width - 100),
                    child: _mapButton(
                      icon: Icons.arrow_back_rounded,
                      onClick: () => context.pop(),
                    ),
                  ),
                ),
                const Spacer(),
                FittedBox(
                  child: Container(
                    width: MediaQuery.of(context).size.width - 100,
                    alignment: Alignment.bottomCenter,
                    padding: EdgeInsets.only(
                      top: MediaQuery.of(context).padding.top,
                      bottom: 15,
                    ),
                    decoration: BoxDecoration(
                      color: Theming.bgColor,
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(60),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.5),
                          blurRadius: 10,
                          spreadRadius: 1,
                          offset: const Offset(-5, 5),
                        ),
                      ],
                    ),
                    child: const Text(
                      "Polska, Radom",
                      style: TextStyle(
                        color: Theming.whiteTone,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          //TODO: fix text
          CustomFloatingButton(
            backgroundColor: Theming.primaryColor,
            onTap: () {},
            child: const Text(
              "Zapisz",
              style: TextStyle(
                color: Theming.whiteTone,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _mapButton({
    required IconData icon,
    required VoidCallback onClick,
  }) {
    return GestureDetector(
      onTap: onClick,
      child: AnimatedContainer(
        height: 40,
        width: 40,
        duration: const Duration(milliseconds: 200),
        curve: Curves.linearToEaseOut,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Theming.bgColor,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.5),
              blurRadius: 10,
              spreadRadius: 1,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Icon(
          icon,
          color: Theming.whiteTone,
        ),
      ),
    );
  }
}

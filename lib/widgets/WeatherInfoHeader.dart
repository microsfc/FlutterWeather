import 'package:flutter/material.dart';
import 'package:flutter_weather/provider/weatherProvider.dart';
import 'package:flutter_weather/theme/colors.dart';
import 'package:flutter_weather/theme/textStyle.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class WeatherInfoHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<WeatherProvider>(
      builder: (context, weatherProv, _) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FittedBox(
                  child: RichText(
                    textAlign: TextAlign.start,
                    text: TextSpan(
                      text: 'City, ',
                      style: semiboldText,
                      children: [
                        TextSpan(
                          text: 'Country',
                          style: regularText.copyWith(fontSize: 18.0),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 4.0),
                FittedBox(
                  child: Text(
                    DateFormat('EEEE MMM dd, y  hh:mm a')
                        .format(DateTime.now()),
                    style: regularText.copyWith(color: Colors.grey.shade700),
                  ),
                )
              ],
            ),
            Spacer(),
            ClipRRect(
              borderRadius: BorderRadius.circular(12.0),
              child: Container(
                padding: const EdgeInsets.all(4.0),
                color: Colors.grey.shade200,
                child: Stack(
                  children: [
                    AnimatedSwitcher(
                      duration: Duration(milliseconds: 150),
                      transitionBuilder:
                          (Widget child, Animation<double> animation) {
                        return SlideTransition(
                          position: Tween<Offset>(
                            begin: weatherProv.isCelsius
                                ? Offset(1.0, 0.0)
                                : Offset(-1.0, 0.0),
                            end: Offset(0.0, 0.0),
                          ).animate(animation),
                          child: child,
                        );
                      },
                      child: weatherProv.isCelsius
                          ? GestureDetector(
                              key: ValueKey<int>(0),
                              child: Row(
                                children: [
                                  Container(
                                    height: 42.0,
                                    width: 42.0,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8.0),
                                      color: primaryBlue,
                                    ),
                                  ),
                                  Container(
                                    height: 42.0,
                                    width: 42.0,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8.0),
                                      color: Colors.grey.shade200,
                                    ),
                                  ),
                                ],
                              ),
                              onTap: () => weatherProv.switchTempUnit(),
                            )
                          : GestureDetector(
                              key: ValueKey<int>(1),
                              child: Row(
                                children: [
                                  Container(
                                    height: 42.0,
                                    width: 42.0,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8.0),
                                      color: Colors.grey.shade200,
                                    ),
                                  ),
                                  Container(
                                    height: 42.0,
                                    width: 42.0,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8.0),
                                      color: primaryBlue,
                                    ),
                                  ),
                                ],
                              ),
                              onTap: () => weatherProv.switchTempUnit(),
                            ),
                    ),
                    IgnorePointer(
                      child: Row(
                        children: [
                          Container(
                            height: 42.0,
                            width: 42.0,
                            alignment: Alignment.center,
                            child: Text(
                              '°C',
                              style: semiboldText.copyWith(
                                color: weatherProv.isCelsius
                                    ? Colors.white
                                    : Colors.grey.shade600,
                              ),
                            ),
                          ),
                          Container(
                            height: 42.0,
                            width: 42.0,
                            alignment: Alignment.center,
                            child: Text(
                              '°F',
                              style: semiboldText.copyWith(
                                color: weatherProv.isCelsius
                                    ? Colors.grey.shade600
                                    : Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        );
      },
    );
  }
}

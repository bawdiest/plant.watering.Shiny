plant.watering
========================================================
author: bawdiest@mikmak
date: 27.08.2016

About
========================================================

plant.watering help your plants to growth and survive hot summer when you are
- on holidays
- on work trip
- or just away from home

If you are not able to irrigate your plants yourself, plant.watering does it for you!

How It Works
========================================================

plant. watering uses
- an Arduino/Genuino Controller (http://arduino.cc) to turn your water pump on and off
- Actual Weather Parameters, e.g. from http://openweathermap.org/ (They provide a Web Service )
- Linear Regression Algorithm running on my NAS to predict how long it should turn your water pump on or how much water your plants need today

Predicitve Algorithm
========================================================
To predict how much water your pant needs, you should provide:
- Temperature in C<U+00BA>
- Pressure in hPa (QFE - Atmospheric pressure at airfield elevation)
- Wind in km/h
- Rain in mm/h
- Humidity in %

I trained my model last summer to irrigate my basilicum plant @10PM!

So the values you provide to this model should correspond to values in the evening on your location.


What plant.watering provides You
========================================================

ARROUND THE WEB
========================================================

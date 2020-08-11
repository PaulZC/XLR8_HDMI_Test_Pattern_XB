# XLR8 HDMI Test Pattern XB

An XLR8 XB which will run on the Alorium Technology Snō board and produce a simple HDMI Test Pattern

![test_pattern.jpg](img/test_pattern.jpg)

![hardware](img/hardware.jpg)

## Overview

This Xcelerator Block will run on the [Alorium Technology Snō](https://www.mouser.co.uk/ProductDetail/Alorium/SnoR20M16V3/?qs=sGAEpiMZZMve4%2FbfQkoj%252bCt7XfrcUv5s%2FrtyQWYQt6w=)
FPGA board and will produce a simple colored stripe test pattern at 640x480 pixels.

The Verilog for the HDMI generator is a remix of the KAMAMI maXimator HDMI Test example by Michał Kozioł:
- https://maximator-fpga.org/examples/
- https://maximator-fpga.org/wp-content/uploads/2017/03/maXimator-HDMI-test.zip
- https://youtu.be/agKPjtTc7_g

Once you have programmed the Snō with the XLR8Build 'bootloader', the blue status LED (D13) will blink a heartbeat at 1Hz.

The [examples](./XLR8Build/examples) folder contains a very simple test .ino which will allow you to change the R, G and B components of the test pattern.

## Resources

- https://www.aloriumtech.com/sno-quickstart/
- https://www.aloriumtech.com/documents/Sno_Pin_Map.pdf
- https://www.aloriumtech.com/sno-support/
- https://www.aloriumtech.com/openxlr8/
- https://www.aloriumtech.com/xcelerator-blocks/
- https://www.aloriumtech.com/webinars/

The _**Intro to OpenXLR8**_ webinar contains a _lot_ of useful information. You will need to watch that if you are using Snō and XBs for the first time.

## Connections

You will need a suitable HDMI Breakout or cable to connect the Snō pins to the HDMI port on your TV/Monitor, e.g.:
- https://www.mouser.co.uk/ProductDetail/Gravitech/HDMI-TERM?qs=fkzBJ5HM%252BdAarVr%2F6McOaQ%3D%3D

| Signal | HDMI Pin | Snō Pin |
|---|---|---|
| TMDS D2+ | 1 | D28 |
| TMDS D2S | 2 | GND |
| TMDS D2- | 3 | D34 |
| TMDS D1+ | 4 | D35 |
| TMDS D1S | 5 | GND |
| TMDS D1- | 6 | D22 |
| TMDS D0+ | 7 | D23 |
| TMDS D0S | 8 | GND |
| TMDS D0- | 9 | D29 |
| TMDS CLK+ | 10 | D30 |
| TMDS CLKS | 11 | GND |
| TMDS CLK- | 12 | D36 |
| Shield | | GND |

The Snō requires 3.3V power. Connecting it to 5V will damage it. Please make sure you are using one of the [recommended FTDI cables](https://www.aloriumtech.com/sno-quickstart/) to provide power for the board.

## LICENSE

This project is licensed under the [same license as the Alorium Technology template](XLR8Build/LICENSE)


Enjoy!

_**Paul**_

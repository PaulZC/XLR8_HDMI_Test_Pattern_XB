# XLR8 HDMI Test Pattern XB

An XLR8 XB which will run on the Alorium Technology Sno board and produce a simple HDMI Test Pattern

![test_pattern.jpg](img/test_pattern.jpg)

![hardware](img/hardware.jpg)

## Overview

This Xcelerator Block will run on the [Alorium Technologies Sno](https://www.mouser.co.uk/ProductDetail/Alorium/SnoR20M16V3/?qs=sGAEpiMZZMve4%2FbfQkoj%252bCt7XfrcUv5s%2FrtyQWYQt6w=)
FPGA board and will produce a simple colored stripe test pattern at 640x480 pixels.

The Verilog for the HDMI generator is a remix of the KAMAMI maXimator HDMI Test example:
- https://maximator-fpga.org/wp-content/uploads/2017/03/maXimator-HDMI-test.zip

## Resources

- https://www.aloriumtech.com/sno-quickstart/
- https://www.aloriumtech.com/sno-support/
- https://www.aloriumtech.com/openxlr8/
- https://www.aloriumtech.com/xcelerator-blocks/
- https://www.aloriumtech.com/webinars/

The _**Intro to OpenXLR8**_ webinar contains a _lot_ of useful information. You will need to watch that if you are using Sno and XBs for the first time.

Once you have programmed the Sno with the XLR8Build 'bootloader', the blue status LED (D13) will blink at 1Hz.

The [examples](./XLR8Build/examples) folder contains a very simple test .ino which will allow you to change the R, G and B components of the test pattern.

## Connections

You will need a suitable HDMI Breakout or cable to connect the Sno pins to the HDMI port on your TV/Monitor, e.g.:
- https://www.mouser.co.uk/ProductDetail/Gravitech/HDMI-TERM?qs=fkzBJ5HM%252BdAarVr%2F6McOaQ%3D%3D

Connect:
- TMDS D2+ (HDMI Pin 1) to Sno Pin D28
- TMDS D2- (HDMI Pin 3) to Sno Pin D34
- TMDS D1+ (HDMI Pin 4) to Sno Pin D35
- TMDS D1- (HDMI Pin 6) to Sno Pin D22
- TMDS D0+ (HDMI Pin 7) to Sno Pin D23
- TMDS D0- (HDMI Pin 9) to Sno Pin D29
- TMDS CLK+ (HDMI Pin 10) to Sno Pin D30
- TMDS CLK- (HDMI Pin 12) to Sno Pin D36
- Connect the Sno GND to: TMDS D2S(2)/D1S(5)/D0S(8)/CLKS(11)/Shield

The Sno needs 3.3V power. 5V will almost certainly damage it. Please make sure you are using one of the [recommended FTDI cables](https://www.aloriumtech.com/sno-quickstart/) to provide power for the board.

## LICENSE

This project is licensed under the [same license as the Alorium Technologies template](XLR8Build/LICENSE)

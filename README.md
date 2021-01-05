# nutri.gram

Nutrition is the main source of life and although it has been our secondary instinct to check for nutritional value in the food we eat, the effect any diet has in our body and health is consequential. From the fact which connotes the value of nutrition in our diet, springs the idea of nutri.gram. nutri.gram is a mobile application that scans the food label present in the packaged food items and draws a significant conclusion from that data regarding its edibleness for a person, the nutritional worth it adds to our diet, how much calorific value it provides per serving and much more. This application is targeted to anyone who wants to get insight into what they are feeding into their body and how understanding the nutritional value will be of tremendous aid to their overall health.

## Download OpenCV libraries

- Download OpenCV library for Android and iOS from [here](https://opencv.org/releases)
- Copy the files to the respective folders

```bash
For Android
cp -R sdk/native/jni/include nutri.gram
cp sdk/native/libs/* nutri.gram/android/src/main/jniLibs/*

For iOS
cp -R opencv2.framework nutri.gram/ios
```

## Flask server

- Download [this](https://github.com/tesseract-ocr/tessdata_best/blob/master/eng.traineddata) and put it in directory `ml/tessdata/`
- Download [this](https://github.com/oyyd/frozen_east_text_detection.pb/blob/master/frozen_east_text_detection.pb) and put it in directory `ml/models/`
- `cd ml`
- Run `pip install requirements.txt`
- Download following files and put in respective path
- Execute `flask run`

## Node Server

- `cp .env.sample .env`
- add credentials in `.env`
- cd `api`
- `npm install` to get packages
- `npm run dev` to start dev server

## Flutter

- cd `nutrigram_app`
- `flutter packages get` to get the packages
- Connect your device with USB debugging on or start an emulator
- `flutter run` to start debugging
- `flutter run --release` to build release build

> You may need to configure connection between api and flutter app make sure you are using your machine's ip address in `constants.dart`

## Screenshots

|                                      |                                      |                                    |                                    |
| :----------------------------------: | :----------------------------------: | :--------------------------------: | :--------------------------------: |
|   ![Screen 1](./screenshots/1.png)   |   ![Screen 2](./screenshots/2.png)   |  ![Screen 3](./screenshots/3.png)  |  ![Screen 4](./screenshots/4.png)  |
|   ![Screen 5](./screenshots/5.png)   |   ![Screen 7](./screenshots/7.png)   |  ![Screen 9](./screenshots/9.png)  | ![Screen 10](./screenshots/10.jpg) |
| ![Screen 10a](./screenshots/10a.jpg) | ![Screen 10b](./screenshots/10b.jpg) | ![Screen 12](./screenshots/12.png) | ![Screen 13](./screenshots/13.png) |
|  ![Screen 14](./screenshots/14.png)  |  ![Screen 15](./screenshots/15.png)  | ![Screen 16](./screenshots/16.png) | ![Screen 17](./screenshots/17.png) |
|  ![Screen 18](./screenshots/18.png)  |  ![Screen 19](./screenshots/19.png)  | ![Screen 20](./screenshots/20.png) | ![Screen 21](./screenshots/21.png) |
|  ![Screen 23](./screenshots/23.png)  |  ![Screen 24](./screenshots/24.png)  | ![Screen 25](./screenshots/25.png) | ![Screen 26](./screenshots/26.png) |
|  ![Screen 27](./screenshots/27.png)  |  ![Screen 28](./screenshots/28.png)  | ![Screen 29](./screenshots/29.png) | ![Screen 30](./screenshots/30.png) |
|  ![Screen 31](./screenshots/31.png)  |  ![Screen 32](./screenshots/32.png)  | ![Screen 33](./screenshots/33.png) |

This project uses [this](https://github.com/flutter-clutter/flutter-simple-edge-detection) repo as a reference for building edge detection in Flutter.

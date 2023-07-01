# 🎶 mozika 🎶

WCC week 1 projet.

## 📰 Description

For this first project we decided to make a music player app where we implement autosuggestion feature.

## 🚀 How to run

### 📲 Using prebuilt apk

There is a prebuilt apk in the package section of this repository that you can install on an Android device.

### 👷 Building your own apk

You need to have futter installed on your machine (`v3.0.0` or higher).
After cloning the repository, open a terminal on the root directory and type the following commands.

```
flutter pub get  # installing all the necessary dependencies
```

```
flutter build apk
```

Then, you can copy this file to your Android phone and install it `build/app/outputs/flutter-apk/app-release.apk` (or any emulator)

## 🖱 How to use the app

When you open the app for the first time, your are ask to choose a directory in which to search for music files (you can always clear the app's cache to get back to this step next time).

Then all the music present on the directory (and sub-directories) are listed (I recommend choosing a directory with only a few songs as the recursive search is kind of slowing the app).

You can now tap some keyword on the searchbar and the results show up instantly.

The result is divided in two section : 
1. a list of suggestion word
2. a list of matching song based on the filename

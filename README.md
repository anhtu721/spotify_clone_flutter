# Spotify Clone with Flutter

This is a simple Spotify clone application built using Flutter. The app mimics the basic features of the Spotify platform, allowing users to explore music, play tracks, and browse through playlists. The music files are stored and managed using Firebase.

## Features

- **User Interface**: A clean and responsive design similar to the Spotify app.
- **Search**: Search for songs, albums, and playlists.
- **Music Player**: Play, pause, and skip tracks.
- **Navigation**: Navigate between different sections like Home, Search, Library, and Now Playing.
- **Audio Streaming**: Integrates with Firebase Storage to stream music files.
- **User Authentication**: Users can sign in via Firebase Authentication (optional).
- **Firestore Database**: Store and retrieve music data (e.g., track details, album information) from Firestore.

## Tech Stack

- **Flutter**: Framework for building natively compiled applications for mobile, web, and desktop from a single codebase.
- **Dart**: Programming language used with Flutter.
- **Firebase**: Cloud platform for storing music files (Firebase Storage), managing user authentication (Firebase Auth), and storing metadata (Firestore).
- **Bloc**: State management solution for Flutter.

## Setup

To get started with the project, follow these steps:

### Prerequisites

- Install Flutter SDK: [Flutter Installation Guide](https://flutter.dev/docs/get-started/install)
- Set up an editor: [Editor Setup Guide](https://flutter.dev/docs/get-started/editor)
- Install Firebase CLI: [Firebase CLI Setup](https://firebase.google.com/docs/cli)
- Install dependencies: `flutter pub get`

### Firebase Configuration

1. Set up a Firebase project:
   - Go to [Firebase Console](https://console.firebase.google.com/).
   - Create a new project and configure Firebase services such as Firebase Authentication, Firebase Firestore, and Firebase Storage.
   - Add your Android and/or iOS apps to Firebase (follow the instructions on Firebase Console).

2. Add Firebase to your Flutter app:
   - Follow the steps in the [FlutterFire documentation](https://firebase.flutter.dev/docs/overview) to configure Firebase with Flutter.

...
### Screenshots


![Screenshot_getstated](https://github.com/user-attachments/assets/3fdfb206-5277-4acf-8128-bb59bce54472)
![Screenshot_Mode](https://github.com/user-attachments/assets/f535b376-780f-447b-b319-e2895a6c7eaf)
![Screenshot_Start](https://github.com/user-attachments/assets/531425b2-118c-4bcc-9d69-a715389a2a77)
![Screenshot_register](https://github.com/user-attachments/assets/134f9607-48f3-4c00-b90b-e5f208d03095)
![Screenshot_signin](https://github.com/user-attachments/assets/a4b25b01-15cc-4875-8ef6-7255eb05c9c7)
![Screenshot_home](https://github.com/user-attachments/assets/768bb3c7-18ac-49a7-9898-b080c42827e2)
![Screenshot_profile](https://github.com/user-attachments/assets/fb6930ed-2825-42cd-929c-64d7139e13ab)

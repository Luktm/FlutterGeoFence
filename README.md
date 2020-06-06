## Geofence Demo

### Flutter Setup

[Setup flutter](https://flutter.dev/docs/get-started/install/macos)

Clone the project.

### Run IOS Emulator

Change project directory. Eg; `cd/user/yourProjectDirectory/`.

Run `flutter pub get` command in terminal and wait for installing the package.

Change to ios directory, `cd ios`, run `pod install`, then back to root project.

Open Ios emulator.

Locate or drag the project folder to VCS. `Run > Run Without Debugging` or run command `flutter run` in terminal.
![Run without debugging](https://github.com/Luktm/FlutterGeoFence/blob/master/Documentation/vcs-run-dubuging.png)

### How To Use

Allow the permission, the map will appear.

Hold on the map UI to place the pin/geofence marker, which will allow a slider to appear. The slider will indicate the radius of the geofence.

Importantly, the initial marker placed won't trigger the geofence function. It will only happen when the user location is manually adjusted outside and inside the geofence boundary.

![Place Geofence Marker](https://github.com/Luktm/FlutterGeoFence/blob/master/Documentation/geofence-marker.png)

Open Google Maps, search any locations. Right click `What's here` option. Copy the latitude and longitude.

![Google Map Coordinate](https://github.com/Luktm/FlutterGeoFence/blob/master/Documentation/google-map-get-coordinate.png)

Ios emulator go to `Feature > Location > Custom Location` adjust the latitude or longitude. Eg; Changing 5.12345 to 6.12345 will get you out of the geofence area, vice versa to see the geofence function again.

![Location Setting](https://github.com/Luktm/FlutterGeoFence/blob/master/Documentation/ios-emulator-custom-location.png)

[Demo video](https://drive.google.com/file/d/1XyS7L1rmGYLBJZXqHos6h5jV4hhM-8RV/view?usp=sharing)

## Important Notice

Android platform still not able to fully work for this package [flutter_geofence](https://pub.dev/packages/flutter_geofence). The creator/developer still working on this [issues](https://github.com/DwayneCoussement/flutter_geofence/issues/5) for the android platform.

[APK download](https://drive.google.com/file/d/1LQ0nXKQXtySBGLlmmzStY063saNKdgiV/view?usp=sharing), the function is not work as expected as mention from the above, until further creator notice!!
## Geofence flutter setup.

1. [Setup flutter](https://flutter.dev/docs/get-started/install/macos)

2. Clone the project.

3. cd to the directory, eg. cd/user/yourProject Directory/.

4. run "flutter pub get" command in terminal and wait for installing the package.

5. cd to ios directory, run "pod install", wait for installing done, run command "cd .." to back the root directory.

6. All done.


## Run ios emulator.

1. Open the visual code studio, locate the project file or drag the project file to vcs, select "Run > Run Without Debugging" or run command "flutter run".
![Run without debugging](https://github.com/Luktm/FlutterGeoFence/blob/master/Documentation/vcs-run-dubuging.png)

2. Select ios emulator, it will run the app on the ios emulator for few seconds. (only for "Run Without Debugging")

3. If run by command "flutter run", emulator must be open by manually.


## How to use

1. Allow the permission, the map will appear.

2. Hold on the map UI to place the pin/geofence marker, which will allow a slider to appear. The slider will indicate the radius of the geofence.
![Place Geofence Marker](https://github.com/Luktm/FlutterGeoFence/blob/master/Documentation/geofence-marker.png)

3. Importantly, the initial marker placed won't trigger the geofence function. It will only happen when the user location is manually adjusted outside and inside the boundary. See instruction number 5.

4. Open Google Maps and search any locations. Then "right click" the "What's here" option. Finally, copy the latitude and longitude coordinate to clipboard.
![Google Map Coordinate](https://github.com/Luktm/FlutterGeoFence/blob/master/Documentation/google-map-get-coordinate.png)

5. Go back to ios emulator open "Feature > Location > Custom Location" and adjust the latitude or longitude for different coordinates. Eg; Changing 5.12345 to 6.12345 will get you out of the geofence area, vice versa to see the geofence function again.
![Location Setting](https://github.com/Luktm/FlutterGeoFence/blob/master/Documentation/ios-emulator-custom-location.png)

6. All done 

7. [Demo video](https://drive.google.com/file/d/1XyS7L1rmGYLBJZXqHos6h5jV4hhM-8RV/view?usp=sharing)

# Important Notice

Android platform still not able to fully work for this package [flutter_geofence](https://pub.dev/packages/flutter_geofence). The creator/developer still working on this [issues](https://github.com/DwayneCoussement/flutter_geofence/issues/5) for the android platform.

[APK download](https://drive.google.com/file/d/1LQ0nXKQXtySBGLlmmzStY063saNKdgiV/view?usp=sharing), the function is not work as expected as mention from the above, until further creator notice!!
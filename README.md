## Geofence flutter setup.

1. Clone the project.

2. cd to the directory, eg. cd/user/yourProject Directory/.

3. run "flutter pub get" command in terminal and wait for installing the package.

4. cd to ios directory, run "pod install", wait for installing done, run command "cd .." to back the root directory.

5. All done.


## Run ios emulator.

1. Open the visual code studio, select "Run > Run Without Debugging"
![Run without debugging](https://github.com/Luktm/FlutterGeoFence/blob/master/Documentation/vcs-run-dubuging.png)

2. Select ios emulator, it will run the app on the ios emulator for few seconds.

3. Allow the permission, the map will appear.

## How to use

1. Select your desired current user location. Adjust the location coordinate from ios emulator. select emulator and go "Feature > Location > Custom Location", fill the coordinate. 
![Location Setting](https://github.com/Luktm/FlutterGeoFence/blob/master/Documentation/ios-emulator-custom-location.png)

2. Open google map and find the coordinate from any places, "right click" > "What's here".
![Google Map Coordinate](https://github.com/Luktm/FlutterGeoFence/blob/master/Documentation/google-map-get-coordinate.png)

3. Long pressed the map to place the geofence marker, the slider will appear too. Slider indicated the geofence radius area.

4. Place the marker same as user current location for testing.

5. Again go to "Feature > Location > Custom Location", adjust one latitude to different coordinate. Eg; 5.12345 change to 6.12345 to get out the geofence area. The status change, notification appear with status.

6. All done

# Important Notice

Android platform still not able to fully work for this package [flutter_geofence](https://pub.dev/packages/flutter_geofence). The creator/developer still working on this issues. [Issues/Problem](https://github.com/DwayneCoussement/flutter_geofence/issues/5) for the android.

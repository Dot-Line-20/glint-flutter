# Welcome to Firebase_Getx_Boilerplate

This project was created for faster app development with **Firebase** and **Getx** early setting!

# Ready to Start!
 1. Change Project Name & Package Name!
 	 
	 **Project Name**
	
	For Android
	 
	```dart
	<application
	    android:name="io.flutter.app.FlutterApplication"
	    android:label="New Name"
	    android:icon="@mipmap/ic_launcher">  
	```
	For IOS
	```dart
	<key>CFBundleName</key>
	<string>New Name</string>
	```
	 
	  **Pacakge Name**
	  
	  For Android
	```dart
	<manifest xmlns:android="http://schemas.android.com/apk/res/android"
	    package="your.package.name">
	```
	```dart
	defaultConfig {
	    applicationId "your.package.name"
	    ...
	    }
	```
	```dart
	    package your.package.name;

	    import android.os.Bundle;
	    import io.flutter.app.FlutterActivity;
	    import io.flutter.plugins.GeneratedPluginRegistrant;
	    public class MainActivity extends FlutterActivity {
	```
	Change the directory name:

	From:

	```dart
	  android\app\src\main\java\com\example\name
	```

	To:

	```dart
	  android\app\src\main\java\your\package\name
	```
	For IOS
	```dart
	<key>CFBundleIdentifier</key>
	<string>com.your.packagename</string>
	```
	
	
 
 2. Do Firebase Initial Settings With Firebase CLI
	
	`firebase login`	
	
	`dart pub global activate flutterfire_cli` Do It Once!
	
	`flutterfire configure`
 3. Done!!!

# Issue & PR
I will continue to update!
Please show a lot of interest and support!!!

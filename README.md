# peer_to_peer_connect

A new Flutter application.

**About Apks**

**There are three different versions of the app, download whichever your phone supports**

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.


**For More Details on Installation Follow Below Steps:- -[Official docs for Linux Installations](https://flutter.dev/docs/get-started/install/linux)**

**HOW TO INSTALL FLUTTER IN LINUX MACHINE(UBUNTU)**

**System requirements**
To install and run Flutter, your development environment must meet these minimum requirements:

**Operating Systems: Linux (64-bit)**
Disk Space: 600 MB (does not include disk space for IDE/tools).
Tools: Flutter depends on these command-line tools being available in your environment. => bash curl file git 2.x mkdir rm unzip which xz-utils zip
**Shared libraries**: Flutter test command depends on this library being available in your environment.
libGLU.so.1 - provided by mesa packages such as libglu1-mesa on Ubuntu/Debian and mesa-libGLU on Fedora.

Installation:

    =>Step1: Download the following installation bundle to get the latest stable release of the Flutter SDK:
        - [Download latest Version](https://storage.googleapis.com/flutter_infra/releases/stable/linux/flutter_linux_2.0.2-stable.tar.xz)

   =>Step2: Extract the file in the desired location, for example:
        cd ~/development
        tar xf ~/Downloads/flutter_linux_2.0.2-stable.tar.xz
       
       If you don’t want to install a fixed version of the installation bundle, you can skip steps 1 and 2. Instead, get the source code from the Flutter repo on GitHub with the
       following command:
       
       $ git clone https://github.com/flutter/flutter.git
       
       You can also change branches or tags as needed. For example, to get just the stable version:
       
       $ git clone https://github.com/flutter/flutter.git -b stable --depth 1

   =>Step 3: Add the flutter tool to your path:
   
      $ export PATH="$PATH:`pwd`/flutter/bin"

      This command sets your PATH variable for the current terminal window only. To permanently add Flutter to your path, see -[Upadate](https://flutter.dev/docs/get
      -started/install/linux#update-your-path) your path.
      
   =>Step 4: Optionally, pre-download development binaries:
            The flutter tool downloads platform-specific development binaries as needed. For scenarios where pre-downloading these artifacts is preferable (for example, in
            hermetic build environments, or with intermittent network availability), iOS and Android binaries can be downloaded ahead of time by running:
            
            $ flutter precache
            
            For additional download options, see $ flutter help precache
            
   **You are now ready to run Flutter commands!**
   
   **Run flutter doctor**
   
   Run the following command to see if there are any dependencies you need to install to complete the setup (for verbose output, add the -v flag):
   
   $ flutter doctor
    
   This command checks your environment and displays a report to the terminal window. The Dart SDK is bundled with Flutter; it is not necessary to install Dart separately. Check
   the output carefully for other software you might need to install or further tasks to perform (shown in bold text). 
   
   => For example:
   
       [-] Android toolchain - develop for Android devices
        • Android SDK at /Users/obiwan/Library/Android/sdk
        ✗ Android SDK is missing command line tools; download from https://goo.gl/XxQghQ
        • Try re-installing or updating your Android SDK,
          visit https://flutter.dev/setup/#android-setup for detailed instructions.

        The following sections describe how to perform these tasks and finish the setup process.

        Once you have installed any missing dependencies, run the flutter doctor command again to verify that you’ve set everything up correctly
    
   =>Update your path
   
        In some cases, your distribution may not permanently acquire the path when using the above directions. When this occurs, you can change the environment variables file
        directly. These instructions require administrator privileges:
        
        1) Determine the directory where you placed the Flutter SDK.
        2) Locate the etc directory at the root of the system, and open the profile file with root privileges.
           
           $ sudo nano /etc/profile
           
        3) Update the PATH string with the location of your Flutter SDK directory.

            if [ "`id -u`" -eq 0 ]; then
               PATH="..."
            else
               PATH="/usr/local/bin:...:[PATH_TO_FLUTTER_GIT_DIRECTORY]/flutter/bin"
            fi
            export PATH
            

        4) End the current session or reboot your system
        5) Once you start a new session, verify that the flutter command is available by running:

            $ which flutter
            
   **Install Android Studio**
   
   1) Download and install -[Android Studio](https://developer.android.com/studio).
   2) Start Android Studio, and go through the ‘Android Studio Setup Wizard’. This installs the latest Android SDK, Android SDK Command-line Tools, and Android SDK Build-Tools,
      which are required by Flutter when developing for Android.
      
   =>**Set up your Android device**
        
        To prepare to run and test your Flutter app on an Android device, you need an Android device running Android 4.1 (API level 16) or higher.
        
        1)Enable Developer options and USB debugging on your device. Detailed instructions are available in the -[Android documentation]
        (https://developer.android.com/studio/debug/dev-options).
        
        2)Using a USB cable, plug your phone into your computer. If prompted on your device, authorize your computer to access your device.
        
        3)In the terminal, run the flutter devices command to verify that Flutter recognizes your connected Android device. By default, Flutter uses the version of the Android
          SDK where your adb tool is based. If you want Flutter to use a different installation of the Android SDK, you must set the ANDROID_SDK_ROOT environment variable to
          that installation directory.
          
   => **Set up the Android emulator**
   
        To prepare to run and test your Flutter app on the Android emulator, follow these steps:
        Step1: Enable VM acceleration on your machine.
        Step2: Launch Android Studio, click the AVD Manager icon, and select Create Virtual Device…
        
               In older versions of Android Studio, you should instead launch Android Studio > Tools > Android > AVD Manager and select Create Virtual Device…. 
               (The Android submenu is only present when inside an Android project.)
               
               If you do not have a project open, you can choose Configure > AVD Manager and select Create Virtual Device…
               
        Step3: Choose a device definition and select Next.
        Step4: Select one or more system images for the Android versions you want to emulate, and select Next. An x86 or x86_64 image is recommended.
        Step5: Under Emulated Performance, select Hardware - GLES 2.0 to enable hardware acceleration.
        Step6: Verify the AVD configuration is correct, and select Finish.
        Step7: In Android Virtual Device Manager, click Run in the toolbar. The emulator starts up and displays the default canvas for your selected OS version and device.

**Thats It! You're Done**
        
   






   




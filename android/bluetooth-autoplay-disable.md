Use Tasker to disable autoplay

1. Enable Tasker to sret media key listener
`sudo ./adb shell pm grant net.dinglisch.android.taskerm android.permission.SET_MEDIA_KEY_LISTENER`
2. Create profile 'Media Play Button' to handle play command
  - Media Button [Button=Play; Grab; Stop Event]
  - Task 'Capture Play Btn'
    1. Flash "Play Button Stopped" # Let the user know tasker is capturing this command
    2. Music Play "Silence.mp3" # Play mp3 of silence so Tasker definitely has media control
    3. Media Button Events [Release] # Remove Tasker as a media key listener
    4. Profile Status [Media Play Button; Set=Off] # Disable this profile so the device works normally
3. Create profile 'TBD Device Connected' to grab media keys when bluetooth connected
  - BT Connected (choose specific device if so desired)
  - Task 'Disable Autoplay'
    1. Turn On [500ms] # Force device to wake up, some people say this helps
    2. Media Button Events [Grab; Use New API] # Have Tasker request being the media key listener
    3. Profile Status [Media Play Button; Set=On] # Enable profile to handle play button
    4. Wait [30 seconds] # Wait 30 seconds for the automatic play command (which is the one we want to capture and ignore).  If it is never received, disable capturing play 'Capture Play Btn' profile so the connected device works normally
    5. Profile Status [Media Play Button; Set=Off]

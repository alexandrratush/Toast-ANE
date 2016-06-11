Toast ANE (Android)
=============================
######Native Extension for Adobe AIR [![Build Status](https://travis-ci.org/alexandrratush/Toast-ANE.svg?branch=master)](https://travis-ci.org/alexandrratush/Toast-ANE)

###Using the ANE:

* Add **[Toast.ane](https://github.com/alexandrratush/Toast-ANE/tree/master/ane/bin)** file to your air project.

* Add **com.aratush.ane.Toast** extension id to your application descriptor file. For example:
```xml
<!-- Identifies the ActionScript extensions used by an application. -->
<extensions>
	<extensionID>com.aratush.ane.Toast</extensionID>
</extensions>
```

###[Screenshot](screenshot.png)

###Code example:

```ActionScript
import com.aratush.ane.toast.DurationEnum;
import com.aratush.ane.toast.GravityEnum;
import com.aratush.ane.toast.ToastExtension;

if (ToastExtension.isSupported)
{
    var toast:ToastExtension = new ToastExtension();
    toast.setText("Hello");
    toast.setDuration(DurationEnum.LENGTH_LONG);
    toast.setGravity(GravityEnum.CENTER, 100, 50);
    toast.show();
    // close the toast 
    toast.cancel();
}
```

###API

* `ToastExtension.isSupported` - check whether Toast extension is supported on your platform.
* `setText()` - set the text in a Toast.
* `setDuration()` - set how long to show the view for it.
* `setGravity()` - set the location at which the notification should appear on the screen.
* `show()` - show the Toast for the specified parameters.
* `cancel()` - close the view if it's showing.

**NOTE:** For `setDuration()` and `setGravity()` methods use **DurationEnum** and **GravityEnum** classes respectively.
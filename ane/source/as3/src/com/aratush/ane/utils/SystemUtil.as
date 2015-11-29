package com.aratush.ane.utils
{
    import flash.system.Capabilities;

    public class SystemUtil
    {
        public static function isAndroid():Boolean
        {
            return Capabilities.os.toLowerCase().indexOf("linux") > -1;
        }
    }
}

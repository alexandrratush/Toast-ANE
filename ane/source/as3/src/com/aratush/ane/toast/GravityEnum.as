package com.aratush.ane.toast
{
    public class GravityEnum
    {
        public static const CENTER:GravityEnum = new GravityEnum(17);
        public static const RIGHT:GravityEnum = new GravityEnum(5);
        public static const BOTTOM:GravityEnum = new GravityEnum(80);
        public static const TOP:GravityEnum = new GravityEnum(48);
        public static const LEFT:GravityEnum = new GravityEnum(3);
        public static const FILL:GravityEnum = new GravityEnum(119);
        public static const FILL_HORIZONTAL:GravityEnum = new GravityEnum(7);
        public static const FILL_VERTICAL:GravityEnum = new GravityEnum(112);
        public static const NO_GRAVITY:GravityEnum = new GravityEnum(0);

        private static var _isCreated:Boolean = false;
        // magic happens here, the static code block
        {
            _isCreated = true;
        }

        private var _value:int;

        public function GravityEnum(value:int)
        {
            if (_isCreated) throw new Error("This application domain already initialized this enum.");
            _value = value;
        }

        public function get value():int
        {
            return _value;
        }
    }
}

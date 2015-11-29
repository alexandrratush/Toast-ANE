package com.aratush.ane.toast
{
    public class DurationEnum
    {
        public static const LENGTH_SHORT:DurationEnum = new DurationEnum(0);
        public static const LENGTH_LONG:DurationEnum = new DurationEnum(1);

        private static var _isCreated:Boolean = false;
        // magic happens here, the static code block
        {
            _isCreated = true;
        }

        private var _value:int;

        public function DurationEnum(value:int)
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

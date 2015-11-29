package com.aratush.ane.utils
{
    public class StringUtil
    {
        public static function trimWhitespace(str:String):String
        {
            var rex:RegExp = /[\s\r\n]+/gim;
            return str.replace(rex, "");
        }

        public static function isTextValid(text:String):Boolean
        {
            return (text && StringUtil.trimWhitespace(text));
        }
    }
}

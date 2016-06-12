package com.aratush.ane.toast
{
    import com.aratush.ane.utils.StringUtil;
    import com.aratush.ane.utils.SystemUtil;

    import flash.events.ErrorEvent;
    import flash.events.EventDispatcher;
    import flash.events.StatusEvent;
    import flash.external.ExtensionContext;

    public class ToastExtension extends EventDispatcher
    {
        public static const EXTENSION_ID:String = "com.aratush.ane.Toast";

        protected var _context:ExtensionContext;

        public function ToastExtension()
        {
            if (!isSupported)
                throw new Error("ToastExtension is not supported on this platform. Use ToastExtension.isSupported getter.");
            _context = ExtensionContext.createExtensionContext(EXTENSION_ID, "");
            _context.addEventListener(StatusEvent.STATUS, onStatusEventHandler);
        }

        public function show():void
        {
            _context.call("show");
        }

        public function setText(text:String):void
        {
            if (StringUtil.isTextValid(text))
                _context.call("setText", text);
            else
                throw new ArgumentError("Parameter text is not valid");
        }

        public function setDuration(duration:DurationEnum):void
        {
            _context.call("setDuration", duration.value);
        }

        public function setGravity(gravity:GravityEnum, xOffset:int = 0, yOffset:int = 0):void
        {
            _context.call("setGravity", gravity.value, xOffset, yOffset);
        }

        public function cancel():void
        {
            _context.call("cancel");
        }

        public function dispose():void
        {
            if (_context != null)
            {
                _context.removeEventListener(StatusEvent.STATUS, onStatusEventHandler);
                _context.dispose();
                _context = null;
            }
        }

        protected function onStatusEventHandler(e:StatusEvent):void
        {
            const ERROR_EVENT:String = "error_event";

            switch (e.level)
            {
                case ERROR_EVENT:
                    dispatchEvent(new ErrorEvent(ErrorEvent.ERROR, false, false, e.code));
                    break;
                default:
                    dispatchEvent(e);
            }
        }

        public static function get isSupported():Boolean
        {
            return SystemUtil.isAndroid();
        }
    }
}

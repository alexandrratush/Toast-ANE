package screens.toast
{
    import com.aratush.ane.toast.DurationEnum;
    import com.aratush.ane.toast.GravityEnum;

    public class ToastSettings
    {
        public var text:String;
        public var offsetX:int;
        public var offsetY:int;
        public var duration:DurationEnum = DurationEnum.LENGTH_LONG;
        public var gravity:GravityEnum = GravityEnum.BOTTOM;
        public var durationSelectedIndex:int = 0;
        public var gravitySelectedIndex:int = 0;
    }
}

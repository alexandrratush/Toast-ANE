package screens.toast
{
    import com.aratush.ane.toast.GravityEnum;
    import com.aratush.ane.toast.ToastExtension;

    import feathers.controls.Button;
    import feathers.controls.Label;
    import feathers.controls.LayoutGroup;
    import feathers.layout.AnchorLayout;
    import feathers.layout.AnchorLayoutData;
    import feathers.layout.VerticalLayout;

    import flash.events.ErrorEvent;

    import screens.*;

    import starling.events.Event;

    public class ToastScreen extends BaseScreen
    {
        public static const SHOW_SETTINGS:String = "showSettings";

        private var _showToastButton:Button;
        private var _cancelToastButton:Button;
        private var _toastExtension:ToastExtension;
        private var _settings:ToastSettings;

        public function ToastScreen()
        {
            super();
        }

        override protected function initialize():void
        {
            super.initialize();

            title = "Toast";
            headerFactory = customHeaderFactory;
            layout = new AnchorLayout();

            var anchorLayoutData:AnchorLayoutData = new AnchorLayoutData();
            anchorLayoutData.horizontalCenter = 0;
            anchorLayoutData.verticalCenter = 0;

            var verticalLayout:VerticalLayout = new VerticalLayout();
            verticalLayout.horizontalAlign = VerticalLayout.HORIZONTAL_ALIGN_CENTER;
            verticalLayout.verticalAlign = VerticalLayout.VERTICAL_ALIGN_MIDDLE;
            verticalLayout.gap = 15;

            var layoutGroup:LayoutGroup = new LayoutGroup();
            layoutGroup.layout = verticalLayout;
            layoutGroup.layoutData = anchorLayoutData;
            addChild(layoutGroup);

            if (ToastExtension.isSupported)
            {
                _toastExtension = new ToastExtension();
                _toastExtension.addEventListener(ErrorEvent.ERROR, toastErrorHandler);

                _showToastButton = new Button();
                _showToastButton.label = "Show toast";
                _showToastButton.layoutData = anchorLayoutData;
                _showToastButton.addEventListener(Event.TRIGGERED, showToastButtonTriggeredHandler);
                layoutGroup.addChild(_showToastButton);

                _cancelToastButton = new Button();
                _cancelToastButton.label = "Cancel toast";
                _cancelToastButton.layoutData = anchorLayoutData;
                _cancelToastButton.addEventListener(Event.TRIGGERED, cancelToastButtonTriggeredHandler);
                layoutGroup.addChild(_cancelToastButton);
            } else
            {
                var label:Label = new Label();
                label.text = "Toast extension is not supported";
                label.layoutData = anchorLayoutData;
                layoutGroup.addChild(label);
            }
        }

        override public function dispose():void
        {
            if (ToastExtension.isSupported)
            {
                _toastExtension.dispose();
                _toastExtension.removeEventListener(ErrorEvent.ERROR, toastErrorHandler);
                _toastExtension = null;

                _showToastButton.removeEventListener(Event.TRIGGERED, showToastButtonTriggeredHandler);
                _cancelToastButton.removeEventListener(Event.TRIGGERED, cancelToastButtonTriggeredHandler);
            }
            super.dispose();
        }

        private function toastErrorHandler(e:ErrorEvent):void
        {
            trace("toastErrorHandler " + e.text);
        }

        override protected function settingsButtonTriggeredHandler(e:Event):void
        {
            dispatchEvent(new Event(ToastScreen.SHOW_SETTINGS));
        }

        private function showToastButtonTriggeredHandler(event:Event):void
        {
            _toastExtension.setDuration(_settings.duration);
            _toastExtension.setGravity(_settings.gravity, _settings.offsetX, _settings.offsetY);

            try
            {
                _toastExtension.setText(_settings.text);
            } catch (e:Error)
            {
                _toastExtension.setText(e.message);
                _toastExtension.setGravity(GravityEnum.NO_GRAVITY);
            } finally
            {
                _toastExtension.show();
            }
        }

        private function cancelToastButtonTriggeredHandler(event:Event):void
        {
            _toastExtension.cancel();
        }

        public function set settings(value:ToastSettings):void
        {
            _settings = value;
        }
    }
}

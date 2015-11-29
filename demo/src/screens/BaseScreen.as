package screens
{
    import feathers.controls.Button;
    import feathers.controls.Header;
    import feathers.controls.PanelScreen;

    import starling.display.DisplayObject;
    import starling.events.Event;

    public class BaseScreen extends PanelScreen
    {
        public function BaseScreen()
        {
            super();
        }

        protected function customHeaderFactory():Header
        {
            var header:Header = new Header();
            var backButton:Button = new Button();
            backButton.styleNameList.add(Button.ALTERNATE_STYLE_NAME_BACK_BUTTON);
            backButton.label = "Back";
            backButton.addEventListener(Event.TRIGGERED, backButtonTriggeredHandler);
            header.leftItems = new <DisplayObject>
                    [
                        backButton
                    ];

            var settingsButton:Button = new Button();
            settingsButton.label = "Settings";
            settingsButton.addEventListener(Event.TRIGGERED, settingsButtonTriggeredHandler);
            header.rightItems = new <DisplayObject>
                    [
                        settingsButton
                    ];
            return header;
        }

        protected function backButtonTriggeredHandler(event:Event):void
        {
            dispatchEventWith(Event.COMPLETE);
        }

        protected function settingsButtonTriggeredHandler(e:Event):void
        {

        }

        protected function customSettingHeaderFactory():Header
        {
            var header:Header = new Header();
            var doneButton:Button = new Button();
            doneButton.label = "Done";
            doneButton.addEventListener(Event.TRIGGERED, doneButtonTriggeredHandler);
            header.rightItems = new <DisplayObject>
                    [
                        doneButton
                    ];
            return header;
        }

        protected function doneButtonTriggeredHandler(event:Event):void
        {
            dispatchEventWith(Event.COMPLETE);
        }
    }
}

package
{
    import feathers.controls.Drawers;
    import feathers.controls.StackScreenNavigator;
    import feathers.controls.StackScreenNavigatorItem;
    import feathers.motion.Cover;
    import feathers.motion.Reveal;
    import feathers.motion.Slide;
    import feathers.themes.MetalWorksMobileTheme;

    import screens.MainMenuScreen;
    import screens.toast.ToastScreen;
    import screens.toast.ToastSettings;
    import screens.toast.ToastSettingsScreen;

    import starling.events.Event;

    public class ApplicationRoot extends Drawers
    {
        private static const MAIN_MENU:String = "mainMenu";
        private static const TOAST:String = "toast";
        private static const TOAST_SETTINGS:String = "toastSettings";

        private static const MAIN_MENU_EVENTS:Object =
        {
            showToast: TOAST
        };

        public function ApplicationRoot()
        {
            addEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
        }

        private var _navigator:StackScreenNavigator;

        private function init():void
        {
            new MetalWorksMobileTheme();

            _navigator = new StackScreenNavigator();
            content = _navigator;

            var toastSetting:ToastSettings = new ToastSettings();

            var toastItem:StackScreenNavigatorItem = new StackScreenNavigatorItem(ToastScreen);
            toastItem.setScreenIDForPushEvent(ToastScreen.SHOW_SETTINGS, TOAST_SETTINGS);
            toastItem.addPopEvent(Event.COMPLETE);
            toastItem.properties.settings = toastSetting;
            _navigator.addScreen(TOAST, toastItem);

            var toastSettingsItem:StackScreenNavigatorItem = new StackScreenNavigatorItem(ToastSettingsScreen);
            toastSettingsItem.addPopEvent(Event.COMPLETE);
            toastSettingsItem.pushTransition = Cover.createCoverUpTransition();
            toastSettingsItem.popTransition = Reveal.createRevealDownTransition();
            toastSettingsItem.properties.settings = toastSetting;
            _navigator.addScreen(TOAST_SETTINGS, toastSettingsItem);

            var mainMenuScreen:StackScreenNavigatorItem = new StackScreenNavigatorItem(MainMenuScreen);
            _navigator.addScreen(MAIN_MENU, mainMenuScreen);

            for (var eventType:String in MAIN_MENU_EVENTS)
            {
                mainMenuScreen.setScreenIDForPushEvent(eventType, MAIN_MENU_EVENTS[eventType] as String);
            }

            _navigator.rootScreenID = MAIN_MENU;
            _navigator.pushTransition = Slide.createSlideLeftTransition();
            _navigator.popTransition = Slide.createSlideRightTransition();
        }

        private function addedToStageHandler(e:Event):void
        {
            removeEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
            init();
        }
    }
}

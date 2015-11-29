package screens
{
    import feathers.controls.List;
    import feathers.controls.PanelScreen;
    import feathers.controls.renderers.DefaultListItemRenderer;
    import feathers.controls.renderers.IListItemRenderer;
    import feathers.data.ListCollection;
    import feathers.layout.AnchorLayout;
    import feathers.layout.AnchorLayoutData;

    import starling.events.Event;

    public class MainMenuScreen extends PanelScreen
    {
        public static const SHOW_TOAST:String = "showToast";

        private var _list:List;

        public function MainMenuScreen()
        {
            super();
        }

        override protected function initialize():void
        {
            super.initialize();
            title = "Main menu";
            layout = new AnchorLayout();

            _list = new List();
            _list.layoutData = new AnchorLayoutData(0, 0, 0, 0);
            _list.clipContent = false;
            _list.dataProvider = listDataProvider();
            _list.autoHideBackground = true;
            _list.itemRendererFactory = listItemRenderFactory;
            _list.addEventListener(Event.CHANGE, listChangeHandler);
            addChild(_list);
        }

        private function listDataProvider():ListCollection
        {
            return new ListCollection(
                    [
                        {label: "Toast", event: SHOW_TOAST}
                    ]
            );
        }

        private function listItemRenderFactory():IListItemRenderer
        {
            var renderer:DefaultListItemRenderer = new DefaultListItemRenderer();
            renderer.isQuickHitAreaEnabled = true;
            renderer.labelField = "label";
            return renderer;
        }

        private function listChangeHandler(e:Event):void
        {
            var eventType:String = _list.selectedItem.event as String;
            dispatchEventWith(eventType);
        }
    }
}

package screens.toast
{
    import com.aratush.ane.toast.DurationEnum;
    import com.aratush.ane.toast.GravityEnum;

    import feathers.controls.List;
    import feathers.controls.PickerList;
    import feathers.controls.TextInput;
    import feathers.controls.renderers.DefaultListItemRenderer;
    import feathers.controls.renderers.IListItemRenderer;
    import feathers.data.ListCollection;
    import feathers.layout.AnchorLayout;
    import feathers.layout.AnchorLayoutData;

    import screens.*;

    import starling.events.Event;

    public class ToastSettingsScreen extends BaseScreen
    {
        private var _list:List;
        private var _textInput:TextInput;
        private var _offsetXInput:TextInput;
        private var _offsetYInput:TextInput;
        private var _durationPickerList:PickerList;
        private var _gravityPickerList:PickerList;
        private var _settings:ToastSettings;

        public function ToastSettingsScreen()
        {
            super();
        }

        override protected function initialize():void
        {
            super.initialize();
            title = "Toast settings";
            headerFactory = customSettingHeaderFactory;
            layout = new AnchorLayout();

            _textInput = new TextInput();
            _textInput.text = _settings.text;

            _offsetXInput = new TextInput();
            _offsetXInput.restrict = "0-9.\\-";
            _offsetXInput.text = _settings.offsetX.toString();

            _offsetYInput = new TextInput();
            _offsetYInput.restrict = "0-9.\\-";
            _offsetYInput.text = _settings.offsetY.toString();

            _durationPickerList = new PickerList();
            _durationPickerList.dataProvider = getDurationListCollection();
            _durationPickerList.labelField = "text";
            _durationPickerList.listProperties.itemRendererFactory = itemRendererFactory;
            _durationPickerList.selectedIndex = _settings.durationSelectedIndex;

            _gravityPickerList = new PickerList();
            _gravityPickerList.dataProvider = getGravityListCollection();
            _gravityPickerList.labelField = "text";
            _gravityPickerList.listProperties.itemRendererFactory = itemRendererFactory;
            _gravityPickerList.listProperties.height = 400;
            _gravityPickerList.selectedIndex = _settings.gravitySelectedIndex;

            _list = new List();
            _list.isSelectable = false;
            _list.dataProvider = listDataProvider();
            _list.layoutData = new AnchorLayoutData(0, 0, 0, 0);
            _list.clipContent = false;
            _list.autoHideBackground = true;
            addChild(_list);
        }

        override protected function doneButtonTriggeredHandler(event:Event):void
        {
            _settings.text = _textInput.text;
            _settings.offsetX = int(_offsetXInput.text);
            _settings.offsetY = int(_offsetYInput.text);
            _settings.duration = _durationPickerList.selectedItem.duration;
            _settings.gravity = _gravityPickerList.selectedItem.gravity;
            _settings.durationSelectedIndex = _durationPickerList.selectedIndex;
            _settings.gravitySelectedIndex = _gravityPickerList.selectedIndex;
            super.doneButtonTriggeredHandler(event);
        }

        private function listDataProvider():ListCollection
        {
            return new ListCollection(
                    [
                        {label: "Text", accessory: _textInput},
                        {label: "Offset x-position", accessory: _offsetXInput},
                        {label: "Offset y-position", accessory: _offsetYInput},
                        {label: "Duration", accessory: _durationPickerList},
                        {label: "Gravity", accessory: _gravityPickerList}
                    ]
            );
        }

        private function getDurationListCollection():ListCollection
        {
            return new ListCollection(
                    [
                        {text: "LONG", duration: DurationEnum.LENGTH_LONG},
                        {text: "SHORT", duration: DurationEnum.LENGTH_SHORT}
                    ]
            );
        }

        private function getGravityListCollection():ListCollection
        {
            return new ListCollection(
                    [
                        {text: "BOTTOM", gravity: GravityEnum.BOTTOM},
                        {text: "LEFT", gravity: GravityEnum.LEFT},
                        {text: "RIGHT", gravity: GravityEnum.RIGHT},
                        {text: "TOP", gravity: GravityEnum.TOP},
                        {text: "CENTER", gravity: GravityEnum.CENTER},
                        {text: "FILL", gravity: GravityEnum.FILL},
                        {text: "FILL_HORIZONTAL", gravity: GravityEnum.FILL_HORIZONTAL},
                        {text: "FILL_VERTICAL", gravity: GravityEnum.FILL_VERTICAL},
                        {text: "NO_GRAVITY", gravity: GravityEnum.NO_GRAVITY}
                    ]
            );
        }

        private function itemRendererFactory():IListItemRenderer
        {
            var renderer:DefaultListItemRenderer = new DefaultListItemRenderer();
            renderer.labelField = "text";
            return renderer;
        }

        public function set settings(value:ToastSettings):void
        {
            _settings = value;
        }
    }
}

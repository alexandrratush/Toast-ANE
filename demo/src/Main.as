package
{
    import flash.display.Sprite;
    import flash.display.StageAlign;
    import flash.display.StageScaleMode;
    import flash.events.Event;
    import flash.geom.Rectangle;

    import starling.core.Starling;

    public class Main extends Sprite
    {
        private var _starling:Starling;

        public function Main()
        {
            stage.scaleMode = StageScaleMode.NO_SCALE;
            stage.align = StageAlign.TOP_LEFT;

            _starling = new Starling(ApplicationRoot, stage, null, null);
            _starling.showStats = true;
            _starling.start();

            stage.addEventListener(Event.RESIZE, stageResizeHandler, false, int.MAX_VALUE, true);
            stage.addEventListener(Event.DEACTIVATE, stageDeactivateHandler, false, 0, true);
        }

        private function stageResizeHandler(e:Event):void
        {
            _starling.stage.stageWidth = stage.stageWidth;
            _starling.stage.stageHeight = stage.stageHeight;

            var viewPort:Rectangle = _starling.viewPort;
            viewPort.width = stage.stageWidth;
            viewPort.height = stage.stageHeight;

            try
            {
                _starling.viewPort = viewPort;
            } catch (e:Error)
            {
            }
        }

        private function stageDeactivateHandler(e:Event):void
        {
            _starling.stop(true);
            stage.addEventListener(Event.ACTIVATE, stageActivateHandler, false, 0, true);
        }

        private function stageActivateHandler(e:Event):void
        {
            stage.removeEventListener(Event.ACTIVATE, stageActivateHandler);
            _starling.start();
        }
    }
}

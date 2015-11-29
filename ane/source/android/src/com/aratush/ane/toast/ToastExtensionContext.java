package com.aratush.ane.toast;

import android.view.Gravity;
import android.widget.Toast;
import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.adobe.fre.FREObject;

import java.util.HashMap;
import java.util.Map;

public class ToastExtensionContext extends FREContext {

    private static final String ERROR_EVENT = "error_event";

    private static final String SHOW_FUNCTION = "show";
    private static final String SET_TEXT_FUNCTION = "setText";
    private static final String SET_DURATION_FUNCTION = "setDuration";
    private static final String SET_GRAVITY_FUNCTION = "setGravity";
    private static final String CANCEL_FUNCTION = "cancel";

    private Toast toast = null;
    private String text = "";
    private int duration = Toast.LENGTH_SHORT;
    private int gravity = Gravity.NO_GRAVITY;
    private int xOffset = 0;
    private int yOffset = 0;

    @Override
    public void dispose() {
        if (toast != null) {
            toast.cancel();
            toast = null;
        }
    }

    @Override
    public Map<String, FREFunction> getFunctions() {
        Map<String, FREFunction> map = new HashMap<>();
        map.put(SHOW_FUNCTION, new ShowFunction());
        map.put(SET_TEXT_FUNCTION, new SetTextFunction());
        map.put(SET_DURATION_FUNCTION, new SetDurationFunction());
        map.put(SET_GRAVITY_FUNCTION, new SetGravityFunction());
        map.put(CANCEL_FUNCTION, new CancelFunction());
        return map;
    }

    public class ShowFunction implements FREFunction {
        @Override
        public FREObject call(FREContext context, FREObject[] args) {
            try {
                toast = Toast.makeText(context.getActivity(), text, duration);
                if (gravity != Gravity.NO_GRAVITY)
                    toast.setGravity(gravity, xOffset, yOffset);
                toast.show();
            } catch (Exception e) {
                context.dispatchStatusEventAsync(SHOW_FUNCTION + ": " + e, ERROR_EVENT);
            }

            return null;
        }
    }

    public class SetTextFunction implements FREFunction {
        @Override
        public FREObject call(FREContext context, FREObject[] args) {
            try {
                text = args[0].getAsString();
            } catch (Exception e) {
                context.dispatchStatusEventAsync(SET_TEXT_FUNCTION + ": " + e, ERROR_EVENT);
            }

            return null;
        }
    }

    public class SetDurationFunction implements FREFunction {
        @Override
        public FREObject call(FREContext context, FREObject[] args) {
            try {
                duration = args[0].getAsInt();
            } catch (Exception e) {
                context.dispatchStatusEventAsync(SET_DURATION_FUNCTION + ": " + e, ERROR_EVENT);
            }

            return null;
        }
    }

    public class SetGravityFunction implements FREFunction {
        @Override
        public FREObject call(FREContext context, FREObject[] args) {
            try {
                gravity = args[0].getAsInt();
                xOffset = args[1].getAsInt();
                yOffset = args[2].getAsInt();
            } catch (Exception e) {
                context.dispatchStatusEventAsync(SET_GRAVITY_FUNCTION + ": " + e, ERROR_EVENT);
            }

            return null;
        }
    }

    public class CancelFunction implements FREFunction {
        @Override
        public FREObject call(FREContext context, FREObject[] args) {
            try {
                toast.cancel();
            } catch (Exception e) {
                context.dispatchStatusEventAsync(CANCEL_FUNCTION + ": " + e, ERROR_EVENT);
            }

            return null;
        }
    }
}

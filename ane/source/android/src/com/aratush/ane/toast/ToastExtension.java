package com.aratush.ane.toast;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREExtension;

public class ToastExtension implements FREExtension {

    public FREContext context;

    @Override
    public FREContext createContext(String extId) {
        return context = new ToastExtensionContext();
    }

    @Override
    public void dispose() {
        if (context != null) {
            context.dispose();
            context = null;
        }
    }

    @Override
    public void initialize() {

    }
}

package com.sadcoat.flutter.plugins.intentforpackage;

import android.content.Context;
import android.content.Intent;
import android.net.Uri;
import android.os.Bundle;
import android.provider.Settings;
import android.util.Log;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.PluginRegistry.Registrar;
import java.util.ArrayList;
import java.util.Map;

/** IntentForPackagePlugin */
@SuppressWarnings("unchecked")
public class IntentForPackagePlugin implements MethodCallHandler {
  private static final String TAG = IntentForPackagePlugin.class.getCanonicalName();
  private final Registrar mRegistrar;

  /** Plugin registration. */
  public static void registerWith(Registrar registrar) {
    final MethodChannel channel =
        new MethodChannel(registrar.messenger(), "plugins.sadcoat.com/intent_for_package");
    channel.setMethodCallHandler(new IntentForPackagePlugin(registrar));
  }

  private IntentForPackagePlugin(Registrar registrar) {
    this.mRegistrar = registrar;
  }

  private Context getActiveContext() {
    return (mRegistrar.activity() != null) ? mRegistrar.activity() : mRegistrar.context();
  }

  private Intent getLaunchIntentForPackage(String intentPackage) {
    return getActiveContext().getPackageManager().getLaunchIntentForPackage(intentPackage);
  }

  @Override
  public void onMethodCall(MethodCall call, Result result) {
    String intentPackage = call.argument("package");
    if (call.method.equals("canLaunch")) {
      result.success(getLaunchIntentForPackage(intentPackage) != null);
    } else if (call.method.equals("launch")) {      
      Context context = getActiveContext();
      Intent intent = getLaunchIntentForPackage(intentPackage);
      if (intent == null) {
        String storeUrl = call.argument("storeUrl");
        intent = new Intent(Intent.ACTION_VIEW);
        intent.setData(Uri.parse(storeUrl));
      }
      context.startActivity(intent);
      result.success(null);
    } else {
      result.notImplemented();
    }
  }
}

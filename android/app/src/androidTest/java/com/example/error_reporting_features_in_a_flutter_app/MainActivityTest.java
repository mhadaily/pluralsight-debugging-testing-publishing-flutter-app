package com.example.error_reporting_features_in_a_flutter_app;

import androidx.test.rule.ActivityTestRule;
import dev.flutter.plugins.integration_test.FlutterTestRunner;
import org.junit.Rule;
import org.junit.runner.RunWith;

// import MainActivity from our main app
import com.example.error_reporting_features_in_a_flutter_app.MainActivity;

@RunWith(FlutterTestRunner.class)
public class MainActivityTest {
  @Rule
  public ActivityTestRule<MainActivity> rule = 
  new ActivityTestRule<>(MainActivity.class, true, false);
}









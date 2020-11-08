/*  This is the splash screen while services are starting up.
    Automatically move to Home Page after all checks are complete.
    No User Interaction will happen on this page.

    - Images stored in flutter assets (pubspec.yaml: flutter : assets)
    - Flutter loadingBuilder() to put loading bar? Expect <3 second load times, load bar may not be necessary.
 */

public class SplashScreenWithTransition implements SplashScreen {
  private MySplashView mySplashView;

  @Override
  @Nullable
  public View createSplashView(
      @NonNull Context context,
      @Nullable Bundle savedInstanceState
      ) {
    // A reference to the MySplashView is retained so that it can be told
    // to transition away at the appropriate time.
    mySplashView = new MySplashView(context);
    return mySplashView;
  }

  @Override
  public void transitionToFlutter(@NonNull Runnable onTransitionComplete) {
    // Instruct MySplashView to animate away in whatever manner it wants.
    // The onTransitionComplete Runnable is passed to the MySplashView
    // to be invoked when the transition animation is complete.
    mySplashView.animateAway(onTransitionComplete);
  }
}
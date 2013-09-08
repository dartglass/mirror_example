import 'dart:html' as html;
import "package:google_oauth2_client/google_oauth2_browser.dart";
import "package:google_mirror_v1_api/mirror_v1_api_browser.dart";
import "package:google_mirror_v1_api/mirror_v1_api_client.dart";

final String CLIENT_ID = '881188623772.apps.googleusercontent.com';
final List<String> SCOPES = [
'https://www.googleapis.com/auth/userinfo.profile',
'https://www.googleapis.com/auth/glass.timeline'
];
final String API_KEY = 'AIzaSyBfA-Zqg9hVWVBJHLXj0ycQTyB3J0IYyN0';

GoogleOAuth2 auth;

final String timeLinehtml = """
<article class="photo cover-only">  
  <img src="http://www.glassfrogger.com/images/game-field.jpg" height="100%" width="100%">  
  <div class="photo-overlay"></div>  
  <section>    
    <p class="text-auto-size">
      <strong class="white">Google Glass</strong> 
      <em class="blue">Dartified!</em>
    </p>  
  </section>
  <footer>    
    <img src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABUAAAAVCAMAAACeyVWkAAAAGXRFWHRTb2Z0d2FyZQBBZG9iZSBJbWFnZVJlYWR5ccllPAAAAJxQTFRFAAAAAIvMdsvDAIvMdsvDAIvMdsvDLaTJAIvMOqnHdsvDAIvMdsvDAIvMKaLJdsvDAIvMAIvMdsvDAIvMdsvDdsvDAIvMAIvMAZnFdsvDAILHAIPHAITIAIXJAIfKAIjKAIrLAIrMAIvMAJXHAJjFC5i/I6HENr2yOb6zPr+0TsK4UsO5WbnEWcW8Xsa9Yse+Zsi/asjAc8rCdsvDdt4SRQAAABp0Uk5TABAQICAwMFBgYGBwcICAgI+vr7+/z9/v7+97IXGnAAAAqUlEQVQYV13QxxaCQBBE0VZkjBgAGVEBaVEUM/P//yaTGg5vV3dZANTCZ9BvFAoR93kVC9FnthW6uIPTJ7UkdHaXvS2LXKNBURInyDXPsShbzjU7XCpxhooDVGo5QcQAJmjUco64AY/UcIrowYCTaj5KBZeTaj5JBTc6l11OlQKMf497y1ahefFb3TQfcqtM/fipJF/X9gnDon6/ah/aDDfNOgosNA2b8QdGciZlh/U93AAAAABJRU5ErkJggg==" class="left">  
    <p>Dart Hacking</p>   
  </footer> 
</article>

<article class="auto-paginate">  
  <ol class="text-x-small">  
  <strong>Instructions:</strong>
  <hr>  
    <li>First item</li>    
    <li>Second item</li>    
    <li>Third item</li>    
    <li>Fourth item</li>  
  </ol>
</article>
""";

void insertCard(Token token) {
  Mirror mirror = new Mirror(auth);
  mirror.makeAuthRequests = true;

  NotificationConfig notification = new NotificationConfig.fromJson({})
  ..level = "DEFAULT";

  MenuItem menuItem = new MenuItem.fromJson({})
  ..action = "VIEW_WEBSITE"
  ..payload = "http://www.google.com";

  TimelineItem timeLineItem = new TimelineItem.fromJson({})
  ..menuItems = [menuItem]
  ..html = timeLinehtml
  ..notification = notification;

  mirror.timeline.insert(timeLineItem)
  .then((TimelineItem updatedItem) =>
      html.query("#output").text = updatedItem.toString(),
      onError: (error) => html.query("#output").text = error);
}

void main() {
  auth = new GoogleOAuth2(CLIENT_ID, SCOPES);

  html.query("#sign-in").onClick.listen((e) {
    print("Attempting to log you in.");
    auth.login().then(insertCard,
        onError: (error) => print("login error: $error"));
  });

  html.query("#sign-out").onClick.listen((e) {
    auth.logout();
    print("Signing you out.");
  });
}

import 'dart:html';
import "package:google_oauth2_client/google_oauth2_browser.dart";
import "package:google_mirror_v1_api/mirror_v1_api_browser.dart";
import "package:google_mirror_v1_api/mirror_v1_api_client.dart";

String CLIENT_ID = '881188623772.apps.googleusercontent.com';
List<String> SCOPES = [
'https://www.googleapis.com/auth/userinfo.profile',
'https://www.googleapis.com/auth/glass.timeline'
];
String API_KEY = 'AIzaSyBfA-Zqg9hVWVBJHLXj0ycQTyB3J0IYyN0';

GoogleOAuth2 auth;

insertCard(Token token) {
//  print("token = $token");
  Mirror mirror = new Mirror(auth);
  mirror.makeAuthRequests = true;

//  Map attributes = {
//    "html": "<article class=\"photo cover-only\">\n  <img src=\"http://www.glassfrogger.com/images/game-field.jpg\" height=\"100%\" width=\"100%\">\n  <div class=\"photo-overlay\"></div>\n  <section>\n    <p class=\"text-auto-size\"><strong class=\"white\">Google Glass</strong> <em class=\"blue\">Dartified!</em></p>\n  </section>\n<footer>\n    <img src=\"data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABUAAAAVCAMAAACeyVWkAAAAGXRFWHRTb2Z0d2FyZQBBZG9iZSBJbWFnZVJlYWR5ccllPAAAAJxQTFRFAAAAAIvMdsvDAIvMdsvDAIvMdsvDLaTJAIvMOqnHdsvDAIvMdsvDAIvMKaLJdsvDAIvMAIvMdsvDAIvMdsvDdsvDAIvMAIvMAZnFdsvDAILHAIPHAITIAIXJAIfKAIjKAIrLAIrMAIvMAJXHAJjFC5i/I6HENr2yOb6zPr+0TsK4UsO5WbnEWcW8Xsa9Yse+Zsi/asjAc8rCdsvDdt4SRQAAABp0Uk5TABAQICAwMFBgYGBwcICAgI+vr7+/z9/v7+97IXGnAAAAqUlEQVQYV13QxxaCQBBE0VZkjBgAGVEBaVEUM/P//yaTGg5vV3dZANTCZ9BvFAoR93kVC9FnthW6uIPTJ7UkdHaXvS2LXKNBURInyDXPsShbzjU7XCpxhooDVGo5QcQAJmjUco64AY/UcIrowYCTaj5KBZeTaj5JBTc6l11OlQKMf497y1ahefFb3TQfcqtM/fipJF/X9gnDon6/ah/aDDfNOgosNA2b8QdGciZlh/U93AAAAABJRU5ErkJggg==\" class=\"left\">\n    <p>Dart Hacking</p>\n  </footer>\n </article>\n<article class=\"auto-paginate\">\n  <ol class=\"text-x-small\">\n  <strong>Instructions:</strong><hr>  <li>First item</li>\n    <li>Second item</li>\n    <li>Third item</li>\n    <li>Fourth item</li>\n  </ol>\n</article>\n",
//    "menuItems": [
//    {
//      "action": "VIEW_WEBSITE",
//      "payload": "http://www.google.com"
//    }
//    ],
//    "notification": {
//      "level": "DEFAULT"
//    }
//  };

  // TODO: replace this with stuff from html5lib or dart:html.
  // using html5lib can be reused from the console.
  String html = "<article class=\"photo cover-only\">\n  <img src=\"http://www.glassfrogger.com/images/game-field.jpg\" height=\"100%\" width=\"100%\">\n  <div class=\"photo-overlay\"></div>\n  <section>\n    <p class=\"text-auto-size\"><strong class=\"white\">Google Glass</strong> <em class=\"blue\">Dartified!</em></p>\n  </section>\n<footer>\n    <img src=\"data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABUAAAAVCAMAAACeyVWkAAAAGXRFWHRTb2Z0d2FyZQBBZG9iZSBJbWFnZVJlYWR5ccllPAAAAJxQTFRFAAAAAIvMdsvDAIvMdsvDAIvMdsvDLaTJAIvMOqnHdsvDAIvMdsvDAIvMKaLJdsvDAIvMAIvMdsvDAIvMdsvDdsvDAIvMAIvMAZnFdsvDAILHAIPHAITIAIXJAIfKAIjKAIrLAIrMAIvMAJXHAJjFC5i/I6HENr2yOb6zPr+0TsK4UsO5WbnEWcW8Xsa9Yse+Zsi/asjAc8rCdsvDdt4SRQAAABp0Uk5TABAQICAwMFBgYGBwcICAgI+vr7+/z9/v7+97IXGnAAAAqUlEQVQYV13QxxaCQBBE0VZkjBgAGVEBaVEUM/P//yaTGg5vV3dZANTCZ9BvFAoR93kVC9FnthW6uIPTJ7UkdHaXvS2LXKNBURInyDXPsShbzjU7XCpxhooDVGo5QcQAJmjUco64AY/UcIrowYCTaj5KBZeTaj5JBTc6l11OlQKMf497y1ahefFb3TQfcqtM/fipJF/X9gnDon6/ah/aDDfNOgosNA2b8QdGciZlh/U93AAAAABJRU5ErkJggg==\" class=\"left\">\n    <p>Dart Hacking</p>\n  </footer>\n </article>\n<article class=\"auto-paginate\">\n  <ol class=\"text-x-small\">\n  <strong>Instructions:</strong><hr>  <li>First item</li>\n    <li>Second item</li>\n    <li>Third item</li>\n    <li>Fourth item</li>\n  </ol>\n</article>\n";
  NotificationConfig notification = new NotificationConfig.fromJson({});
  notification.level = "DEFAULT";
  MenuItem menuItem = new MenuItem.fromJson({});
  menuItem.action = "VIEW_WEBSITE";
  menuItem.payload = "http://www.google.com";

  TimelineItem timeLineItem = new TimelineItem.fromJson({});
  timeLineItem.menuItems = [menuItem];
  timeLineItem.html = html;
  timeLineItem.notification = notification;
  mirror.timeline.insert(timeLineItem)
  .then((TimelineItem updatedItem) =>
      print("updatedItem = ${updatedItem.toString()}"),
      onError: (error) => print("error = $error"));
}

void main() {
  auth = new GoogleOAuth2(CLIENT_ID, SCOPES);

  query("#sign-in").onClick.listen((e) {
    print("Attempting to log you in.");
    auth.login(immediate: true).then(insertCard,
        onError: (error) => print("login error: $error"));
  });

  query("#sign-out").onClick.listen((e) {
    auth.logout();
    print("Signing you out.");
  });

//  query("#send-card").onClick.listen((e) {
//    print("sending card");
//    insertCard(null);
//  });
}
import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;

class Model {
  String key = "Token r8_0gu0cDgR6DvoeJAZTwveiMbicwCjFDY0yoClf";
  String version =
      "5ca3a91f7908f4e84f7f5ae675a014f584309dc4966d0eb03520c3bf1e1bc60f";
  final api_POST_URL = "https://api.replicate.com/v1/predictions";
  late String id;
  late String api_GET_URL;
  late Map<String, dynamic> responseBody;
  String output_URL = "";
  Model();

  //creates post request to start prediction
  Future<void> http_post_request(image1, image2, image3) async {
    Uri url = Uri.parse(api_POST_URL);
    final response = await http.post(url,
        headers: {"Authorization": key, 'Content-Type': 'application/json'},
        body: jsonEncode({
          "version": version,
          "input": {
            'source_image': image1,
            'target_image': image2,
            'color_image': image3,
          },
        }));
    if (response.statusCode == 201) {
      print("201: Successful");
      print(json.decode(response.body));
      print(json.decode(response.body)['id']);
      responseBody = json.decode(response.body);
      id = json.decode(response.body)['id'];
      api_GET_URL = "https://api.replicate.com/v1/predictions/" + id;
      print(api_GET_URL);
    } else {
      print(json.decode(response.body));
    }
  }

  //Test model for debugging
  Future<void> http_post_request2() async {
    Uri url = Uri.parse(api_POST_URL);
    final response = await http.post(url,
        headers: {"Authorization": key, 'Content-Type': 'application/json'},
        body: jsonEncode({
          "version":
              'd938add77615da25dd74c9bcbc5b8ee11c9c3476eb721a6991d32fe5c2ec1968',
          "input": {
            "debug": false,
            "top_k": 50,
            "top_p": 0.9,
            "prompt": "how are you doing today? ",
            "temperature": 0.7,
            "max_new_tokens": 150,
            "min_new_tokens": -1
          },
        }));
    if (response.statusCode == 201) {
      print("201: Successful");
      print(json.decode(response.body));
      print(json.decode(response.body)['id']);
      responseBody = json.decode(response.body);
      id = json.decode(response.body)['id'];
      api_GET_URL = "https://api.replicate.com/v1/predictions/" + id;
      print(api_GET_URL);
    } else {
      print("somethings wrong");
      print(json.decode(response.body));
    }
  }

  //gets current status
  Future<String> get_current_status() async {
    Uri url = Uri.parse(api_GET_URL);
    final response = await http.get(url, headers: {
      "Authorization": key,
    });
    print(json.decode(response.body)["status"]);
    return json.decode(response.body)["status"];
  }

  //calls get current status until prediction is finished
  Future<void> current_status() async {
    String status;

    while (true) {
      status = await get_current_status();
      await Future.delayed(Duration(seconds: 5));
      if (status == "succeeded") {
        print("succeeded");
        break;
      }
      if (status == "canceled") {
        print("canceled");
        break;
      }
      if (status == "failed") {
        print("failed");
        break;
      }
    }
    print("Finished getting status");
  }

  //Cancels prediction
  Future<void> cancel_prediction() async {
    Uri url = Uri.parse(api_GET_URL + "/cancel");
    final response = await http.post(url, headers: {
      "Authorization": key,
    });
    print(json.decode(response.body));
  }

  Future<void> result() async {
    // gets output URL
    print("Result");
    Uri url = Uri.parse(api_GET_URL);
    final response = await http.get(url, headers: {
      "Authorization": key,
    });
    if (json.decode(response.body)["output"] != null) {
      output_URL = json.decode(response.body)["output"];
    }
  }
}

using System;
using System.Net;
using System.IO;
using System.Text;
using System.Web;
using System.Json;
using System.Collections.Generic;
using System.Runtime.Serialization;
using System.Runtime.Serialization.Json;
using Newtonsoft.Json;
using Android.Locations;
using Android.Gms.Maps;
using Android.Gms.Maps.Model;

namespace NavDrawer
{
	public class NetworkCalls
	{
		public NetworkCalls ()
		{
			
		}

		public static bool Login(string email, string password, string token){

			bool success = false;

			try{
			// Create a request using a URL that can receive a post. 
			//WebRequest request = WebRequest.Create ("https://api.moderndemocracy.com/api/v1.0/token");
			//WebRequest request = WebRequest.Create ("http://api.eyespyfx.co.uk/api/v1.0/token");
			WebRequest request = WebRequest.Create (DataController.url + "/api/v1.0/token");
			//Console.WriteLine(DataController.url+"-----------------------------");
			// Set the Method property of the request to POST.
			request.Method = "POST";
			request.Headers.Add ("Authorization", token);

			// Create POST data and convert it to a byte array.
			Dictionary<string, object> postData = new Dictionary<string, object> ();
			Dictionary<string, object> jsonDict = new Dictionary<string, object> ();
			postData.Add ("email", email);
			postData.Add ("password", password);

			string jsonData = JsonConvert.SerializeObject(postData, Formatting.Indented);

			//Console.WriteLine ("jsonData login= " + jsonData);

			byte[] byteArray = Encoding.UTF8.GetBytes (jsonData);

			//Console.WriteLine(postData);
			// Set the ContentType property of the WebRequest.
			request.ContentType = "application/json";
			// Set the ContentLength property of the WebRequest.
			request.ContentLength = byteArray.Length;
			// Get the request stream.
			Stream dataStream = request.GetRequestStream ();
			// Write the data to the request stream.
			dataStream.Write (byteArray, 0, byteArray.Length);
			// Close the Stream object.
			dataStream.Close ();
			// Get the response.
			WebResponse response = request.GetResponse ();
			// Display the status.
			//Console.WriteLine (((HttpWebResponse)response).StatusDescription);
			// Get the stream containing content returned by the server. 
			dataStream = response.GetResponseStream ();
			// Open the stream using a StreamReader for easy access.
			StreamReader reader = new StreamReader (dataStream);
			// Read the content.
			string responseFromServer = reader.ReadToEnd ();

			//Console.WriteLine ("Server Response Login = " + responseFromServer + "end");

			// Clean up the streams.
			reader.Close ();
			dataStream.Close ();
			response.Close ();

			jsonDict = JsonConvert.DeserializeObject<Dictionary<string, object>>(responseFromServer);
			//Console.WriteLine("jsonDict " + jsonDict);

			if (jsonDict.ContainsKey ("message")) {
				if (jsonDict ["message"].ToString () == "Account not found." || jsonDict ["message"].ToString () == "Invalid email.") {
					success = false;
				}
			} 
			else {
				success = true;
				DataController.token = jsonDict ["token"].ToString ();
				DataController.role = jsonDict ["role"].ToString ();
				DataController.userID = jsonDict ["id"].ToString ();
				DataController.managerID = jsonDict ["managerID"].ToString ();
				DataController.fileType = jsonDict["type"].ToString();
			}

			//Console.WriteLine ("Success " + success);

			}catch (Exception e){

			}

			return success;
		}

		public static string getJobs(string token){

			try {
			// Create a request using a URL that can receive a post. 
//			WebRequest request = WebRequest.Create ("http://api.eyespyfx.co.uk/api/v1.0/residences/33/WBN");
			//WebRequest request = WebRequest.Create ("https://api.moderndemocracy.com/api/v1.0/jobs/" + DataController.managerID + "/" + DataController.userID);
			//WebRequest request = WebRequest.Create ("http://api.eyespyfx.co.uk/api/v1.0/jobs/" + DataController.managerID + "/" + DataController.userID);
			WebRequest request = WebRequest.Create (DataController.url + "/api/v1.0/jobs/" + DataController.managerID + "/" + DataController.userID);
			// Set the Method property of the request to POST.
			request.Method = "GET";
			request.Headers.Add ("Authorization", token);

			// Create POST data and convert it to a byte array.
			//Dictionary<string, object> postData = new Dictionary<string, object> ();
			Dictionary<string, object> jsonDict = new Dictionary<string, object> ();
			Dictionary<string, object> dataDict = new Dictionary<string, object> ();

			//string jsonData = JsonConvert.SerializeObject(postData, Formatting.Indented);

			//Console.WriteLine ("jsonData= " + jsonData);

			//byte[] byteArray = Encoding.UTF8.GetBytes (jsonData);

			//Console.WriteLine(postData);
			// Set the ContentType property of the WebRequest.
			request.ContentType = "application/json";
			// Set the ContentLength property of the WebRequest.
			//request.ContentLength = byteArray.Length;
			// Get the request stream.
			//Stream dataStream = request.GetRequestStream ();
			// Write the data to the request stream.
			//dataStream.Write (byteArray, 0, byteArray.Length);
			// Close the Stream object.
			//dataStream.Close ();
			// Get the response.
			WebResponse response = request.GetResponse ();
			// Display the status.
			//Console.WriteLine (((HttpWebResponse)response).StatusDescription);
			// Get the stream containing content returned by the server. 
			Stream dataStream = response.GetResponseStream ();
			// Open the stream using a StreamReader for easy access.
			StreamReader reader = new StreamReader (dataStream);
			// Read the content.
			string responseFromServer = reader.ReadToEnd ();

			//Console.WriteLine ("Server Response Jobs= " + responseFromServer + "end");

			// Clean up the streams.
			reader.Close ();
			dataStream.Close ();
			response.Close ();

			var json = JsonValue.Parse(responseFromServer);


			//jsonDict = JsonConvert.DeserializeObject<Dictionary<string, object>>(responseFromServer);
			//Console.WriteLine("jsonDict " + jsonDict);
//			List<object> addresses = new List<object>();
//
//			var json = JsonValue.Parse(responseFromServer);
//			var data = json["data"];
//
			foreach (var dataItem in json)
			{
////				//addresses.Add((string)dataItem["fulladdress"]);
////				//string value = (string)dataItem ["fulladdress"];
				dataDict = JsonConvert.DeserializeObject<Dictionary<string, object>>(dataItem.ToString());
////				addresses.Add (dataDict ["fullAddress"]);
////				//Console.WriteLine(dataItem);
			}
			if (dataDict.ContainsKey("canvassID")) {
				string canvassID = dataDict ["canvassID"].ToString ();
				DataController.canvassID = canvassID;
			}
			return responseFromServer;

			} catch(Exception e){
				
			}

			return null;
		}

		public static string SendLocation(string userID, string longitude, string latitude, string accuracy, string type, string timeStamp, string token){

			try {
			// Create a request using a URL that can receive a post. 
			//WebRequest request = WebRequest.Create ("https://api.moderndemocracy.com/api/v1.0/location");
			//WebRequest request = WebRequest.Create ("http://api.eyespyfx.co.uk/api/v1.0/location");
			WebRequest request = WebRequest.Create (DataController.url + "/api/v1.0/location");
			// Set the Method property of the request to POST.
			request.Method = "POST";
			request.Headers.Add ("Authorization", token);

			// Create POST data and convert it to a byte array.
			Dictionary<string, object> postData = new Dictionary<string, object> ();
			Dictionary<string, object> jsonDict = new Dictionary<string, object> ();
			postData.Add ("UserID", userID);
			postData.Add ("longitude", longitude);
			postData.Add ("latitude", latitude);
			postData.Add ("accuracy", accuracy);
			postData.Add ("type", type);
			postData.Add ("stamp", timeStamp);

			string jsonData = JsonConvert.SerializeObject(postData, Formatting.Indented);

			//Console.WriteLine ("jsonData Location= " + jsonData);

			byte[] byteArray = Encoding.UTF8.GetBytes (jsonData);

			//Console.WriteLine(postData);
			// Set the ContentType property of the WebRequest.
			request.ContentType = "application/json";
			// Set the ContentLength property of the WebRequest.
			request.ContentLength = byteArray.Length;
			// Get the request stream.
			Stream dataStream = request.GetRequestStream ();
			// Write the data to the request stream.
			dataStream.Write (byteArray, 0, byteArray.Length);
			// Close the Stream object.
			dataStream.Close ();
			// Get the response.
			WebResponse response = request.GetResponse ();
			// Display the status.
			//Console.WriteLine (((HttpWebResponse)response).StatusDescription);
			// Get the stream containing content returned by the server. 
			dataStream = response.GetResponseStream ();
			// Open the stream using a StreamReader for easy access.
			StreamReader reader = new StreamReader (dataStream);
			// Read the content.
			string responseFromServer = reader.ReadToEnd ();

			//Console.WriteLine ("Server Response Location= " + responseFromServer + "end");

			// Clean up the streams.
			reader.Close ();
			dataStream.Close ();
			response.Close ();

			return responseFromServer;

			} catch(Exception e) {
				
			}

			return null;
		}

		public static string getProperties(string token){

			try {
			// Create a request using a URL that can receive a post. 
			//			WebRequest request = WebRequest.Create ("http://api.eyespyfx.co.uk/api/v1.0/residences/33/WBN");
			//WebRequest request = WebRequest.Create ("https://api.moderndemocracy.com/api/v2.0/user/residences/" + DataController.canvassID + "/" + DataController.userID);
			//WebRequest request = WebRequest.Create ("http://api.eyespyfx.co.uk/api/v2.0/user/residences/" + DataController.canvassID + "/" + DataController.userID);
			WebRequest request = WebRequest.Create (DataController.url + "/api/v2.0/user/residences/" + DataController.canvassID + "/" + DataController.userID);
			// Set the Method property of the request to POST.
			request.Method = "GET";
			request.Headers.Add ("Authorization", token);
				//Console.WriteLine(token);

			// Create POST data and convert it to a byte array.
			//Dictionary<string, object> postData = new Dictionary<string, object> ();
			Dictionary<string, object> jsonDict = new Dictionary<string, object> ();
			Dictionary<string, object> dataDict = new Dictionary<string, object> ();

			//string jsonData = JsonConvert.SerializeObject(postData, Formatting.Indented);

			//Console.WriteLine ("jsonData= " + jsonData);

			//byte[] byteArray = Encoding.UTF8.GetBytes (jsonData);

			//Console.WriteLine(postData);
			// Set the ContentType property of the WebRequest.
			request.ContentType = "application/json";
			// Set the ContentLength property of the WebRequest.
			//request.ContentLength = byteArray.Length;
			// Get the request stream.
			//Stream dataStream = request.GetRequestStream ();
			// Write the data to the request stream.
			//dataStream.Write (byteArray, 0, byteArray.Length);
			// Close the Stream object.
			//dataStream.Close ();
			// Get the response.
			WebResponse response = request.GetResponse ();
			// Display the status.
			//Console.WriteLine (((HttpWebResponse)response).StatusDescription);
			// Get the stream containing content returned by the server. 
			Stream dataStream = response.GetResponseStream ();
			// Open the stream using a StreamReader for easy access.
			StreamReader reader = new StreamReader (dataStream);
			// Read the content.
			string responseFromServer = reader.ReadToEnd ();
			//Console.WriteLine ("Server Response properties= " + responseFromServer + "end");
			

			// Clean up the streams.
			reader.Close ();
			dataStream.Close ();
			response.Close ();

			var json = JsonValue.Parse (responseFromServer);
			var data = json ["data"];
//			jsonDict = JsonConvert.DeserializeObject<Dictionary<string, object>>(responseFromServer);
			//dataDict = (Dictionary<string, object>)json ["data"];
			//Console.WriteLine("jsonDict " + jsonDict);
			List<Dictionary<string, object>> addresses = new List<Dictionary<string, object>>();
			//List<Dictionary<string, object>> coords = new List<Dictionary<string, object>>();
			List<LatLng> coords = new List<LatLng>();
			//
			//			var json = JsonValue.Parse(responseFromServer);
			//			var data = json["data"];
			//
						foreach (var dataItem in data)
						{
			//				//addresses.Add((string)dataItem["fulladdress"]);
			//				//string value = (string)dataItem ["fulladdress"];



							dataDict = JsonConvert.DeserializeObject<Dictionary<string, object>>(dataItem.ToString());
							//string uprn = dataDict ["uprn"].ToString();
							if (dataDict.ContainsKey ("locationGPS")) {
							if (dataDict ["locationGPS"] != null) {
								string temp = dataDict ["locationGPS"].ToString ();
								if (temp != "") {
								jsonDict = JsonConvert.DeserializeObject<Dictionary<string, object>> (dataDict ["locationGPS"].ToString ());
								string lat = jsonDict ["lat"].ToString ();
								string lng = jsonDict ["lng"].ToString ();

								//Console.WriteLine("lat:" + lat + "::lng:" + lng);

									coords.Add (new LatLng (Convert.ToDouble (lat), Convert.ToDouble (lng)));
								DataController.coords = coords;
							}
						}
					}
							//Console.WriteLine ("UPRN " + uprn);
							addresses.Add (dataDict);
							//coords.Add (dataDict ["locationGPS"].ToString);
							//Console.WriteLine(dataItem);
						}

			DataController.addresses = addresses;

			//string temp = dataDict ["locationGPS"].ToString ();
//			jsonDict = JsonConvert.DeserializeObject<Dictionary<string, object>>(dataDict ["locationGPS"].ToString ());
//			string lat = jsonDict ["lat"].ToString();
//			string lng = jsonDict ["lng"].ToString ();


			return responseFromServer;

			} 
			catch(Exception e) 
			{
				Console.WriteLine ( e.ToString ());
			}

			return null;
		}

		public static string SendStatus(string token, string status, string uprn, string canvassID){

			try {
			// Create a request using a URL that can receive a post. 
			//WebRequest request = WebRequest.Create ("http://api.eyespyfx.co.uk/api/v1.0/residences/33/WBN");
			//WebRequest request = WebRequest.Create ("https://api.moderndemocracy.com/api/v2.0/residence/status/" + DataController.canvassID  + "/" + uprn + "/" + status);
			//WebRequest request = WebRequest.Create ("http://api.eyespyfx.co.uk/api/v2.0/residence/status/" + DataController.canvassID  + "/" + uprn + "/" + status);
				WebRequest request = WebRequest.Create (DataController.url + "/api/v2.0/residence/status/" + DataController.canvassID  + "/" + HttpUtility.UrlEncode(uprn) + "/" + status);
			// Set the Method property of the request to POST.
			request.Method = "GET";
			request.Headers.Add ("Authorization", token);
				//Console.WriteLine(HttpUtility.UrlEncode(uprn) +"HELLOO"+status);

			// Create POST data and convert it to a byte array.
			//Dictionary<string, object> postData = new Dictionary<string, object> ();
			//Dictionary<string, object> jsonDict = new Dictionary<string, object> ();
			//Dictionary<string, object> dataDict = new Dictionary<string, object> ();

			// Set the ContentType property of the WebRequest.
			request.ContentType = "application/json";
			// Get the response.
			WebResponse response = request.GetResponse ();
			// Display the status.
			//Console.WriteLine (((HttpWebResponse)response).StatusDescription);
			// Get the stream containing content returned by the server. 
			Stream dataStream = response.GetResponseStream ();
			// Open the stream using a StreamReader for easy access.
			StreamReader reader = new StreamReader (dataStream);
			// Read the content.
			string responseFromServer = reader.ReadToEnd ();


			//Console.WriteLine ("Server Response sendStatus= " + responseFromServer + "end");

			// Clean up the streams.
			reader.Close ();
			dataStream.Close ();
			response.Close ();

			return responseFromServer;

			} catch (Exception e){
				
			}

			return null;
		}

		public static string getResidents(string token, string canvassID, string uprn){

			try {
			// Create a request using a URL that can receive a post. 
			//			WebRequest request = WebRequest.Create ("http://api.eyespyfx.co.uk/api/v1.0/residences/33/WBN");
			//WebRequest request = WebRequest.Create ("https://api.moderndemocracy.com/api/v2.0/residents/" + DataController.canvassID + "/" + uprn);
			//WebRequest request = WebRequest.Create ("http://api.eyespyfx.co.uk/api/v2.0/residents/" + DataController.canvassID + "/" + uprn);
				WebRequest request = WebRequest.Create (DataController.url + "/api/v2.0/residents/" + DataController.canvassID + "/" + HttpUtility.UrlEncode(uprn));
			// Set the Method property of the request to POST.
			request.Method = "GET";
			request.Headers.Add ("Authorization", token);


			// Create POST data and convert it to a byte array.
			//Dictionary<string, object> postData = new Dictionary<string, object> ();
			Dictionary<string, object> jsonDict = new Dictionary<string, object> ();
			Dictionary<string, object> dataDict = new Dictionary<string, object> ();

			//string jsonData = JsonConvert.SerializeObject(postData, Formatting.Indented);

			//Console.WriteLine ("jsonData= " + jsonData);

			//byte[] byteArray = Encoding.UTF8.GetBytes (jsonData);

			//Console.WriteLine(postData);
			// Set the ContentType property of the WebRequest.
			request.ContentType = "application/json";
			// Set the ContentLength property of the WebRequest.
			//request.ContentLength = byteArray.Length;
			// Get the request stream.
			//Stream dataStream = request.GetRequestStream ();
			// Write the data to the request stream.
			//dataStream.Write (byteArray, 0, byteArray.Length);
			// Close the Stream object.
			//dataStream.Close ();
			// Get the response.
			WebResponse response = request.GetResponse ();
			// Display the status.
			//Console.WriteLine (((HttpWebResponse)response).StatusDescription);
			// Get the stream containing content returned by the server. 
			Stream dataStream = response.GetResponseStream ();
			// Open the stream using a StreamReader for easy access.
			StreamReader reader = new StreamReader (dataStream);
			// Read the content.
			string responseFromServer = reader.ReadToEnd ();

			

			// Clean up the streams.
			reader.Close ();
			dataStream.Close ();
			response.Close ();


			//jsonDict = JsonConvert.DeserializeObject<Dictionary<string, object>>(responseFromServer);
			//Console.WriteLine("jsonDict " + jsonDict);
			List<Dictionary<string, object>> residents = new List<Dictionary<string, object>>();
			//
						var json = JsonValue.Parse(responseFromServer);
						var data = json["data"];
			//
						foreach (var dataItem in data)
						{
			//				//addresses.Add((string)dataItem["fulladdress"]);
			//				//string value = (string)dataItem ["fulladdress"];
							dataDict = JsonConvert.DeserializeObject<Dictionary<string, object>>(dataItem.ToString());




							residents.Add (dataDict);
			//				//Console.WriteLine(dataItem);
						}

			DataController.residents = residents;

			return responseFromServer;

			} catch(Exception e){
				
			}

			return null;
		}

		public static string updateResidents(string nationality, string optOut, string jury, string absent, string residentID, string token, string uprn){

			try {
				//Console.WriteLine("residentID of networkController"+residentID);
			// Create a request using a URL that can receive a post. 
			//WebRequest request = WebRequest.Create ("https://api.moderndemocracy.com/api/v2.0/resident/" + DataController.canvassID + "/" + residentID);
			//WebRequest request = WebRequest.Create ("http://api.eyespyfx.co.uk/api/v2.0/resident/" + DataController.canvassID + "/" + residentID);
			WebRequest request = WebRequest.Create (DataController.url + "/api/v2.0/resident/" + DataController.canvassID + "/" + residentID);
			// Set the Method property of the request to POST.
			request.Method = "PUT";
			request.Headers.Add ("Authorization", token);

			// Create POST data and convert it to a byte array.
			Dictionary<string, object> postData = new Dictionary<string, object> ();
			Dictionary<string, object> jsonDict = new Dictionary<string, object> ();
			postData.Add ("nationality", nationality);
			postData.Add ("optOut", optOut);
			postData.Add ("absent", absent);
			postData.Add ("jury", jury);
			postData.Add ("uprn", HttpUtility.UrlEncode(uprn));

			string jsonData = JsonConvert.SerializeObject(postData, Formatting.Indented);

			

			byte[] byteArray = Encoding.UTF8.GetBytes (jsonData);

			//Console.WriteLine(postData);
			// Set the ContentType property of the WebRequest.
			request.ContentType = "application/json";
			// Set the ContentLength property of the WebRequest.
			request.ContentLength = byteArray.Length;
			// Get the request stream.
			Stream dataStream = request.GetRequestStream ();
			// Write the data to the request stream.
			dataStream.Write (byteArray, 0, byteArray.Length);
			// Close the Stream object.
			dataStream.Close ();
			// Get the response.
			WebResponse response = request.GetResponse ();
			// Display the status.
			//Console.WriteLine (((HttpWebResponse)response).StatusDescription);
			// Get the stream containing content returned by the server. 
			dataStream = response.GetResponseStream ();
			// Open the stream using a StreamReader for easy access.
			StreamReader reader = new StreamReader (dataStream);
			// Read the content.
			string responseFromServer = reader.ReadToEnd ();

			

			// Clean up the streams.
			reader.Close ();
			dataStream.Close ();
			response.Close ();

			return responseFromServer;

			} catch(Exception e){
				
			}

			return null;
		}

		public static string updateResidentsNew(string responder, string encourage, string onlineReg, string residentID, string token, string uprn){

			try {
				//Console.WriteLine("updateResidentsNew");
				// Create a request using a URL that can receive a post. 
				//WebRequest request = WebRequest.Create ("https://api.moderndemocracy.com/api/v2.0/resident/" + DataController.canvassID + "/" + residentID);
				//WebRequest request = WebRequest.Create ("http://api.eyespyfx.co.uk/api/v2.0/resident/" + DataController.canvassID + "/" + residentID);
				WebRequest request = WebRequest.Create (DataController.url + "/api/v2.0/resident/" + DataController.canvassID + "/" + residentID);
				// Set the Method property of the request to POST.
				request.Method = "PUT";
				request.Headers.Add ("Authorization", token);

				// Create POST data and convert it to a byte array.
				Dictionary<string, object> postData = new Dictionary<string, object> ();
				Dictionary<string, object> jsonDict = new Dictionary<string, object> ();
				postData.Add ("req_itr","1" );
				postData.Add ("responder", responder);
				postData.Add ("encourage", encourage);
				postData.Add ("onlineReg", onlineReg);
				postData.Add ("uprn", HttpUtility.UrlEncode(uprn));

				string jsonData = JsonConvert.SerializeObject(postData, Formatting.Indented);



				byte[] byteArray = Encoding.UTF8.GetBytes (jsonData);

				//Console.WriteLine(postData);
				// Set the ContentType property of the WebRequest.
				request.ContentType = "application/json";
				// Set the ContentLength property of the WebRequest.
				request.ContentLength = byteArray.Length;
				// Get the request stream.
				Stream dataStream = request.GetRequestStream ();
				// Write the data to the request stream.
				dataStream.Write (byteArray, 0, byteArray.Length);
				// Close the Stream object.
				dataStream.Close ();
				// Get the response.
				WebResponse response = request.GetResponse ();
				// Display the status.
				//Console.WriteLine (((HttpWebResponse)response).StatusDescription);
				// Get the stream containing content returned by the server. 
				dataStream = response.GetResponseStream ();
				// Open the stream using a StreamReader for easy access.
				StreamReader reader = new StreamReader (dataStream);
				// Read the content.
				string responseFromServer = reader.ReadToEnd ();



				// Clean up the streams.
				reader.Close ();
				dataStream.Close ();
				response.Close ();

				return responseFromServer;

			} catch(Exception e){

			}

			return null;
		}
		public static string updateResidentsFlag(string firstnameNew,string surnameNew, string fullnameNew, string flag,string residentID, string token, string uprn){

			//Console.WriteLine("updateResidentsFlag : "  + firstnameNew + ":" + surnameNew + ":" + fullnameNew + ":" + flag + ":" + residentID + ":" + token + ":"  + uprn);
			//updateResidentsFlag : mick:McArthur:mick McArthur:ER_NC:1359:dxwp3Sa6iI1JyGElStrbKieFuEE=:9059038195

			try {
				// Create a request using a URL that can receive a post. 
				//WebRequest request = WebRequest.Create ("https://api.moderndemocracy.com/api/v2.0/resident/" + DataController.canvassID + "/" + residentID);
				//WebRequest request = WebRequest.Create ("http://api.eyespyfx.co.uk/api/v2.0/resident/" + DataController.canvassID + "/" + residentID);
				WebRequest request = WebRequest.Create (DataController.url + "/api/v2.0/resident/" + DataController.canvassID + "/" + residentID);
				// Set the Method property of the request to POST.
				request.Method = "PUT";
				request.Headers.Add ("Authorization", token);

				// Create POST data and convert it to a byte array.
				Dictionary<string, object> postData = new Dictionary<string, object> ();
				Dictionary<string, object> jsonDict = new Dictionary<string, object> ();
				//postData.Add ("nationality", nationality);
				postData.Add ("req_itr","1" );
				postData.Add ("itr_firstNames",firstnameNew );
				postData.Add ("itr_surname",surnameNew );
				postData.Add ("itr_fullName",fullnameNew );
				postData.Add ("itr_status", flag);
				//postData.Add ("surname", surnameEdit);
				//postData.Add ("fullName", fullName);
				postData.Add ("uprn", HttpUtility.UrlEncode(uprn));

				string jsonData = JsonConvert.SerializeObject(postData, Formatting.Indented);

				//Console.WriteLine ("jsonData updateResidentFlag= " + jsonData);

				byte[] byteArray = Encoding.UTF8.GetBytes (jsonData);

				//Console.WriteLine(postData);
				// Set the ContentType property of the WebRequest.
				request.ContentType = "application/json";
				// Set the ContentLength property of the WebRequest.
				request.ContentLength = byteArray.Length;
				// Get the request stream.
				Stream dataStream = request.GetRequestStream ();
				// Write the data to the request stream.
				dataStream.Write (byteArray, 0, byteArray.Length);
				// Close the Stream object.
				dataStream.Close ();
				// Get the response.
				WebResponse response = request.GetResponse ();
				// Display the status.
				///Console.WriteLine ("HttpWebResponse ::::::::::::" + ((HttpWebResponse)response).StatusDescription);
				// Get the stream containing content returned by the server. 
				dataStream = response.GetResponseStream ();
				// Open the stream using a StreamReader for easy access.
				StreamReader reader = new StreamReader (dataStream);
				// Read the content.
				string responseFromServer = reader.ReadToEnd ();

				//Console.WriteLine ("Server Response updateResidentFlag= " + responseFromServer + "end");

				// Clean up the streams.
				reader.Close ();
				dataStream.Close ();
				response.Close ();

				return responseFromServer;

			} catch(Exception e){

			}

			return null;
		}

		/*public static string deleteResidents(int residentId,string canvassID, string token, string uprn)
		{
			try {
				// Create a request using a URL that can receive a post. 
				//WebRequest request = WebRequest.Create ("https://api.moderndemocracy.com/api/v2.0/resident/new/" + canvassID);
				//WebRequest request = WebRequest.Create ("http://api.eyespyfx.co.uk/api/v2.0/resident/new/" + canvassID);
				WebRequest request = WebRequest.Create (DataController.url + "/api/v2.0/resident/" + canvassID +residentId );
				// Set the Method property of the request to POST.
				request.Method = "DELETE";
				request.Headers.Add ("Authorization", token);

				// Create POST data and convert it to a byte array.
				/*Dictionary<string, object> postData = new Dictionary<string, object> ();
				Dictionary<string, object> jsonDict = new Dictionary<string, object> ();
				postData.Add ("uprn", HttpUtility.UrlEncode(uprn));
				postData.Add ("houseID", houseID);
				postData.Add ("fullName", fullName);
				postData.Add ("firstNames", "");
				postData.Add ("surname", "");
				postData.Add ("title", "");
				postData.Add ("status", status);

				string jsonData = JsonConvert.SerializeObject(postData, Formatting.Indented);

				//Console.WriteLine ("jsonData delete= " + jsonData);

				byte[] byteArray = Encoding.UTF8.GetBytes (jsonData);

				Console.WriteLine(postData);
				// Set the ContentType property of the WebRequest.
				request.ContentType = "application/json";
				// Set the ContentLength property of the WebRequest.
				request.ContentLength = byteArray.Length;
				// Get the request stream.
				Stream dataStream = request.GetRequestStream ();
				// Write the data to the request stream.
				dataStream.Write (byteArray, 0, byteArray.Length);
				// Close the Stream object.
				dataStream.Close ();
				// Get the response.
				WebResponse response = request.GetResponse ();
				// Display the status.
				Console.WriteLine (((HttpWebResponse)response).StatusDescription);
				// Get the stream containing content returned by the server. 
				dataStream = response.GetResponseStream ();
				// Open the stream using a StreamReader for easy access.
				StreamReader reader = new StreamReader (dataStream);
				// Read the content.
				string responseFromServer = reader.ReadToEnd ();

				Console.WriteLine ("Server Response requestITR= " + responseFromServer + "end");

				// Clean up the streams.
				reader.Close ();
				dataStream.Close ();
				response.Close ();

				return responseFromServer;

			} catch(Exception e){
				Console.WriteLine (e.Message);
			}

			return null;
		}
		}*/

		public static string requestITR(string uprn, string houseID,string firstname,string surname, string fullName, string canvassID, string status, string token){

		try {
			// Create a request using a URL that can receive a post. 
			//WebRequest request = WebRequest.Create ("https://api.moderndemocracy.com/api/v2.0/resident/new/" + canvassID);
			//WebRequest request = WebRequest.Create ("http://api.eyespyfx.co.uk/api/v2.0/resident/new/" + canvassID);
			WebRequest request = WebRequest.Create (DataController.url + "/api/v2.0/resident/new/" + canvassID);
			// Set the Method property of the request to POST.
			request.Method = "POST";
			request.Headers.Add ("Authorization", token);

			// Create POST data and convert it to a byte array.
			Dictionary<string, object> postData = new Dictionary<string, object> ();
			Dictionary<string, object> jsonDict = new Dictionary<string, object> ();
			postData.Add ("uprn", HttpUtility.UrlEncode(uprn));
			postData.Add ("houseID", houseID);
			postData.Add ("fullName", fullName);
			postData.Add ("firstNames", firstname);
			postData.Add ("surname", surname);
			postData.Add ("title", "");
			postData.Add ("status", status);
			postData.Add ("itr_code", status)	;

			string jsonData = JsonConvert.SerializeObject(postData, Formatting.Indented);

			//Console.WriteLine ("jsonData ITR= " + jsonData);

			byte[] byteArray = Encoding.UTF8.GetBytes (jsonData);

			//Console.WriteLine(postData);
			// Set the ContentType property of the WebRequest.
			request.ContentType = "application/json";
			// Set the ContentLength property of the WebRequest.
			request.ContentLength = byteArray.Length;
			// Get the request stream.
			Stream dataStream = request.GetRequestStream ();
			// Write the data to the request stream.
			dataStream.Write (byteArray, 0, byteArray.Length);
			// Close the Stream object.
			dataStream.Close ();
			// Get the response.
			WebResponse response = request.GetResponse ();
			// Display the status.
			//Console.WriteLine (((HttpWebResponse)response).StatusDescription);
			// Get the stream containing content returned by the server. 
			dataStream = response.GetResponseStream ();
			// Open the stream using a StreamReader for easy access.
			StreamReader reader = new StreamReader (dataStream);
			// Read the content.
			string responseFromServer = reader.ReadToEnd ();

			//Console.WriteLine ("Server Response ITR= " + responseFromServer + "end");

			// Clean up the streams.
			reader.Close ();
			dataStream.Close ();
			response.Close ();

			//			jsonDict = JsonConvert.DeserializeObject<Dictionary<string, object>>(responseFromServer);
			//			Console.WriteLine("jsonDict " + jsonDict);
			//
			//			bool success = false;
			//
			//			if (jsonDict.ContainsKey ("message")) {
			//				if (jsonDict ["message"].ToString () == "Account not found.") {
			//					success = false;
			//				}
			//			} 
			//			else {
			//				success = true;
			//				DataController.token = jsonDict ["token"].ToString ();
			//				DataController.role = jsonDict ["role"].ToString ();
			//				DataController.userID = jsonDict ["id"].ToString ();
			//				DataController.managerID = jsonDict ["managerID"].ToString ();
			//			}
			//
			//			Console.WriteLine ("Success " + success);

			return responseFromServer;

		} catch(Exception e){
			//Console.WriteLine (e.Message);
		}

		return null;
	}
		public static string updatePropertyNote(string uprn, string note, string token){

			try {
			// Create a request using a URL that can receive a post. 
			//WebRequest request = WebRequest.Create ("https://api.moderndemocracy.com/api/v2.0/residence/" + DataController.canvassID + "/" + uprn);
			//WebRequest request = WebRequest.Create ("http://api.eyespyfx.co.uk/api/v2.0/residence/" + DataController.canvassID + "/" + uprn);
			WebRequest request = WebRequest.Create (DataController.url + "/api/v2.0/residence/" + DataController.canvassID + "/" + HttpUtility.UrlEncode(uprn));
			// Set the Method property of the request to POST.
			request.Method = "PUT";
			request.Headers.Add ("Authorization", token);

			// Create POST data and convert it to a byte array.
			Dictionary<string, object> postData = new Dictionary<string, object> ();
			Dictionary<string, object> jsonDict = new Dictionary<string, object> ();
			postData.Add ("status", "NC");
			postData.Add ("notes", note);

			string jsonData = JsonConvert.SerializeObject(postData, Formatting.Indented);

			//Console.WriteLine ("jsonData propertyNote= " + jsonData);

			byte[] byteArray = Encoding.UTF8.GetBytes (jsonData);

			//Console.WriteLine(postData);
			// Set the ContentType property of the WebRequest.
			request.ContentType = "application/json";
			// Set the ContentLength property of the WebRequest.
			request.ContentLength = byteArray.Length;
			// Get the request stream.
			Stream dataStream = request.GetRequestStream ();
			// Write the data to the request stream.
			dataStream.Write (byteArray, 0, byteArray.Length);
			// Close the Stream object.
			dataStream.Close ();
			// Get the response.
			WebResponse response = request.GetResponse ();
			// Display the status.
			//Console.WriteLine (((HttpWebResponse)response).StatusDescription);
			// Get the stream containing content returned by the server. 
			dataStream = response.GetResponseStream ();
			// Open the stream using a StreamReader for easy access.
			StreamReader reader = new StreamReader (dataStream);
			// Read the content.
			string responseFromServer = reader.ReadToEnd ();

			//Console.WriteLine ("Server Response PropertyNoteeeeeeeeeeeeeeeeeee= " + responseFromServer + "end");

			// Clean up the streams.
			reader.Close ();
			dataStream.Close ();
			response.Close ();

			return responseFromServer;

			} catch (Exception e){
				
			}

			return null;
		}
		public static string updatePropertyNoteITR(string uprn, string note2, string token){

			try {
				// Create a request using a URL that can receive a post. 
				//WebRequest request = WebRequest.Create ("https://api.moderndemocracy.com/api/v2.0/residence/" + DataController.canvassID + "/" + uprn);
				//WebRequest request = WebRequest.Create ("http://api.eyespyfx.co.uk/api/v2.0/residence/" + DataController.canvassID + "/" + uprn);
				WebRequest request = WebRequest.Create (DataController.url + "/api/v2.0/residence/" + DataController.canvassID + "/" + HttpUtility.UrlEncode(uprn));
				// Set the Method property of the request to POST.
				request.Method = "PUT";
				request.Headers.Add ("Authorization", token);

				// Create POST data and convert it to a byte array.
				Dictionary<string, object> postData = new Dictionary<string, object> ();
				Dictionary<string, object> jsonDict = new Dictionary<string, object> ();
				postData.Add ("status", "NC");
				postData.Add ("notesItr", note2);

				string jsonData = JsonConvert.SerializeObject(postData, Formatting.Indented);

				//Console.WriteLine ("jsonData propertyNote2= " + jsonData);

				byte[] byteArray = Encoding.UTF8.GetBytes (jsonData);

				//Console.WriteLine(postData);
				// Set the ContentType property of the WebRequest.
				request.ContentType = "application/json";
				// Set the ContentLength property of the WebRequest.
				request.ContentLength = byteArray.Length;
				// Get the request stream.
				Stream dataStream = request.GetRequestStream ();
				// Write the data to the request stream.
				dataStream.Write (byteArray, 0, byteArray.Length);
				// Close the Stream object.
				dataStream.Close ();
				// Get the response.
				WebResponse response = request.GetResponse ();
				// Display the status.
				//Console.WriteLine ("hellooooo"+((HttpWebResponse)response).StatusDescription);
				// Get the stream containing content returned by the server. 
				dataStream = response.GetResponseStream ();
				// Open the stream using a StreamReader for easy access.
				StreamReader reader = new StreamReader (dataStream);
				// Read the content.
				string responseFromServer = reader.ReadToEnd ();

				//Console.WriteLine ("Server Response PropertyNote222222222222222222222222222= " + responseFromServer + "end");

				// Clean up the streams.
				reader.Close ();
				dataStream.Close ();
				response.Close ();

				return responseFromServer;

			} catch (Exception e){

			}

			return null;
		}
		public static bool changePassword(string oldPassword, string newPassword, string token){

			bool success = false;

			try {
			// Create a request using a URL that can receive a post. 
			//WebRequest request = WebRequest.Create ("https://api.moderndemocracy.com/api/v1.0/password/user/" + DataController.userID);
			//WebRequest request = WebRequest.Create ("http://api.eyespyfx.co.uk/api/v1.0/password/user/" + DataController.userID);
			WebRequest request = WebRequest.Create (DataController.url + "/api/v1.0/password/user/" + DataController.userID);
			// Set the Method property of the request to POST.
			request.Method = "PUT";
			request.Headers.Add ("Authorization", token);

			// Create POST data and convert it to a byte array.
			Dictionary<string, object> postData = new Dictionary<string, object> ();
			Dictionary<string, object> jsonDict = new Dictionary<string, object> ();
			postData.Add ("oldPassword", oldPassword );
			postData.Add ("newPassword", newPassword);

			string jsonData = JsonConvert.SerializeObject(postData, Formatting.Indented);

			//Console.WriteLine ("jsonData password= " + jsonData);

			byte[] byteArray = Encoding.UTF8.GetBytes (jsonData);

			//Console.WriteLine(postData);
			// Set the ContentType property of the WebRequest.
			request.ContentType = "application/json";
			// Set the ContentLength property of the WebRequest.
			request.ContentLength = byteArray.Length;
			// Get the request stream.
			Stream dataStream = request.GetRequestStream ();
			// Write the data to the request stream.
			dataStream.Write (byteArray, 0, byteArray.Length);
			// Close the Stream object.
			dataStream.Close ();
			// Get the response.
			WebResponse response = request.GetResponse ();
			// Display the status.
			//Console.WriteLine (((HttpWebResponse)response).StatusDescription);
			// Get the stream containing content returned by the server. 
			dataStream = response.GetResponseStream ();
			// Open the stream using a StreamReader for easy access.
			StreamReader reader = new StreamReader (dataStream);
			// Read the content.
			string responseFromServer = reader.ReadToEnd ();

			//Console.WriteLine ("Server Response passwordChange= " + responseFromServer + "end");
			jsonDict = JsonConvert.DeserializeObject<Dictionary<string, object>>(responseFromServer);

			// Clean up the streams.
			reader.Close ();
			dataStream.Close ();
			response.Close ();

			success = (bool)jsonDict ["success"];

			} catch (Exception e){
				
			}

			return success;
		}

		public static string getURL(){
			
			try {
			// Create a request using a URL that can receive a post. 
			//WebRequest request = WebRequest.Create ("http://api.eyespyfx.co.uk/api/v1.0/residences/33/WBN");
			//WebRequest request = WebRequest.Create ("http://www.eyespyfx.co.uk/server2.php");
			// Set the Method property of the request to POST.
			//request.Method = "GET";

			// Create POST data and convert it to a byte array.
			//Dictionary<string, object> postData = new Dictionary<string, object> ();
			//Dictionary<string, object> jsonDict = new Dictionary<string, object> ();
			//Dictionary<string, object> dataDict = new Dictionary<string, object> ();

			// Set the ContentType property of the WebRequest.
			//request.ContentType = "application/json";
			// Get the response.
			//WebResponse response = request.GetResponse ();
			// Display the status.
			//Console.WriteLine (((HttpWebResponse)response).StatusDescription);
			// Get the stream containing content returned by the server. 
			//Stream dataStream = response.GetResponseStream ();
			// Open the stream using a StreamReader for easy access.
			//StreamReader reader = new StreamReader (dataStream);
			// Read the content.
			//string responseFromServer = reader.ReadToEnd ();

			

			// Clean up the streams.
			//reader.Close ();
			//dataStream.Close ();
			//response.Close ();

			//dataDict = JsonConvert.DeserializeObject<Dictionary<string, object>>(responseFromServer);
				//dataDict ["server"].ToString ()*/
				DataController.url ="http://api.mdcanvassapp.com";
				//Console.WriteLine ("Server Response URL= " + responseFromServer + "end");

			//return responseFromServer;

			} catch (Exception e){
				
			}

			return null;
		}
	}
}
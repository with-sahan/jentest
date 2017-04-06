using Android.App;
using Android.Content.PM;
using Android.Content.Res;
using Android.OS;
using Android.Support.V4.App;
using Android.Support.V4.Widget;
using Android.Views;
using Android.Widget;

using NavDrawer.Fragments;
using NavDrawer.Helpers;
using Android.Support.V4.View;
using Android.Support.V7.App;
using System;
using System.Text;
using Android.Net;
using Android.Content;

namespace NavDrawer
{
	[Activity (Label = "Canvasser", MainLauncher = true, Icon = "@drawable/icon" ,Theme = "@style/MyTheme", ScreenOrientation = ScreenOrientation.SensorLandscape)]
	public class LoginActivity : ActionBarActivity
	{
		ConnectivityManager cm;

		protected override void OnCreate (Bundle bundle)
		{
			base.OnCreate (bundle);

			cm = (ConnectivityManager)this.GetSystemService(Context.ConnectivityService);
			// Set our view from the "main" layout resource
			SetContentView (Resource.Layout.Login);
			// Get our button from the layout resource,
			// and attach an event to it

			Button LoginBtn = FindViewById<Button> (Resource.Id.loginButton);
			EditText emailInput = FindViewById<EditText> (Resource.Id.emailInput);
			EditText passwordInput = FindViewById<EditText> (Resource.Id.passwordInput);

			LoginBtn.Click += delegate {
				if(checkNetwork()){
				if(emailInput.Text != "" && passwordInput.Text != ""){
				string email = RemoveSpecialCharacters(emailInput.Text);
//				string password = RemoveSpecialCharactersPassword (passwordInput.Text);
				string password = passwordInput.Text;
				NetworkCalls.getURL ();
						//Console.WriteLine("URL print"+DataController.url);
				bool success = NetworkCalls.Login(email, password, "");
				//Console.WriteLine("Username " + email);
				//Console.WriteLine("Password " + password);

				if(success){
					//load next window
					//Console.WriteLine("Login Successful");
					DataController.userEmail = email;
					StartActivity(typeof(HomeView));
				}
				else{
					Toast loginFailed = new Toast(this);
					loginFailed = Toast.MakeText(Application.Context, "Login Failed, Please check details and try again.", ToastLength.Short);
					loginFailed.Show();
				}
				}
				else{
					Toast invalidDetails = new Toast(this);
					invalidDetails = Toast.MakeText(Application.Context, "Login Failed, Username/Password cannot be empty.", ToastLength.Short);
					invalidDetails.Show();
				}
				}else{
					showNetworkError();
				}
			};
		}

		public static string RemoveSpecialCharacters(string str) {
			StringBuilder sb = new StringBuilder();
			char previous = '\0';
			//Console.WriteLine ("StringBuilder " + str);
			foreach (char c in str) {
				if ((c >= '0' && c <= '9') || (c >= 'A' && c <= 'Z') || (c >= 'a' && c <= 'z') || c == '.' || c == '_' || c == '@' || c == '-') {
					if (c == '@' || c == '.' || c == '_' || c == '-') {
						if (c != previous) {
							previous = c;
							sb.Append (c);
						}
					} else {
						previous = c;
						sb.Append (c);
					}

				}
			}
			return sb.ToString();
		}

//		public static string RemoveSpecialCharactersPassword(string str) {
//			StringBuilder sb = new StringBuilder();
//			Console.WriteLine ("StringBuilder " + str);
//			foreach (char c in str) {
//				if ((c >= '0' && c <= '9') || (c >= 'A' && c <= 'Z') || (c >= 'a' && c <= 'z') || c == '.' || c == '_' || c == '@') {
//						sb.Append (c);
//					}
//			}
//			return sb.ToString();
//		}
			
		public override void OnBackPressed ()
		{
		}

		public void showNetworkError(){

			Toast noNetwork = new Toast (this);
			noNetwork = Toast.MakeText (this.ApplicationContext, "No Network, You are not connected to the internet.", ToastLength.Short);
			noNetwork.Show ();
		}

		public bool checkNetwork(){

			NetworkInfo activeNetwork = cm.ActiveNetworkInfo;
			bool isConnected = activeNetwork != null &&
				activeNetwork.IsConnectedOrConnecting;

			return isConnected;
		}
	}
}
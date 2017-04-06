using Android.App;
using Android.Content;
using Android.Support.V4.App;
using Android.Views;
using Android.Widget;
//using NavDrawer.Activities;
using com.refractored.monodroidtoolkit.imageloader;
using Fragment = Android.Support.V4.App.Fragment;
using TaskStackBuilder = Android.Support.V4.App.TaskStackBuilder;
using Android.Webkit;
using System;
using Android.Locations;
using Android.Net;

namespace NavDrawer.Fragments
{
    public class RegisterFragment : Fragment
    {
		ConnectivityManager cm;

		public RegisterFragment()
		{
			this.RetainInstance = true;
			this.HasOptionsMenu = (true);
		}
		public override Android.Views.View OnCreateView(Android.Views.LayoutInflater inflater, Android.Views.ViewGroup container, Android.OS.Bundle savedInstanceState)
		{
			Android.Support.V4.App.Fragment residentsFragment = null;
			Android.Support.V4.App.Fragment residentsPrevFragment = null;

			residentsFragment = FragmentManager.FindFragmentByTag ("residentsFragment");
			residentsPrevFragment = FragmentManager.FindFragmentByTag ("residentsPrevFragment");


			if (residentsFragment != null) 
			{
				Android.Support.V4.App.FragmentTransaction ft1 = FragmentManager.BeginTransaction ();
				ft1.Remove (residentsFragment);
				ft1.AddToBackStack(null);
				ft1.Commit ();

			}

			if(residentsPrevFragment != null)
			{
				Android.Support.V4.App.FragmentTransaction ft2 = FragmentManager.BeginTransaction ();
				ft2.Remove (residentsPrevFragment);
				ft2.AddToBackStack(null);
				ft2.Commit ();
			}

			var ignored = base.OnCreateView(inflater, container, savedInstanceState);
			var view = inflater.Inflate(Resource.Layout.fragment_register, null);

			cm = (ConnectivityManager)Activity.GetSystemService(Context.ConnectivityService);

			if(checkNetwork()){
			WebView localWebView = view.FindViewById<WebView>(Resource.Id.webView1);
			localWebView.SetWebViewClient (new WebViewClient ()); // stops request going to Web Browser
			localWebView.LoadUrl ("https://www.registertovote.service.gov.uk/register-to-vote/country-of-residence?_ga=1.24772217.255160918.1436270892");
			} else{
				showNetworkError();
			}

			return view;
		}

		public override void OnCreateOptionsMenu(IMenu menu, MenuInflater inflater)
		{
			inflater.Inflate(Resource.Menu.MainMenu, menu);
			IMenuItem emailDisplay = menu.FindItem (Resource.Id.menu_email);
			emailDisplay.SetTitle (DataController.userEmail);
		}

		public override bool OnOptionsItemSelected(IMenuItem item)
		{
			switch (item.ItemId)
			{
			case Resource.Id.logout:
				//Console.WriteLine ("Log out!");
				Activity.StartActivity(typeof(LoginActivity));
				LocationManager locMgr;
				locMgr = (LocationManager)this.Activity.GetSystemService (Context.LocationService);
				locMgr.RemoveUpdates ((ILocationListener)this.Activity);
				DataController.addresses = null;
				DataController.coords = null;
				return true;
			}
			return base.OnOptionsItemSelected(item);
		}

		public void showNetworkError(){

			Toast noNetwork = new Toast (this.Activity);
			noNetwork = Toast.MakeText (Activity.ApplicationContext, "No Network, You are not connected to the internet.", ToastLength.Short);
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
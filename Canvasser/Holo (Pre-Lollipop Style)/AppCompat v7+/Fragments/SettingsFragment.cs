using Android.App;
using Android.Content;
using Android.Support.V4.App;
using Android.Views;
using Android.Widget;
//using NavDrawer.Activities;
using com.refractored.monodroidtoolkit.imageloader;
using Fragment = Android.Support.V4.App.Fragment;
using TaskStackBuilder = Android.Support.V4.App.TaskStackBuilder;
using System;
using Android.Locations;
using Android.Content;
using Android.Net;

namespace NavDrawer.Fragments
{
	public class SettingsFragment : Fragment
	{
		EditText oldPass;
		EditText newPass;
		Button changePass;
		ConnectivityManager cm;

		public SettingsFragment()
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
			var view = inflater.Inflate(Resource.Layout.fragment_settings, null);
			cm = (ConnectivityManager)Activity.GetSystemService(Context.ConnectivityService);

			oldPass = (EditText)view.FindViewById (Resource.Id.oldPassword);
			newPass = (EditText)view.FindViewById (Resource.Id.newPassword);
			changePass = (Button)view.FindViewById (Resource.Id.changePassword);

			changePass.Click += (object sender, EventArgs e) => 
			{
				changePassword();
			};

			return view;
		}

		public override void OnCreateOptionsMenu(IMenu menu, MenuInflater inflater)
		{
			inflater.Inflate(Resource.Menu.SettingsMenu, menu);
			IMenuItem emailDisplay = menu.FindItem (Resource.Id.menu_email);
			emailDisplay.SetTitle (DataController.userEmail);

			IMenuItem version = menu.FindItem (Resource.Id.menu_version);
			version.SetTitle ("v" + DataController.version);
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

		public void changePassword(){

			if (checkNetwork ()) {
				string oldPassword = oldPass.Text;
				string newPassword = newPass.Text;

				bool success = NetworkCalls.changePassword (oldPassword, newPassword, DataController.token);

				if (success) {
					Toast changed = new Toast (this.Activity);
					changed = Toast.MakeText (Application.Context, "Password Changed, Password was changed successfully.", ToastLength.Short);
					changed.Show ();
				} else {
					Toast failed = new Toast (this.Activity);
					failed = Toast.MakeText (Application.Context, "Password not Changed, Password was not changed, try again.", ToastLength.Short);
					failed.Show ();
				}

				oldPass.Text = "";
				newPass.Text = "";
			} else {
				showNetworkError ();
			}
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



using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

using Android.App;
using Android.Content;
using Android.OS;
using Android.Runtime;
using Android.Views;
using Android.Widget;
using Android.Locations;

namespace NavDrawer
{
	[Activity (Label = "LocationActivity")]			
	public class LocationActivity : Activity, ILocationListener
	{
		public LocationManager locMgr;

		protected override void OnCreate (Bundle bundle)
		{
			base.OnCreate (bundle);
			// Create your application here
			Activity activity = this;
			locMgr = (LocationManager)activity.GetSystemService(Context.LocationService);
		}

		protected override void OnResume ()
		{
			base.OnResume ();
		}

		public void OnProviderEnabled (string provider)
		{

		}
		public void OnProviderDisabled (string provider)
		{

		}
		public void OnStatusChanged (string provider, Availability status, Bundle extras)
		{

		}
		public void OnLocationChanged (Android.Locations.Location location)
		{
			//Console.WriteLine ("Latitude " + location.Latitude);
			//Console.WriteLine ("Longitude " + location.Longitude);

			DataController.lat = location.Latitude.ToString ();
			DataController.lng = location.Longitude.ToString ();
			DataController.accuracy = location.Accuracy.ToString ();
			DataController.locationType = location.Provider.ToString ();

			//Console.WriteLine ("Timestamp " + DateTimeToUnixTimestamp(DateTime.Now));

			//			NetworkCalls.SendLocation (DataController.userID, DataController.lng, DataController.lat, DataController.accuracy, 
			//				DataController.locationType, DateTimeToUnixTimestamp(DateTime.Now).ToString(), DataController.token);  

		}

		public double DateTimeToUnixTimestamp(DateTime dateTime)
		{
			return (dateTime - new DateTime(1970, 1, 1).ToLocalTime()).TotalSeconds;
		}

		public void stopLocations(){

			locMgr.RemoveUpdates (this);
		}

		public void startLocations(){

			Criteria locationCriteria = new Criteria();

			locationCriteria.Accuracy = Accuracy.Coarse;
			locationCriteria.PowerRequirement = Power.Medium;

			string Provider = locMgr.GetBestProvider(locationCriteria, true);

			if (Provider != null) 
			{
				locMgr.RequestLocationUpdates (Provider, 1000, 0, this);
			}
			else
			{
				Console.WriteLine(Provider + " is not available. Does the device have location services enabled?");
			}
		}
	}
}


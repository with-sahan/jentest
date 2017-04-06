using Android.OS;
using Android.Support.V4.App;
using Android.Support.V4.View;
using Android.Widget;
using Android.Gms.Maps;
using Android.Gms.Maps.Model;
using System;
using System.Collections;
using System.Collections.Generic;

using DK.Ostebaronen.Droid.ViewPagerIndicator;

//using NavDrawer.Adapters;
using Fragment = Android.Support.V4.App.Fragment;
using Android.Views;
using Android.Locations;
using Android.Content;

namespace NavDrawer.Fragments
{
	public class mapFragment : Fragment
    {
		SupportMapFragment mapFrag;
		public List<LatLng> coords = new List<LatLng>();
		List<Dictionary<string, object>> addresses = new List<Dictionary<string, object>>();
		public Dictionary<string, object> propertyDict = new Dictionary<string, object> ();

		public mapFragment()
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
		
			var view = inflater.Inflate(Resource.Layout.fragment_map, null);
			//MapsInitializer.initialize(getActivity());
			mapFrag = (SupportMapFragment) FragmentManager.FindFragmentById(Resource.Id.map);
			//Console.WriteLine ("before maps");
			GoogleMap map = mapFrag.Map;
			//Console.WriteLine ("after maps");

			if(DataController.lat != null && DataController.lng != null){
			
			//Console.WriteLine ("inside map if");
			LatLng location = new LatLng(Convert.ToDouble(DataController.lat), Convert.ToDouble(DataController.lng));
			//Console.WriteLine ("after getting locations");
			CameraPosition.Builder builder = CameraPosition.InvokeBuilder ();
			//Console.WriteLine ("After the camera");
			builder.Target (location);
			builder.Zoom (15);
			builder.Bearing (0);
			builder.Tilt (0);
			
			CameraPosition cameraPosition = builder.Build ();
			CameraUpdate cameraUpdate = CameraUpdateFactory.NewCameraPosition (cameraPosition);
			map.AnimateCamera (cameraUpdate);
			}
		    
			if (map != null) {
//				MarkerOptions markerOpt1 = new MarkerOptions();
//				markerOpt1.SetPosition(new LatLng(Convert.ToDouble(DataController.lat), Convert.ToDouble(DataController.lng)));
//				markerOpt1.SetTitle("My Location");
//				markerOpt1.SetIcon (BitmapDescriptorFactory.DefaultMarker (BitmapDescriptorFactory.HueAzure));
//				map.AddMarker(markerOpt1);

				coords = DataController.coords;
				addresses = DataController.addresses;

				if (coords != null) {
					for (int i = 0; i < coords.Count; i++) {
						MarkerOptions markerOpt1 = new MarkerOptions ();
						propertyDict = addresses [i];
						markerOpt1.SetPosition (coords [i]);
						//if (propertyDict ["status"].ToString() != "NV") {
							markerOpt1.SetTitle (propertyDict ["fullAddress"].ToString ());
							//markerOpt1.SetIcon (BitmapDescriptorFactory.DefaultMarker (BitmapDescriptorFactory.HueAzure));
						//} else {
						//	markerOpt1.SetTitle (propertyDict ["fullAddress"].ToString ());
						//}
						map.AddMarker (markerOpt1);
					}
					//map.MoveCamera (cameraUpdate);
				}
					map.MyLocationEnabled = true;
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
				Activity.StartActivity (typeof(LoginActivity));
				LocationManager locMgr;
				locMgr = (LocationManager)this.Activity.GetSystemService (Context.LocationService);
				locMgr.RemoveUpdates ((ILocationListener)this.Activity);
				DataController.addresses = null;
				DataController.coords = null;
				return true;
			}
			return base.OnOptionsItemSelected(item);
		}

		public override void OnDestroy ()
		{
			base.OnDestroy ();
			FragmentTransaction ft = FragmentManager.BeginTransaction ();
			ft.Remove (mapFrag);
			ft.Commit ();
		}
    }
}
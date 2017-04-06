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

using Android.Locations;
using Android.Content;


namespace NavDrawer
{
	[Activity(Label = "Canvasser", MainLauncher = false, LaunchMode = LaunchMode.SingleTop,Theme = "@style/MyTheme", Icon = "@drawable/icon", ScreenOrientation = ScreenOrientation.SensorLandscape)]
	public class HomeView : ActionBarActivity, ILocationListener
	{
        private MyActionBarDrawerToggle m_DrawerToggle;
        private string m_DrawerTitle;
        private string m_Title;

        private DrawerLayout m_Drawer;
        private ListView m_DrawerList;
        private static readonly string[] Sections = new[]
            {
                "Properties", "Map", "Register To Vote", "Settings"
            };

		public LocationManager locMgr;

        protected override void OnCreate(Bundle savedInstanceState)
        {
            base.OnCreate(savedInstanceState);
            SetContentView(Resource.Layout.page_home_view);
			this.Title = "Home";
            this.m_Title = this.m_DrawerTitle = this.Title;

            this.m_Drawer = this.FindViewById<DrawerLayout>(Resource.Id.drawer_layout);
            this.m_DrawerList = this.FindViewById<ListView>(Resource.Id.left_drawer);

            this.m_DrawerList.Adapter = new ArrayAdapter<string>(this, Resource.Layout.item_menu, Sections);

            this.m_DrawerList.ItemClick += (sender, args) => ListItemClicked(args.Position);

			this.m_Drawer.SetDrawerShadow(Resource.Drawable.drawer_shadow_dark, (int)GravityCompat.Start);

            //DrawerToggle is the animation that happens with the indicator next to the actionbar
            this.m_DrawerToggle = new MyActionBarDrawerToggle(this, this.m_Drawer,
													  Resource.Drawable.ic_drawer_dark,
                                                      Resource.String.drawer_open,
                                                      Resource.String.drawer_close);

            //Display the current fragments title and update the options menu
            this.m_DrawerToggle.DrawerClosed += (o, args) => 
            {
				this.SupportActionBar.Title = this.m_Title;
				this.SupportInvalidateOptionsMenu();
            };

            //Display the drawer title and update the options menu
            this.m_DrawerToggle.DrawerOpened += (o, args) => 
            {
				this.SupportActionBar.Title = this.m_Title;
				this.SupportInvalidateOptionsMenu();
            };

            //Set the drawer lister to be the toggle.
            this.m_Drawer.SetDrawerListener(this.m_DrawerToggle);

            //if first time you will want to go ahead and click first item.
            if (savedInstanceState == null)
            {
                ListItemClicked(0);
            }

			this.SupportActionBar.SetDisplayHomeAsUpEnabled(true);
			this.SupportActionBar.SetHomeButtonEnabled(true);

			Activity activity = this;
			locMgr = (LocationManager)activity.GetSystemService(Context.LocationService);
        }

        protected override void OnPostCreate(Bundle savedInstanceState)
        {
            base.OnPostCreate(savedInstanceState);
            this.m_DrawerToggle.SyncState();
        }

        public override void OnConfigurationChanged(Configuration newConfig)
        {
            base.OnConfigurationChanged(newConfig);
            this.m_DrawerToggle.OnConfigurationChanged(newConfig);
        }

        // Pass the event to ActionBarDrawerToggle, if it returns
        // true, then it has handled the app icon touch event
        public override bool OnOptionsItemSelected(IMenuItem item)
        {
            if (this.m_DrawerToggle.OnOptionsItemSelected(item))
                return true;

            return base.OnOptionsItemSelected(item);
        }

        private void ListItemClicked(int position)
        {
            Android.Support.V4.App.Fragment fragment = null;
			string Tag = "";
            switch (position)
            {
			case 0:

				//Console.WriteLine ("Canvass clickkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkk");
				fragment = new CanvassesFragment ();
				Tag = "canvassesFragment";
				SupportFragmentManager.PopBackStack ();

//				try {
//					Console.WriteLine (" checking");
//					Android.Support.V4.App.FragmentTransaction ft = SupportFragmentManager.BeginTransaction ();
//					Console.WriteLine (" Fragments found"+SupportFragmentManager.Fragments.Count);
//					foreach (var item in SupportFragmentManager.Fragments) {
//						Console.WriteLine (" item"+item.ToString());
//						if (item.IsAdded) {
//							Console.WriteLine ("Deattaching item"+item.ToString());
//							ft.Detach (item);
//							Console.WriteLine ("done item"+item.ToString());
//						}
//
//					}
//					ft.Add(Resource.Id.content_frame, new CanvassesFragment(), "canvassesFragment");
//
//					ft.AddToBackStack (null);
//					ft.Commit ();
//				} catch (Exception ex) {
//					Console.WriteLine (" exception"+ex.Message);
//				}
//


                    break;
			case 1:
					
					fragment = new mapFragment ();
				SupportFragmentManager.PopBackStack ();
				Tag = "mapFragment";
                    break;
                case 2:
					fragment = new RegisterFragment();
				SupportFragmentManager.PopBackStack ();
				Tag = "registerFragment";
                    break;
			case 3:
					fragment = new SettingsFragment ();
				SupportFragmentManager.PopBackStack ();

				Tag = "settingsFragment";
					break;
            }
			try
			{
				
            SupportFragmentManager.BeginTransaction()
				.Replace(Resource.Id.content_frame, fragment, Tag)
                .Commit();

			}
			catch(Exception ex) 
			{
				//Console.WriteLine ("Exception : " + ex.ToString());
			}

            this.m_DrawerList.SetItemChecked(position, true);
			SupportActionBar.Title = this.m_Title = Sections[position];
            this.m_Drawer.CloseDrawer(this.m_DrawerList);
        }

        public override bool OnPrepareOptionsMenu(IMenu menu)
        {

            var drawerOpen = this.m_Drawer.IsDrawerOpen(this.m_DrawerList);
            //when open don't show anything
            for (int i = 0; i < menu.Size(); i++)
                menu.GetItem(i).SetVisible(!drawerOpen);


            return base.OnPrepareOptionsMenu(menu);
        }

		protected override void OnResume ()
		{
			base.OnResume ();
			//string Provider = LocationManager.GpsProvider;

			Criteria locationCriteria = new Criteria();

			locationCriteria.Accuracy = Accuracy.Coarse;
			locationCriteria.PowerRequirement = Power.Medium;

			string Provider = locMgr.GetBestProvider(locationCriteria, true);


//			if(locMgr.IsProviderEnabled(Provider))
//			{
//				locMgr.RequestLocationUpdates (Provider, 0, 0, this );
//			}
			if (Provider != null) 
			{
				locMgr.RequestLocationUpdates (Provider, 30000, 10, this);
			}
			else
			{
				//Console.WriteLine(Provider + " is not available. Does the device have location services enabled?");
			}
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

			NetworkCalls.SendLocation (DataController.userID, DataController.lng, DataController.lat, DataController.accuracy, 
				DataController.locationType, DateTimeToUnixTimestamp(DateTime.Now).ToString(), DataController.token);  

		}

		public static double DateTimeToUnixTimestamp(DateTime dateTime)
		{
			return (dateTime - new DateTime(1970, 1, 1).ToLocalTime()).TotalSeconds;
		}

		public void startLocationUpdates(){
		}

		public override void OnBackPressed ()
		{
		} 
			
	}
}


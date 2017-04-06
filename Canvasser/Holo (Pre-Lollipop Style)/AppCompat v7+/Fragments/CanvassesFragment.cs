

using System;
using System.Collections.Generic;

using Android.Content;
using Android.Support.V4.App;
using Android.Support.V4.View;
using Android.Views;
using Android.Widget;

//using NavDrawer.Activities;
//using NavDrawer.Adapters;
//using NavDrawer.Models;
using Fragment = Android.Support.V4.App.Fragment;
//using Android.App;
using System.Threading;

using Android.Locations;
//using Android.App;
using System.Text;
using Android.Net;
using Android.Preferences;
using Android.Graphics;

namespace NavDrawer.Fragments
{
	public class CanvassesFragment : Fragment
	{
		public List<Dictionary<string, object>> addresses = new List<Dictionary<string, object>>();
		public Dictionary<string, object> propertyDict = new Dictionary<string, object> ();
		public TableRow rowToLock;

		ConnectivityManager cm;
			
		public CanvassesFragment()
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
				
			Android.Support.V4.App.FragmentTransaction ft = FragmentManager.BeginTransaction ();
			ft.Commit ();


			var ignored = base.OnCreateView(inflater, container, savedInstanceState);
			var view = inflater.Inflate(Resource.Layout.fragment_canvass, null);

			cm = (ConnectivityManager)Activity.GetSystemService(Context.ConnectivityService);


			if(checkNetwork()){
				drawTable (view);
			} else{
				showNetworkError();
			}
				
			return view;
		}

		public void checkNoAnswer (CheckBox noAnswer)
		{
			string uprn = "";
			if (noAnswer.Checked) {
				if(checkNetwork()){
				int i = 0;
				uprn = noAnswer.Tag.ToString ();
				TableRow tr = (TableRow)View.FindViewWithTag (uprn);
				CheckBox empty = (CheckBox)tr.GetVirtualChildAt (2);
				CheckBox derelict = (CheckBox)tr.GetVirtualChildAt (3);
				CheckBox postalRequest = (CheckBox)tr.GetVirtualChildAt (4);
				CheckBox delivered = (CheckBox)tr.GetVirtualChildAt (5);
					ImageView itr = (ImageView)tr.GetVirtualChildAt (6);
				ImageButton residents = (ImageButton)tr.GetVirtualChildAt (7);
				empty.Checked = false;
				derelict.Checked = false;
				postalRequest.Checked = false;
				delivered.Checked = false;
					itr.Enabled = false;
				if (noAnswer.Text == "") {
					noAnswer.Text = "1";
						//Console.WriteLine ("uprn"+uprn);
						//this is for testing
						lockRow (tr);
				} else if (Convert.ToInt32 (noAnswer.Text) <= 2) {
					i = Convert.ToInt32 (noAnswer.Text);
					i++;
					noAnswer.Text = i.ToString ();
					if (i == 2) {
						noAnswer.SetTextColor (Resources.GetColor (Resource.Color.secondVisit));
						lockRow (tr);
					} else if (i == 3) {
						noAnswer.SetTextColor (Resources.GetColor (Resource.Color.thirdVisit));
						noAnswer.Enabled = false;
						empty.Enabled = false;
						derelict.Enabled = false;
						postalRequest.Enabled = false;
						delivered.Enabled = false;
						//residents.Enabled = false;
					}
				}
				tr.SetBackgroundColor (Resources.GetColor (Resource.Color.highlight));
				NetworkCalls.SendStatus (DataController.token, "VNA", uprn, DataController.canvassID);
				} else {
					noAnswer.Checked = false;
					showNetworkError ();
				}
			} else if (!noAnswer.Checked) {
				if (checkNetwork ()) {
					int i = 0;
					uprn = noAnswer.Tag.ToString ();
					if (noAnswer.Text != "") {
						if (Convert.ToInt32 (noAnswer.Text) > 0) {
							i = Convert.ToInt32 (noAnswer.Text);
							i--;
							noAnswer.Text = i.ToString ();
							if (i == 0) {
								noAnswer.Text = "";
							} else if (i == 1) {
								noAnswer.SetTextColor (Resources.GetColor (Resource.Color.tableText));
							} else if (i == 2) {
								noAnswer.SetTextColor (Resources.GetColor (Resource.Color.secondVisit));
								noAnswer.Enabled = true;
							}
						}
					}
					TableRow tr = (TableRow)View.FindViewWithTag (uprn);
					if (tr.Id % 2 == 0)
						tr.SetBackgroundColor (Resources.GetColor (Resource.Color.even));
					else {
						tr.SetBackgroundColor (Resources.GetColor (Resource.Color.odd));
					}
					//Console.WriteLine("no answer is working");
					NetworkCalls.SendStatus (DataController.token, "NV", uprn, DataController.canvassID);
					//Console.WriteLine ("No Answer: " + noAnswer.Tag);
				} else {
					noAnswer.Checked = true;
					showNetworkError ();
				}
			}
		}

		public void checkEmpty (CheckBox empty)
		{
			string status = "";
			string uprn = "";
			if (empty.Checked) {
				if (checkNetwork ()) {
					status = "E";
					uprn = empty.Tag.ToString ();
					TableRow tr = (TableRow)View.FindViewWithTag (uprn);
					CheckBox noAnswer = (CheckBox)tr.GetVirtualChildAt (1);
					CheckBox derelict = (CheckBox)tr.GetVirtualChildAt (3);
					CheckBox postalRequest = (CheckBox)tr.GetVirtualChildAt (4);
					CheckBox delivered = (CheckBox)tr.GetVirtualChildAt (5);
					noAnswer.Checked = false;
					derelict.Checked = false;
					postalRequest.Checked = false;
					delivered.Checked = false;
					noAnswer.Text = "";
					tr.SetBackgroundColor (Resources.GetColor (Resource.Color.highlight));
					//Console.WriteLine("Empty is working");
					//Console.WriteLine (tr.ChildCount);
					NetworkCalls.SendStatus (DataController.token, status, uprn, DataController.canvassID);
					lockRow (tr);
				} else {
					empty.Checked = false;
					showNetworkError ();
				} 
			}
			else if (!empty.Checked) {
				if (checkNetwork ()) {
					status = "NV";
					uprn = empty.Tag.ToString ();
					TableRow tr = (TableRow)View.FindViewWithTag (uprn);
					if (tr.Id % 2 == 0)
						tr.SetBackgroundColor (Resources.GetColor (Resource.Color.even));
					else {
						tr.SetBackgroundColor (Resources.GetColor (Resource.Color.odd));
					}
					NetworkCalls.SendStatus (DataController.token, status, uprn, DataController.canvassID);
					//Console.WriteLine ("Empty: " + empty.Tag);
				} else {
					empty.Checked = true;
					showNetworkError ();
				} 
			}
		}

		public void checkDerelict (CheckBox derelict)
		{
			string status = "";
			string uprn = "";
			if (derelict.Checked) {
				if (checkNetwork ()) {
					status = "D";
					uprn = derelict.Tag.ToString ();
					TableRow tr = (TableRow)View.FindViewWithTag (uprn);
					CheckBox noAnswer = (CheckBox)tr.GetVirtualChildAt (1);
					CheckBox empty = (CheckBox)tr.GetVirtualChildAt (2);
					CheckBox postalRequest = (CheckBox)tr.GetVirtualChildAt (4);
					CheckBox delivered = (CheckBox)tr.GetVirtualChildAt (5);
					noAnswer.Checked = false;
					empty.Checked = false;
					postalRequest.Checked = false;
					delivered.Checked = false;
					noAnswer.Text = "";
					tr.SetBackgroundColor (Resources.GetColor (Resource.Color.highlight));
					NetworkCalls.SendStatus (DataController.token, status, uprn, DataController.canvassID);
					lockRow (tr);
				} else {
					derelict.Checked = false;
					showNetworkError ();
				} 
			}
			else if (!derelict.Checked) {
				if (checkNetwork ()) {
					status = "NV";
					uprn = derelict.Tag.ToString ();
					TableRow tr = (TableRow)View.FindViewWithTag (uprn);
					if (tr.Id % 2 == 0)
						tr.SetBackgroundColor (Resources.GetColor (Resource.Color.even));
					else {
						tr.SetBackgroundColor (Resources.GetColor (Resource.Color.odd));
					}
					NetworkCalls.SendStatus (DataController.token, status, uprn, DataController.canvassID);
					//Console.WriteLine ("Derelict: " + derelict.Tag);
				} else {
					derelict.Checked = true;
					showNetworkError ();
				} 
			}
		}

		public void checkRequestPostal (CheckBox requestPostal)
		{
			string status = "";
			string uprn = "";
			if (requestPostal.Checked) {
				if (checkNetwork ()) {
					status = "HEF-R";
					uprn = requestPostal.Tag.ToString ();
					TableRow tr = (TableRow)View.FindViewWithTag (uprn);
					CheckBox noAnswer = (CheckBox)tr.GetVirtualChildAt (1);
					CheckBox empty = (CheckBox)tr.GetVirtualChildAt (2);
					CheckBox derelict = (CheckBox)tr.GetVirtualChildAt (3);
					CheckBox delivered = (CheckBox)tr.GetVirtualChildAt (5);
					noAnswer.Checked = false;
					derelict.Checked = false;
					empty.Checked = false;
					delivered.Checked = false;
					noAnswer.Text = "";
					tr.SetBackgroundColor (Resources.GetColor (Resource.Color.highlight));
					NetworkCalls.SendStatus (DataController.token, status, uprn, DataController.canvassID);
					lockRow (tr);
				} else {
					requestPostal.Checked = false;
					showNetworkError ();
				} 
			}
			else if (!requestPostal.Checked) {
				if (checkNetwork ()) {
					status = "NV";
					uprn = requestPostal.Tag.ToString ();
					TableRow tr = (TableRow)View.FindViewWithTag (uprn);
					if (tr.Id % 2 == 0)
						tr.SetBackgroundColor (Resources.GetColor (Resource.Color.even));
					else {
						tr.SetBackgroundColor (Resources.GetColor (Resource.Color.odd));
					}
					NetworkCalls.SendStatus (DataController.token, status, uprn, DataController.canvassID);
					//Console.WriteLine ("Postal Request: " + requestPostal.Tag);
				}  else {
					requestPostal.Checked = true;
					showNetworkError ();

				} 
			}
		}

		public void checkDeliveredRequest (CheckBox deliveredRequest)
		{
			string status = "";
			string uprn = "";
			if (deliveredRequest.Checked) {
				if (checkNetwork ()) {
					status = "HEF-D";
					uprn = deliveredRequest.Tag.ToString ();
					TableRow tr = (TableRow)View.FindViewWithTag (uprn);
					CheckBox noAnswer = (CheckBox)tr.GetVirtualChildAt (1);
					CheckBox empty = (CheckBox)tr.GetVirtualChildAt (2);
					CheckBox derelict = (CheckBox)tr.GetVirtualChildAt (3);
					CheckBox postalRequest = (CheckBox)tr.GetVirtualChildAt (4);
					ImageButton residents = (ImageButton)tr.GetVirtualChildAt (7);
					noAnswer.Checked = false;
					derelict.Checked = false;
					empty.Checked = false;
					postalRequest.Checked = false;
					noAnswer.Text = "";
					tr.SetBackgroundColor (Resources.GetColor (Resource.Color.highlight));
					NetworkCalls.SendStatus (DataController.token, status, uprn, DataController.canvassID);
					lockRow (tr);
				} else {
					deliveredRequest.Checked = false;
					showNetworkError ();
				} 
			}
			else if (!deliveredRequest.Checked) {
				if (checkNetwork ()) {
					status = "NV";
					uprn = deliveredRequest.Tag.ToString ();
					TableRow tr = (TableRow)View.FindViewWithTag (uprn);
					if (tr.Id % 2 == 0)
						tr.SetBackgroundColor (Resources.GetColor (Resource.Color.even));
					else {
						tr.SetBackgroundColor (Resources.GetColor (Resource.Color.odd));
					}
					NetworkCalls.SendStatus (DataController.token, status, uprn, DataController.canvassID);
					//Console.WriteLine ("Postal Request: " + deliveredRequest.Tag);
				}  else {
					deliveredRequest.Checked = true;
					showNetworkError ();

				} 
			}
		}


		public void showResidents (ImageButton residents)
		{
			//Console.WriteLine("inside the show residentttttttttttttttttttttttttttttttttttttttttt");
			if (checkNetwork ()) {
				residents.Enabled = false;
				string uprn = residents.Tag.ToString ();
				if (DataController.fileType == "HALAROSE") {
					//Console.WriteLine ("HALAROSE now");
					string houseID = residents.Id.ToString ();
					DataController.houseID = houseID;
				} else {
					DataController.houseID = "houseID";
					//Console.WriteLine ("HouseID");
				}
			
				DataController.uprn = uprn;
				//Console.WriteLine ("Before to the response");
				string response = NetworkCalls.getResidents (DataController.token, DataController.canvassID, uprn);
				//Console.WriteLine ("After of response");

				//			string status = "";
				TableRow tr = (TableRow)View.FindViewWithTag (uprn);
				TextView addressView = (TextView)tr.GetVirtualChildAt (0);
				string address = addressView.Text.ToString ();
				string canvassID = addressView.Tag.ToString ();
				DataController.canvassID = canvassID;
				DataController.address = address;

				DataController.propertyToChange = tr.Id;

				//Console.WriteLine ("before the note");
				//string note = "";
				/*addresses = DataController.addresses;
				propertyDict = addresses [tr.Id];
				DataController.propertyToChange = tr.Id;
				if (propertyDict ["notes"] != null) {
					note = propertyDict ["notes"].ToString ();
				} else {
					note = "";
				}
				DataController.note = note;
				Console.WriteLine (note);*/

				Android.Support.V4.App.Fragment residentsPrevFragment = null;
				residentsPrevFragment = new ResidentsPrevFragment ();

				FragmentTransaction ft = FragmentManager.BeginTransaction ();

				ft.Add (Resource.Id.content_frame, residentsPrevFragment, "residentsPrevFragment");
				ft.Hide (FragmentManager.FindFragmentByTag ("canvassesFragment"));
				ft.AddToBackStack (null);
				ft.Commit ();



			} else {
				showNetworkError ();
			}
		}

		public override void OnCreateOptionsMenu(IMenu menu, MenuInflater inflater)
		{
			inflater.Inflate(Resource.Menu.refresh, menu);
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
				//run the alert in UI thread to display in the screen

				//Activity.StartActivity (typeof(LoginActivity));
				//LocationManager locMgr;
				//locMgr = (LocationManager)this.Activity.GetSystemService (Context.LocationService);
				locMgr.RemoveUpdates ((ILocationListener)this.Activity);
				DataController.addresses = null;
				DataController.coords = null;
				return true;
			case Resource.Id.menu_refresh:
				if (checkNetwork ()) {
					TableLayout tl = (TableLayout)this.View.FindViewById (Resource.Id.table);
					tl.RemoveAllViews ();
					if (DataController.coords != null) {
						DataController.coords.Clear ();
					}
					drawTable (this.View);
				} else {
					showNetworkError ();
				}
				return true;
			}
			return base.OnOptionsItemSelected(item);
		}

		public void setVisited ()
		{
			base.OnResume ();
			//Console.WriteLine("Visited");
		}

		public override void OnHiddenChanged (bool hidden)
		{
			base.OnHiddenChanged (hidden);
			if (!hidden) {
				TableRow row = (TableRow)View.FindViewWithTag (DataController.uprn);
				ImageButton residents = (ImageButton)row.GetVirtualChildAt (7);
				residents.Enabled = true;
				if (DataController.uprn != null && DataController.propertyChange) {
					TableRow tr = (TableRow)View.FindViewWithTag (DataController.uprn);
					tr.SetBackgroundColor (Resources.GetColor (Resource.Color.highlight));
					lockRow (tr);
					DataController.uprn = "";
					DataController.propertyChange = false;
				} else if (DataController.propertyReset) {
					TableRow tr = (TableRow)View.FindViewWithTag (DataController.uprn);
					CheckBox noAnswer = (CheckBox)tr.GetVirtualChildAt (1);
					CheckBox empty = (CheckBox)tr.GetVirtualChildAt (2);
					CheckBox derelict = (CheckBox)tr.GetVirtualChildAt (3);
					CheckBox postalRequest = (CheckBox)tr.GetVirtualChildAt (4);
					CheckBox delivered = (CheckBox)tr.GetVirtualChildAt (5);
					ImageView itr = (ImageView)tr.GetVirtualChildAt (6);
					noAnswer.Text = "";
					noAnswer.Checked = false;
					noAnswer.Enabled = true;
					empty.Enabled = true;
					derelict.Enabled = true;
					postalRequest.Enabled = true;
					delivered.Enabled = true;
					NetworkCalls.SendStatus (DataController.token, "NV", DataController.uprn, DataController.canvassID);
					if (tr.Id % 2 == 0) {
						tr.SetBackgroundColor (Resources.GetColor (Resource.Color.even));
					} else {
						tr.SetBackgroundColor (Resources.GetColor (Resource.Color.odd));
					}
					DataController.propertyReset = false;
				}
			}
		}
		public void drawTable(View view)
		{
			//Console.WriteLine ("inside drawable");
			TableLayout tl = (TableLayout)view.FindViewById (Resource.Id.table);
			//TableRow headers = (TableRow)view.FindViewById (Resource.Id.tableHeaders);
			TableLayout tb = (TableLayout)view.FindViewById(Resource.Id.tableHeaders);
			ScrollView ts = (ScrollView)view.FindViewById (Resource.Id.tableScroll);
		
			string canvass = NetworkCalls.getJobs (DataController.token);

			if (DataController.canvassID != null) {
				string response = NetworkCalls.getProperties (DataController.token);
				//Console.WriteLine ("response got");
				addresses = DataController.addresses;
				//addresses = MockingController.getProperties();

			} else {
				Toast newProperties = new Toast (this.Activity);
				newProperties = Toast.MakeText (Activity.ApplicationContext, "There isn't an assined canvass!", ToastLength.Short);
				//Console.WriteLine("assigning canvass");
				newProperties.Show ();
				return;
			}
			addresses = DataController.addresses;
			//Console.WriteLine("sharedPreference1");
			ISharedPreferences prefs = PreferenceManager.GetDefaultSharedPreferences(this.Activity); 
			ISharedPreferencesEditor editor = prefs.Edit();


			if (prefs.Contains ("properties")) {
				int currProperties = prefs.GetInt ("properties", 0);
				if (currProperties < addresses.Count) {
					//Console.WriteLine("prefs2");
					int difference = addresses.Count - currProperties;
					editor.PutInt ("properties", addresses.Count);
					Toast newProperties = new Toast (this.Activity);
					//Console.WriteLine("prefs3");
					newProperties = Toast.MakeText (Activity.ApplicationContext, "New Properties, You have " + difference + " new properties!", ToastLength.Short);
					newProperties.Show ();
				} else {
					editor.PutInt ("properties", addresses.Count);
					//Console.WriteLine("prefsElse");
				}
			} else {
				
				//Console.WriteLine("prefs4");


				if (addresses != null) 
				{
					editor.PutInt ("properties", addresses.Count);

					Toast newProperties = new Toast (this.Activity);
					newProperties = Toast.MakeText (Activity.ApplicationContext, "New Properties, You have " + addresses.Count + " new properties!", ToastLength.Short);
					//Console.WriteLine("prefs5");
					newProperties.Show ();

				} 

			}
			editor.Apply();



			if (addresses != null && addresses.Count > 0) {
				//tl = (TableLayout)view.FindViewById (Resource.Id.table);
				tl.StretchAllColumns = true;
				tl.BringToFront ();
				TableRow headings = new TableRow (this.Activity);
				headings.SetBackgroundColor (Resources.GetColor (Resource.Color.headers));
				headings.Tag = "headers";
				TextView heading1 = new TextView (this.Activity);
				heading1.Text = " Address";
				heading1.SetTextColor (Resources.GetColor (Resource.Color.odd));
				heading1.TextSize = 15.0f;
				float density = this.Activity.Resources.DisplayMetrics.Density;
				heading1.SetWidth((int)(350 * density));
				TextView heading2 = new TextView (this.Activity);
				heading2.Text = "No Ans";
				heading2.SetTextColor (Resources.GetColor (Resource.Color.odd));
				heading2.TextSize = 15.0f;
				TextView heading3 = new TextView (this.Activity);
				heading3.Text = "Empty";
				heading3.SetTextColor (Resources.GetColor (Resource.Color.odd));
				heading3.TextSize = 15.0f;
				TextView heading4 = new TextView (this.Activity);
				heading4.Text = "Derelict";
				heading4.SetTextColor (Resources.GetColor (Resource.Color.odd));
				heading4.TextSize = 15.0f;
				TextView heading5 = new TextView (this.Activity);
				heading5.Text = "HEF R";
				heading5.SetTextColor (Resources.GetColor (Resource.Color.odd));
				heading5.TextSize = 15.0f;
				TextView heading7 = new TextView (this.Activity);
				heading7.Text = "HEF D";
				heading7.SetTextColor (Resources.GetColor (Resource.Color.odd));
				heading7.TextSize = 15.0f;

				TextView heading8 = new TextView (this.Activity);
				heading8.Text = "ITR";
				heading8.SetTextColor (Resources.GetColor (Resource.Color.odd));
				heading8.TextSize = 15.0f;

				TextView heading6 = new TextView (this.Activity);
				heading6.Text = "Residents";
				heading6.SetTextColor (Resources.GetColor (Resource.Color.odd));
				heading6.TextSize = 15.0f;


				headings.AddView (heading1);
				headings.AddView (heading2);
				headings.AddView (heading3);
				headings.AddView (heading4);
				headings.AddView (heading5);
				headings.AddView (heading7);
				headings.AddView (heading8);
				headings.AddView (heading6);
				tl.AddView (headings);
						
				for (int i = 0; i < addresses.Count; i++) {

					//Dictionary<string, object> propertyDict = new Dictionary<string, object> ();

					propertyDict = addresses [i];
					//Console.WriteLine("for");

					TableRow tr = new TableRow (this.Activity);

					tr.Tag = propertyDict ["uprn"].ToString ();
					tr.Id = i;

//					if (propertyDict ["status"].ToString () != "NV" && propertyDict ["status"].ToString () != "VNA") {
//						tr.SetBackgroundColor (Resources.GetColor (Resource.Color.highlight));
//						rowToLock = tr;
//					} else 
						if (propertyDict ["visitCount"].ToString () == "3") {
						tr.SetBackgroundColor (Resources.GetColor (Resource.Color.highlight));
					} else 
					if (i % 2 == 0) {
						tr.SetBackgroundColor (Resources.GetColor (Resource.Color.even));
					} else {
						tr.SetBackgroundColor (Resources.GetColor (Resource.Color.odd));
					}
							
					TextView address = new TextView (this.Activity);
					//Console.WriteLine("assign1");

					address.Text = propertyDict ["fullAddress"].ToString ();
					address.Tag = propertyDict ["canvassID"].ToString ();
					//Console.WriteLine("assign 2");
					address.TextSize = 18.0f;
					address.SetTextColor (Resources.GetColor (Resource.Color.tableText));
					float density1 = this.Activity.Resources.DisplayMetrics.Density;
					address.SetWidth((int)(350 * density1));
					address.SetPadding (5, 5, 0, 5);
					address.LongClick += (object sender, View.LongClickEventArgs e) => 
					{
						unlockRow(tr.Tag.ToString());
					};

					CheckBox noAnswer = new CheckBox (this.Activity);
					noAnswer.Tag = propertyDict ["uprn"].ToString ();
					noAnswer.Id = 0;
					string visitCount = propertyDict ["visitCount"].ToString ();
					noAnswer.Text = propertyDict ["visitCount"].ToString ();
					if (Convert.ToInt32 (noAnswer.Text) == 0) {
						noAnswer.Text = "";
					} else if (Convert.ToInt32 (noAnswer.Text) == 2) {
						noAnswer.SetTextColor (Resources.GetColor (Resource.Color.secondVisit));
					} else if (Convert.ToInt32 (noAnswer.Text) == 3) {
						noAnswer.Checked = true;
						noAnswer.Enabled = false;
						noAnswer.SetTextColor (Resources.GetColor (Resource.Color.thirdVisit));
					} else {
						noAnswer.SetTextColor (Resources.GetColor (Resource.Color.tableText));
					}
					noAnswer.CheckedChange += (object sender, CompoundButton.CheckedChangeEventArgs e) => {
						checkNoAnswer (noAnswer);
					};

					CheckBox empty = new CheckBox (this.Activity);
					empty.Tag = propertyDict ["uprn"].ToString ();
					empty.Id = 1;
					if (propertyDict ["status"].ToString () == "E") {
						empty.Checked = true;
					}
					if (noAnswer.Text == "3") {
						empty.Enabled = false;
					}
					empty.CheckedChange += (object sender, CompoundButton.CheckedChangeEventArgs e) => {
						checkEmpty (empty);
					};

					CheckBox derelict = new CheckBox (this.Activity);
					derelict.Tag = propertyDict ["uprn"].ToString ();
					derelict.Id = 2;
					if (propertyDict ["status"].ToString () == "D") {
						derelict.Checked = true;
					}
					if (noAnswer.Text == "3") {
						derelict.Enabled = false;
					}
					derelict.CheckedChange += (object sender, CompoundButton.CheckedChangeEventArgs e) => {
						checkDerelict (derelict);
					};

					CheckBox postalRequest = new CheckBox (this.Activity);
					postalRequest.Tag = propertyDict ["uprn"].ToString ();
					postalRequest.Id = 3;

					if (propertyDict ["status"].ToString () == "HEF-R") {
						postalRequest.Checked = true;
					}
					if (noAnswer.Text == "3") {
						postalRequest.Enabled = false;
					}
					postalRequest.CheckedChange += (object sender, CompoundButton.CheckedChangeEventArgs e) => {
						checkRequestPostal (postalRequest);
					};

					CheckBox DeliveredRequest = new CheckBox (this.Activity);
					DeliveredRequest.Tag = propertyDict ["uprn"].ToString ();
					DeliveredRequest.Id = 4;

					if (propertyDict ["status"].ToString () == "HEF-D") {
						DeliveredRequest.Checked = true;
					}
					if (noAnswer.Text == "3") {
						DeliveredRequest.Enabled = false;
					}
					DeliveredRequest.CheckedChange += (object sender, CompoundButton.CheckedChangeEventArgs e) => {
						checkDeliveredRequest (DeliveredRequest);
					};
				

					ImageView itr = new ImageView (this.Activity);
					itr.Tag = propertyDict ["canvassID"].ToString ();
					itr.SetPadding (5, 5, 0, 5);

					if (propertyDict ["itr_added"] != null) 
					{
						itr.SetImageDrawable (Resources.GetDrawable (Resource.Drawable.itr6));
						itr.Background = null;
					} 
					else 
					{
						itr.SetImageDrawable (null);
						itr.Background = null;
					}



					
					ImageButton residents = new ImageButton (this.Activity);
					residents.SetImageDrawable (Resources.GetDrawable (Resource.Drawable.residents));
					residents.Background = null;
					residents.Tag = propertyDict ["uprn"].ToString ();
					if (DataController.fileType == "HALAROSE") {
						residents.Id = Convert.ToInt32 (propertyDict ["houseID"].ToString ());
					}

					//residents.Id = i;
					if (noAnswer.Text == "3") {
						//residents.Enabled = false;
					}
					residents.Click += (object sender, EventArgs e) => {
						showResidents (residents);
					};



					tr.AddView (address);
					tr.AddView (noAnswer);
					tr.AddView (empty);
					tr.AddView (derelict);
					tr.AddView (postalRequest);
					tr.AddView (DeliveredRequest);
					tr.AddView (itr);
					tr.AddView (residents);
					tl.AddView (tr);
					if (rowToLock != null ) {
						lockRow (rowToLock);
						rowToLock = null;
					}
				}
				View headers = tl.FindViewWithTag ("headers");
				tl.RemoveView (tl.FindViewWithTag ("headers"));
				tb.RemoveAllViews ();
//					//tb.RemoveView (tl);
				tb.AddView (headers);
				tb.StretchAllColumns = true;
				ts.RemoveAllViews ();
				ts.AddView (tl);
				tb.AddView(ts);
					//tb.AddView(tl);
					//tb.AddView (tl);

			}
			else {
				Toast changed = new Toast (this.Activity);
				changed = Toast.MakeText (Activity.ApplicationContext, "No Properties, You have not been assigned any properties.", ToastLength.Long);
				changed.Show ();
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

		public void lockRow(TableRow row)
		{
			//TableRow row = (TableRow)View.FindViewWithTag (uprn);
			CheckBox noAnswer = (CheckBox)row.GetVirtualChildAt (1);
			CheckBox empty = (CheckBox)row.GetVirtualChildAt (2);
			CheckBox derelict = (CheckBox)row.GetVirtualChildAt (3);
			CheckBox hefR = (CheckBox)row.GetVirtualChildAt (4);
			CheckBox hefD = (CheckBox)row.GetVirtualChildAt (5);
			ImageView itr = (ImageView)row.GetVirtualChildAt (6);
			ImageButton residents = (ImageButton)row.GetVirtualChildAt (7);
			noAnswer.Enabled = false;
			empty.Enabled = false;
			derelict.Enabled = false;
			hefR.Enabled = false;
			hefD.Enabled = false;
			itr.Enabled = false;
			residents.Enabled = false;
		}

		public void unlockRow(string uprn){

			TableRow row = (TableRow)View.FindViewWithTag (uprn);
			CheckBox noAnswer = (CheckBox)row.GetVirtualChildAt (1);
			CheckBox empty = (CheckBox)row.GetVirtualChildAt (2);
			CheckBox derelict = (CheckBox)row.GetVirtualChildAt (3);
			CheckBox hefR = (CheckBox)row.GetVirtualChildAt (4);
			CheckBox hefD = (CheckBox)row.GetVirtualChildAt (5);
			ImageView itr = (ImageView)row.GetVirtualChildAt (6);
			ImageButton residents = (ImageButton)row.GetVirtualChildAt (7);
			noAnswer.Enabled = true;
			empty.Enabled = true;
			derelict.Enabled = true;
			hefR.Enabled = true;
			hefD.Enabled = true;
			itr.Enabled = true;
			residents.Enabled = true;

			Toast unlocked = new Toast (this.Activity);
			unlocked = Toast.MakeText (Activity.ApplicationContext, "Row Unlocked, Row is now in edit mode.", ToastLength.Short);
			unlocked.Show ();
		}
	}
}
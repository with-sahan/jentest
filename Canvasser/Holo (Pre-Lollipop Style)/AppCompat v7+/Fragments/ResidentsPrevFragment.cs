
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
using Android.App;
using Android.Net;
using System.Text;

namespace NavDrawer.Fragments
{	
	public class ResidentsPrevFragment : Fragment
	{

		public List<Dictionary<string, object>> residents = new List<Dictionary<string, object>>();
		public Dictionary<string, object> currResident = new Dictionary<string, object> ();

		public List<Dictionary<string, object>> addresses = new List<Dictionary<string, object>>();
		public Dictionary<string, object> propertyDict = new Dictionary<string, object> ();

		public List<Dictionary<string, object>> residentUpdate = new List<Dictionary<string, object>> ();

		public EditText note;
		private RadioGroup ItrTypeGroup;
		private RadioButton itrType;

		ConnectivityManager cm;

		public ResidentsPrevFragment()
		{
			this.RetainInstance = true;
			this.HasOptionsMenu = (true);

		}


		public override Android.Views.View OnCreateView(Android.Views.LayoutInflater inflater, Android.Views.ViewGroup container, Android.OS.Bundle savedInstanceState)
		{


			var ignored = base.OnCreateView(inflater, container, savedInstanceState);
			var view = inflater.Inflate(Resource.Layout.fragments_residents, null);
			cm = (ConnectivityManager)Activity.GetSystemService(Context.ConnectivityService);

			if(checkNetwork()){
				drawTable (view);
			} else{
				showNetworkError();
			}

			return view;
		}
			
		public void drawTable(View view){
			if (checkNetwork ()) {

				string canvass = NetworkCalls.getJobs (DataController.token);

				string response = NetworkCalls.getProperties (DataController.token);
				string responseResident = NetworkCalls.getResidents (DataController.token, DataController.canvassID, DataController.uprn);
				//residents = MockingController.getResidentsPrev();
				residents = DataController.residents;
				addresses = DataController.addresses;


				TableLayout tl = (TableLayout)view.FindViewById (Resource.Id.residentstable);
				TableLayout tb = (TableLayout)view.FindViewById(Resource.Id.tableHeaders);
				ScrollView ts = (ScrollView)view.FindViewById (Resource.Id.tableScroll);

				tl.StretchAllColumns = true;
				tl.BringToFront ();
				TableRow headings = new TableRow (this.Activity);
				headings.SetBackgroundColor (Resources.GetColor (Resource.Color.headers));
				headings.Tag = "headers";

				TextView heading0 = new TextView (this.Activity);
				heading0.Text = " ITR";
				float density = this.Activity.Resources.DisplayMetrics.Density;
				heading0.SetWidth((int)(40 * density));
				heading0.SetTextColor (Resources.GetColor (Resource.Color.odd));
				heading0.TextSize = 15.0f;



				TextView heading1 = new TextView (this.Activity);
				heading1.Text = " Name";
				heading1.SetTextColor (Resources.GetColor (Resource.Color.odd));
				heading1.TextSize = 15.0f;
				heading1.SetWidth((int)(220 * density));
				TextView heading2 = new TextView (this.Activity);
				heading2.Text = "Nationality";
				heading2.SetTextColor (Resources.GetColor (Resource.Color.odd));
				heading2.TextSize = 15.0f;
				TextView heading3 = new TextView (this.Activity);
				heading3.Text = "Opt Out";
				heading3.SetTextColor (Resources.GetColor (Resource.Color.odd));
				heading3.TextSize = 15.0f;
				TextView heading4 = new TextView (this.Activity);
				heading4.Text = "Absent Vote";
				heading4.SetTextColor (Resources.GetColor (Resource.Color.odd));
				heading4.TextSize = 15.0f;
				TextView heading5 = new TextView (this.Activity);
				heading5.Text = "Jury Duty";
				heading5.SetTextColor (Resources.GetColor (Resource.Color.odd));
				heading5.TextSize = 15.0f;
				//			TextView heading6 = new TextView(this.Activity);
				//			heading6.Text = "Residents";

				headings.AddView (heading0);
				headings.AddView (heading1);
				headings.AddView (heading2);
				headings.AddView (heading3);
				headings.AddView (heading4);
				headings.AddView (heading5);
				//headings.AddView(heading6);
				tl.AddView (headings);


				for (int i = 0; i < residents.Count; i++) {

					Dictionary<string, object> residentDict = new Dictionary<string, object> ();
					//String OptOut, Absent, Jury;


					residentDict = residents [i];

					TableRow tr = new TableRow (this.Activity);

					if (i % 2 == 0) {
						tr.SetBackgroundColor (Resources.GetColor (Resource.Color.even));
					} else {
						tr.SetBackgroundColor (Resources.GetColor (Resource.Color.odd));
					}

					tr.Tag = residentDict ["id"].ToString ();
					tr.Id = i;
					TextView name = new TextView (this.Activity);

					name.Text = " " + residentDict ["fullName"].ToString ();


					float density1 = this.Activity.Resources.DisplayMetrics.Density;
					name.SetWidth((int)(200 * density1));
					name.SetPadding (5, 5, 0, 5);


					name.Tag = "name" + i;
					name.TextSize = 18.0f;
					name.SetTextColor (Resources.GetColor (Resource.Color.tableText));
					name.Click += (object sender, EventArgs e) => {
						nameCorrect (name);
					};


					ImageView itr = new ImageView (this.Activity);


					if (residentDict ["itr_added"] != null) 
					{
						itr.SetImageDrawable (Resources.GetDrawable (Resource.Drawable.itr6));
						itr.Background = null;
					} 
					else 
					{
						itr.SetImageDrawable (null);
						itr.Background = null;
					}

					itr.SetPadding ((int)(-50 * density1), 5, 0, 5);



					TextView nationality = new TextView (this.Activity);
					nationality.Text = residentDict ["nationality"].ToString ();
					//residentUpdate[i].Add ("nationality", residentDict ["nationality"].ToString ());
					nationality.Tag = i;
					nationality.TextSize =18.0f;
					nationality.SetTextColor (Resources.GetColor (Resource.Color.tableText));
					nationality.Click += (object sender, EventArgs e) => {
						nationalityCorrect (nationality);
					};
					CheckBox optOut = new CheckBox (this.Activity);
					optOut.Tag = i;
					if (residentDict ["optOut"].ToString () == "YES") {
						optOut.Checked = true;
						//OptOut = "YES";

					} else {
						optOut.Checked = false;
						//OptOut = "NO";
					}
					optOut.CheckedChange += (object sender, CompoundButton.CheckedChangeEventArgs e) => {
						checkOptOut (optOut);

					};
					//residentUpdate[i].Add ("optOut");
					CheckBox absentVote = new CheckBox (this.Activity);

					//absentVote.Enabled = false;
					absentVote.Tag = i;
					if (residentDict ["absent"].ToString () == "YES") {
						absentVote.Checked = true;
						//Absent = "YES";
					} else {
						absentVote.Checked = false;
						//Absent = "NO";
					}
					absentVote.CheckedChange += (object sender, CompoundButton.CheckedChangeEventArgs e) => {
						checkAbsentVote (absentVote);
					};
					//residentUpdate[i].Add ("absent");
					CheckBox juryDuty = new CheckBox (this.Activity);
					juryDuty.Tag = i;
					if (residentDict ["jury"].ToString () == "YES") {
						juryDuty.Checked = true;
						//Jury = "YES";
					} else {
						juryDuty.Checked = false;
						//Jury = "NO";
					}
					juryDuty.CheckedChange += (object sender, CompoundButton.CheckedChangeEventArgs e) => {
						checkJuryDuty (juryDuty);
					};
					//residentUpdate[i].Add ("jury");

					TableRow.LayoutParams stretchRow = new TableRow.LayoutParams();
					stretchRow.Width = (int) (10 * density1);


					tr.AddView (itr,stretchRow);
					tr.AddView (name);
					tr.AddView (nationality);
					tr.AddView (optOut);
					tr.AddView (absentVote);
					tr.AddView (juryDuty);
					tl.AddView (tr);
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

				addITR (tl);
			}
		}

		public void nameCorrect(TextView name){
			//Console.WriteLine (name.Tag);

			//			//set alert for executing the task
			//			AlertDialog.Builder alert = new AlertDialog.Builder (Activity);
			//
			//			alert.SetTitle ("Is name correct?");
			//
			//			alert.SetMessage ("Current Name: " + name.Text);
			//
			//			alert.SetPositiveButton ("Yes", (senderAlert, args) => {
			//				//change value write your own set of instructions
			//				//you can also create an event for the same in xamarin
			//				//instead of writing things here
			//			} );
			//
			//			alert.SetNegativeButton ("No", (senderAlert, args) => {
			//				//perform your own task for this conditional button click
			//			} );
			//			//run the alert in UI thread to display in the screen
			//			Activity.RunOnUiThread (() => {
			//				alert.Show();
			//			} );
		}

		public void nationalityCorrect (TextView nationality)
		{
			//			Console.WriteLine ("nationality: " + nationality.Tag);
			//
			//			//set alert for executing the task
			//			AlertDialog.Builder alert = new AlertDialog.Builder (Activity);
			//
			//			alert.SetTitle ("Is nationality correct?");
			//
			//			alert.SetMessage ("Current Nationality: " + nationality.Text);
			//
			//			alert.SetPositiveButton ("Yes", (senderAlert, args) => {
			//				//change value write your own set of instructions
			//				//you can also create an event for the same in xamarin
			//				//instead of writing things here
			//			} );
			//
			//			alert.SetNegativeButton ("No", (senderAlert, args) => {
			//				//perform your own task for this conditional button click
			//			} );
			//			//run the alert in UI thread to display in the screen
			//			Activity.RunOnUiThread (() => {
			//				alert.Show();
			//			} );
		}

		public string checkOptOut (CheckBox optOut)
		{
			int index = Convert.ToInt32 (optOut.Tag.ToString ());
			string residentID = "";
			currResident = residents [index];
			string OptOut = "";
			if (optOut.Checked) {
				residentID = currResident ["id"].ToString ();
				OptOut = "YES";
				currResident ["optOut"] = OptOut;
				residents [index] = currResident;
				TableRow tr = (TableRow)View.FindViewWithTag (residentID);
				tr.SetBackgroundColor (Resources.GetColor (Resource.Color.highlight));
			} else {
				residentID = currResident ["id"].ToString ();
				OptOut = "NO";
				currResident ["optOut"] = OptOut;
				residents [index] = currResident;
				TableRow tr = (TableRow)View.FindViewWithTag (residentID);
				tr.SetBackgroundColor (Resources.GetColor (Resource.Color.highlight));
			}

			//Console.WriteLine ("optOut: " + optOut.Tag);
			return OptOut;
		}

		public String checkAbsentVote (CheckBox absentVote)
		{
			int index = Convert.ToInt32 (absentVote.Tag.ToString ());
			currResident = residents [index];
			string AbsentVote = "";
			string residentID = "";
			if (absentVote.Checked) {
				residentID = currResident ["id"].ToString ();
				AbsentVote = "YES";
				currResident ["absent"] = AbsentVote;
				residents [index] = currResident;
				TableRow tr = (TableRow)View.FindViewWithTag (residentID);
				tr.SetBackgroundColor (Resources.GetColor (Resource.Color.highlight));
			} else {
				residentID = currResident ["id"].ToString ();
				AbsentVote = "NO";
				currResident ["absent"] = AbsentVote;
				residents [index] = currResident;
				TableRow tr = (TableRow)View.FindViewWithTag (residentID);
				tr.SetBackgroundColor (Resources.GetColor (Resource.Color.highlight));
			}
			//Console.WriteLine ("Derelict: " + absentVote.Tag);
			return AbsentVote;
		}

		public string checkJuryDuty (CheckBox juryDuty)
		{
			int index = Convert.ToInt32 (juryDuty.Tag.ToString ());
			currResident = residents [index];
			string jury = "";
			string residentID = "";
			if (juryDuty.Checked) {
				residentID = currResident ["id"].ToString ();
				jury = "YES";
				currResident ["jury"] = jury;
				residents [index] = currResident;
				TableRow tr = (TableRow)View.FindViewWithTag (residentID);
				tr.SetBackgroundColor (Resources.GetColor (Resource.Color.highlight));
			} else {
				residentID = currResident ["id"].ToString ();
				jury = "NO";
				currResident ["jury"] = jury;
				residents [index] = currResident;
				TableRow tr = (TableRow)View.FindViewWithTag (residentID);
				tr.SetBackgroundColor (Resources.GetColor (Resource.Color.highlight));
			}
			//Console.WriteLine ("Postal Request: " + juryDuty.Tag);
			return jury;
		}

		public override void OnCreateOptionsMenu(IMenu menu, MenuInflater inflater)
		{
			inflater.Inflate(Resource.Menu.residentsMenu, menu);
			IMenuItem emailDisplay = menu.FindItem (Resource.Id.menu_email);
			emailDisplay.SetTitle (DataController.userEmail);
			IMenuItem addressDisplay = menu.FindItem (Resource.Id.menu_address);
			String[] parts = new string[1];
			if (DataController.address.Contains (",")) {
				parts = DataController.address.Split (',');
				addressDisplay.SetTitle (parts [0] + "," + parts [1]);
			} else {
				addressDisplay.SetTitle (DataController.address);
			}

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

			case Resource.Id.menu_confirm:
				//Console.WriteLine ("Confirmed!");
				AlertDialog.Builder alert = new AlertDialog.Builder (Activity);

				alert.SetTitle ("Are you sure you want to confirm?");
				alert.SetMessage ("Confirming will remove property upon refresh ");

				alert.SetPositiveButton ("Yes", (senderAlert, args) => {

					try
					{
						updateResidents();
					}
					catch(Exception ex)
					{
						//Console.WriteLine("Exception :::::" + ex.ToString());
					}



					//removeFragment();
					//change value write your own set of instructions
					//you can also create an event for the same in xamarin
					//instead of writing things here
				} );

				alert.SetNegativeButton ("No", (senderAlert, args) => {
					//perform your own task for this conditional button click
				} );
				//run the alert in UI thread to display in the screen
				Activity.RunOnUiThread (() => {
					alert.Show();
				} );

				//OnAlertYesNoClicked (sender, e);
				if (checkNetwork()) {
					DataController.propertyChange = true;
					//updateResidents ();
				} else {
					showNetworkError ();
				}
				return true;
			case Resource.Id.menu_address:
				removeFragment ();
				return true;	
			case Resource.Id.menu_reset:
				if (checkNetwork()) {
					DataController.propertyReset = true;
					removeFragment ();
				} else {
					showNetworkError ();
				}
				return true;
			}
			return base.OnOptionsItemSelected(item);
		}

		public void updateResidents(){

			for(int i = 0; i < residents.Count; i++){

				Dictionary<string, object> residentDict = new Dictionary<string, object> ();
				//Dictionary<string, object> residentDictUpdate = new Dictionary<string, object> ();

				residentDict = residents[i];
				//residentDictUpdate = residentUpdate [i];
				string nationality = residentDict ["nationality"].ToString ();
				//residentDictUpdate[i].Add ("nationality", nationality);
				string optOut = residentDict ["optOut"].ToString ();
				//residentDictUpdate[i].Add ("optOut", optOut);
				string jury = residentDict ["jury"].ToString ();
				//residentDictUpdate[i].Add ("jury", jury);
				string absent = residentDict ["absent"].ToString ();
				//residentDictUpdate[i].Add ("absent", absent);
				string residentID = residentDict ["id"].ToString ();
				//residentDictUpdate[i].Add ("id", residentID);
				//residentUpdate.Add (residentDictUpdate[i]);

				String response=NetworkCalls.updateResidents (nationality, optOut, jury, absent, residentID, DataController.token, DataController.uprn);
				if(response!=null){
					Toast newProperties = new Toast (this.Activity);
					newProperties = Toast.MakeText (Activity.ApplicationContext,"Property confirmed", ToastLength.Long);
					newProperties.Show ();
				}
			}

			NetworkCalls.updatePropertyNote (DataController.uprn, RemoveSpecialCharacters(note.Text), DataController.token);
			propertyDict = addresses [DataController.propertyToChange];
			propertyDict ["notes"] = RemoveSpecialCharacters(note.Text);
			addresses [DataController.propertyToChange] = propertyDict;

			removeFragment ();
		}

		public void removeFragment(){

			//			Android.Support.V4.App.Fragment canvassesFragment = null;
			//			canvassesFragment = new CanvassesFragment ();
			//
			//			Android.Support.V4.App.FragmentTransaction ft = FragmentManager.BeginTransaction ();
			//			ft.Replace (Resource.Id.content_frame, canvassesFragment, "canvassesFragment");
			//			ft.Commit ();

			try
			{
				Android.Support.V4.App.FragmentTransaction ft = FragmentManager.BeginTransaction ();
				ft.Remove (this);
				ft.Show (FragmentManager.FindFragmentByTag ("canvassesFragment"));
				ft.Commit ();
			}

			catch(Exception ex) 
			{
				//Console.WriteLine ("Ex From REEEEEEEEEPREEEEEEEEFRAG" + ex.ToString());
			}

		}

		public void addITR(TableLayout tl){

			TableRow notes =  new TableRow(this.Activity);
			notes.Tag = "notes";
			note = new EditText (this.Activity);
			note.Hint = "Notes";
			if (DataController.note != "") {
				note.Text = DataController.note;
			}
			note.Gravity = GravityFlags.Center;

			TableRow.LayoutParams stretchRow = new TableRow.LayoutParams();
			stretchRow.Span = 6;

			notes.AddView(note, stretchRow);
			tl.AddView (notes);

			TableRow btnRow =  new TableRow(this.Activity);
			btnRow.Tag = "btnRow";

			Button requestITR = new Button(this.Activity);
			requestITR.Text = "ITR";
			requestITR.Click += (object sender, EventArgs e) => {

				if (checkNetwork ()) {

					Android.Support.V4.App.Fragment residentsFragment = null;
					residentsFragment = new ResidentsFragment ();
					((ResidentsFragment)residentsFragment).SetResidentUpdate(residents);
					((ResidentsFragment)residentsFragment).SetNotePrev(note.Text);
					Android.Support.V4.App.FragmentTransaction ft = FragmentManager.BeginTransaction ();

					ft.Add (Resource.Id.content_frame, residentsFragment, "residentsFragment");
					ft.Hide (FragmentManager.FindFragmentByTag ("residentsPrevFragment"));
					ft.AddToBackStack(null);
					ft.Commit ();


				} else {
					showNetworkError ();
				}


			};



			btnRow.AddView (requestITR, stretchRow);
			tl.AddView (btnRow);
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

		public static string RemoveSpecialCharacters(string str) {
			StringBuilder sb = new StringBuilder ();
			//Console.WriteLine ("StringBuilder " + str);
			foreach (char c in str) {
				if ((c >= '0' && c <= '9') || (c >= 'A' && c <= 'Z') || (c >= 'a' && c <= 'z') || c == '.' || c == '_' || c == '@' || c == ' ' || c == '-') {
					sb.Append (c);
				}
			}
			return sb.ToString ();
		}
	}
}

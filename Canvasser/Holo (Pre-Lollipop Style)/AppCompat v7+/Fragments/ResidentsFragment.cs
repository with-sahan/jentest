
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
using Newtonsoft.Json;



namespace NavDrawer.Fragments
{	
	public class ResidentsFragment : Fragment
	{

		public List<Dictionary<string, object>> residents = new List<Dictionary<string, object>>();
		public Dictionary<string, object> currResident = new Dictionary<string, object> ();

		public List<Dictionary<string, object>> addresses = new List<Dictionary<string, object>>();
		public List<Dictionary<string, object>> residentUpdate = new List<Dictionary<string, object>>();
		public Dictionary<string, object> propertyDict = new Dictionary<string, object> ();

		public List<Dictionary<string, object>> newPersons = new List<Dictionary<string, object>>();
		//MockingController mockingController = new MockingController ();
		public Dictionary<string, ITRChanges> itrNameChanges;

		public EditText note;
		private RadioGroup ItrTypeGroup;
		private RadioButton itrType;
		private string notePrev;

		ConnectivityManager cm;

		public ResidentsFragment()
		{	
			this.RetainInstance = true;
			this.HasOptionsMenu = (true);
			itrNameChanges = new Dictionary<string, ITRChanges> ();
		}

		public void SetNotePrev(string notePrev)
		{
			this.notePrev = notePrev;
		}

		public void SetResidentUpdate(List<Dictionary<string, object>> residentUpdate )
		{
			this.residentUpdate= residentUpdate;

		}

		public override Android.Views.View OnCreateView(Android.Views.LayoutInflater inflater, Android.Views.ViewGroup container, Android.OS.Bundle savedInstanceState)
		{

			var ignored = base.OnCreateView(inflater, container, savedInstanceState);
			var view = inflater.Inflate(Resource.Layout.fragments_itr_residents, null);

			cm = (ConnectivityManager)Activity.GetSystemService(Context.ConnectivityService);

			//			TextView locationText = (TextView)view.FindViewById (Resource.Id.locations);
			//			locationText.Text = "Latitude " + DataController.lat + " Longitude " + DataController.lng;
			if(checkNetwork()){
				drawTable (view,inflater);
			} else{
				showNetworkError();
			}

			return view;
		}
		public void drawTable(View view, Android.Views.LayoutInflater inflater){

			//Console.WriteLine ("In drawable");
			string canvass = NetworkCalls.getJobs (DataController.token);

			string response = NetworkCalls.getProperties (DataController.token);
			addresses = DataController.addresses;
			string responseResident = NetworkCalls.getResidents (DataController.token, DataController.canvassID, DataController.uprn);
			residents = DataController.residents;

			TableLayout tl = (TableLayout)view.FindViewById (Resource.Id.residentstable);
			TableLayout tb = (TableLayout)view.FindViewById(Resource.Id.tableHeaders);
			ScrollView ts = (ScrollView)view.FindViewById (Resource.Id.tableScroll);
			//Console.WriteLine ("After table");

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
			heading1.SetWidth((int)(350 * density));

			TextView heading2 = new TextView (this.Activity);
			heading2.Text = "Responder";
			heading2.SetTextColor (Resources.GetColor (Resource.Color.odd));
			heading2.TextSize = 15.0f;
			TextView heading3 = new TextView (this.Activity);
			heading3.Text = "Encourage";
			heading3.SetTextColor (Resources.GetColor (Resource.Color.odd));
			heading3.TextSize = 15.0f;
			TextView heading4 = new TextView (this.Activity);
			heading4.Text = "Online Reg";
			heading4.SetTextColor (Resources.GetColor (Resource.Color.odd));
			heading4.TextSize = 15.0f;

			/*@@@@@@@@@@@@@@@modified@@@@@@@@@@@@@@
				TextView heading5 = new TextView (this.Activity);
				heading5.Text = "Jury Duty";
				heading5.SetTextColor (Resources.GetColor (Resource.Color.odd));
				heading5.TextSize = 20.0f;*/
			//			TextView heading6 = new TextView(this.Activity);
			//			heading6.Text = "Residents";

			headings.AddView (heading0);
			headings.AddView (heading1);
			headings.AddView (heading2);
			headings.AddView (heading3);
			headings.AddView (heading4);
			//headings.AddView (heading5);
			//headings.AddView(heading6);
			tl.AddView (headings);

			//			for(int i = 0; i < 10; i++){
			//				TableRow tr =  new TableRow(this.Activity);
			//				tr.Tag = i;
			//				TextView address = new TextView(this.Activity);
			//				address.Text = "30, Basegreen Drive, Sheffield, S12 3FF";
			//				address.Tag = "address" + i;
			//				address.Click += (object sender, EventArgs e) => 
			//				{
			//					addressCorrect(address);
			//				};
			//				CheckBox noAnswer = new CheckBox(this.Activity);
			//				noAnswer.Tag = "noAnswer" + i;
			//				noAnswer.CheckedChange += (object sender, CompoundButton.CheckedChangeEventArgs e) => 
			//				{
			//					checkNoAnswer(noAnswer);
			//				};
			//				CheckBox empty = new CheckBox(this.Activity);
			//				empty.Tag = "empty" + i;
			//				empty.CheckedChange += (object sender, CompoundButton.CheckedChangeEventArgs e) => 
			//				{
			//					checkEmpty(empty);
			//				};
			//				CheckBox derelict = new CheckBox(this.Activity);
			//				derelict.Tag = "derelict" + i;
			//				derelict.CheckedChange += (object sender, CompoundButton.CheckedChangeEventArgs e) => 
			//				{
			//					checkDerelict(derelict);
			//				};
			//				CheckBox postalRequest = new CheckBox(this.Activity);
			//				postalRequest.Tag = "postalRequest" + i;
			//				postalRequest.CheckedChange += (object sender, CompoundButton.CheckedChangeEventArgs e) => 
			//				{
			//					checkRequestPostal(postalRequest);
			//				};
			//				Button residents = new Button (this.Activity);
			//				residents.Text = "Residents";
			//				residents.Tag = "residents" + i;
			//				residents.Click += (object sender, EventArgs e) => 
			//				{
			//					showResidents(residents);
			//				};
			//		
			//				tr.AddView(address);
			//				tr.AddView(noAnswer);
			//				tr.AddView(empty);
			//				tr.AddView(derelict);
			//				tr.AddView(postalRequest);
			//				tr.AddView(residents);
			//				tl.AddView(tr);
			//			}
			//Console.WriteLine("table layout");
			for (int i = 0; i < residents.Count; i++) {

				Dictionary<string, object> residentDict = new Dictionary<string, object> ();

				residentDict = residents [i];
				//Console.WriteLine ("inside for loop");
				TableRow tr = new TableRow (this.Activity);
				//Console.WriteLine ("table Row");

				if (i % 2 == 0) {
					tr.SetBackgroundColor (Resources.GetColor (Resource.Color.even));
					//Console.WriteLine ("background color even");
				} else {
					tr.SetBackgroundColor (Resources.GetColor (Resource.Color.odd));
					//Console.WriteLine ("background color odd");
				}
				//Console.WriteLine ("after if");
				tr.Tag = residentDict ["id"].ToString ();
				string clickId = residentDict ["id"].ToString ();
				tr.Id = i;
				TextView name = new TextView (this.Activity);
				name.Text = " " + residentDict ["fullName"].ToString ();
				float density1 = this.Activity.Resources.DisplayMetrics.Density;
				name.SetWidth((int)(350 * density1));
				name.SetPadding (5, 5, 0, 5);

				name.Tag = "name" + i;
				name.TextSize = 18.0f;
				name.SetTextColor (Resources.GetColor (Resource.Color.tableText));
				//Console.WriteLine ("residentDict");
				name.Click += (object sender, EventArgs e) => {
					//string responseResidentNew = NetworkCalls.getResidents (DataController.token, DataController.canvassID, DataController.uprn);
					residentEdit (clickId, tl, inflater,name,residentDict);
					string responseResidentNew = NetworkCalls.getResidents (DataController.token, DataController.canvassID, DataController.uprn);

				};
				//Console.WriteLine ("nameclick");
				/*TextView responder = new TextView (this.Activity);
					responder.Text = residentDict ["responder"].ToString ();
					responder.Tag = i;
					responder.TextSize = 18.0f;
					responder.SetTextColor (Resources.GetColor (Resource.Color.tableText));
					responder.Click += (object sender, EventArgs e) => {
						responderCorrect (responder);
					};*/

				ImageButton itr = new ImageButton (this.Activity);


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

				CheckBox responder = new CheckBox (this.Activity);
				//Console.WriteLine ("RESPONDER");
				responder.Tag = i;
				//Console.WriteLine ("RESPONDER Value"+residentDict ["responder"].ToString ());
				if (residentDict ["responder"] !=null && residentDict ["responder"].ToString () == "YES") {
					responder.Checked = true;
					//Console.WriteLine ("RESPONDER yes");
				} else {
					responder.Checked = false;
				}
				responder.CheckedChange += (object sender, CompoundButton.CheckedChangeEventArgs e) => {
					//Console.WriteLine ("RESPONDER checked");
					checkResponder (responder);
				};

				//@@@@@@@@@@@@@@@@@@@@@@@@@


				CheckBox encourage = new CheckBox (this.Activity);
				encourage.Tag = i;
				if (residentDict ["encourage"]!=null && residentDict ["encourage"].ToString () == "YES") {
					encourage.Checked = true;
				} else {
					encourage.Checked = false;
				}
				encourage.CheckedChange += (object sender, CompoundButton.CheckedChangeEventArgs e) => {
					checkEncourage (encourage);
				};

				CheckBox onlineReg = new CheckBox (this.Activity);
				onlineReg.Tag = i;
				//Console.WriteLine ("ONLINE REG");
				if (residentDict ["onlineReg"] !=null && residentDict["onlineReg"].ToString () == "YES") {
					onlineReg.Checked = true;
					//Console.WriteLine ("ONLINEREG yes");
				} else {
					onlineReg.Checked = false;
				}
				onlineReg.CheckedChange += (object sender, CompoundButton.CheckedChangeEventArgs e) => {
					checkOnlineReg (onlineReg);
					//Console.WriteLine ("ENCOURAGE checked");
				};
				//TableRow.LayoutParams stretchRow = new TableRow.LayoutParams();
				//stretchRow.Width = (int) (10 * density1);

				tr.AddView (itr);
				tr.AddView (name);
				tr.AddView (responder);
				tr.AddView (encourage);
				tr.AddView (onlineReg);
				//Console.WriteLine ("add view");
				//tr.AddView (juryDuty);
				tl.AddView (tr);
				//Console.WriteLine ("add view row");

			}
			View headers = tl.FindViewWithTag ("headers");
			//Console.WriteLine ("headers view");
			tl.RemoveView (tl.FindViewWithTag ("headers"));
			tb.RemoveAllViews ();
			//Console.WriteLine ("Remove Views");
			//					//tb.RemoveView (tl);
			tb.AddView (headers);
			tb.StretchAllColumns = true;
			ts.RemoveAllViews ();
			//Console.WriteLine ("RemoveAllViews");
			ts.AddView (tl);
			tb.AddView(ts);
			//Console.WriteLine ("RemoveTB");
			addPerson (tl,inflater);
			//Console.WriteLine ("After add person");
			//			TableRow notes =  new TableRow(this.Activity);
			//			notes.Tag = "notes";
			//			note = new EditText (this.Activity);
			//			note.Hint = "Notes";
			//			note.Gravity = GravityFlags.Center;
			//
			//			TableRow.LayoutParams stretchRow = new TableRow.LayoutParams();
			//			stretchRow.Span = 6;
			//			
			//
			//			notes.AddView(note, stretchRow);
			//			tl.AddView (notes);
			//
			//			TableRow btnRow =  new TableRow(this.Activity);
			//			btnRow.Tag = "btnRow";
			//
			//			Button requestITR = new Button(this.Activity);
			//			requestITR.Text = "Request ITR";
			//			requestITR.Click += (object sender, EventArgs e) => {
			//
			//				LayoutInflater viewInflater = this.Activity.LayoutInflater;
			//				var myCustomAlert = inflater.Inflate(Resource.Layout.RequestITR, null);
			//
			//				EditText firstname = (EditText)myCustomAlert.FindViewById(Resource.Id.firstnameEdit);
			//				EditText surname = (EditText)myCustomAlert.FindViewById(Resource.Id.surnameEdit);
			//				//set alert for executing the task
			//				AlertDialog.Builder alert = new AlertDialog.Builder (Activity);
			//
			//				alert.SetTitle ("Request ITR");
			//
			//				alert.SetView(myCustomAlert);
			//
			//				alert.SetPositiveButton ("Confirm", (senderAlert, args) => {
			//					//change value write your own set of instructions
			//					//you can also create an event for the same in xamarin
			//					//instead of writing things here
			//					//Console.WriteLine(firstname.Text);
			//					string fullname = firstname.Text.ToString() + " " + surname.Text.ToString();
			//					NetworkCalls.requestITR(DataController.uprn, DataController.houseID, fullname, DataController.canvassID, "ITR", DataController.token);
			//
			//					tl.RemoveView (tl.FindViewWithTag ("notes"));
			//					tl.RemoveView (tl.FindViewWithTag ("btnRow"));
			//
			//					TableRow tr = new TableRow(this.Activity);
			//					TextView name = new TextView(this.Activity);
			//					name.Text = fullname;
			//					name.TextSize = 18.0f;
			//					name.SetTextColor (Resources.GetColor (Resource.Color.tableText));
			//
			//					TextView nationality = new TextView(this.Activity);
			//					nationality.Text = "ITR";
			//					nationality.TextSize = 18.0f;
			//					nationality.SetTextColor (Resources.GetColor (Resource.Color.tableText));
			//
			////					note.Text = note.Text + " ITR Requested for: " + firstname.Text.ToString() + " " + surname.Text.ToString() + ",";
			//
			//				});
			//
			//				alert.SetNegativeButton ("Cancel", (senderAlert, args) => {
			//					//perform your own task for this conditional button click
			//
			//				} );
			//				//run the alert in UI thread to display in the screen
			//				Activity.RunOnUiThread (() => {
			//					alert.Show();
			//				} );
			//
			//			};
			//				
			//			btnRow.AddView (requestITR, stretchRow);
			//			tl.AddView (btnRow);

			//Console.WriteLine ("Saved state"+savedInstanceState);
			//return view;
		}

		public void residentEdit(string clickId, TableLayout tl, LayoutInflater inflater, TextView name,Dictionary<string, object> residentDict ){

			try
			{
				//Console.WriteLine ("clickID"+clickId);
				string firstNameNew, surNameNew, fullname;
				LayoutInflater viewInflater = this.Activity.LayoutInflater;
				//Console.WriteLine ("stuck here");
				var myCustomAlert = inflater.Inflate(Resource.Layout.edit_resident, null);
				//Console.WriteLine ("layout");

				EditText firstname = (EditText)myCustomAlert.FindViewById(Resource.Id.firstnameEdit1);
				EditText surname = (EditText)myCustomAlert.FindViewById(Resource.Id.surnameEdit1);
				//firstname.Text=residentDict ["firstname"].ToString ();
				//Console.WriteLine ("before get new names");

				if(itrNameChanges.ContainsKey(clickId)){


					var itrChanges = itrNameChanges[clickId];
					firstname.Text = itrChanges.NewItrFirstName;
					surname.Text = itrChanges.NewItrSureName;

					var checkBoxType = itrChanges.CheckBoxType;

					RadioButton nameChange1=(RadioButton)myCustomAlert.FindViewById(Resource.Id.radioNameChange);
					RadioButton deceased1=(RadioButton)myCustomAlert.FindViewById(Resource.Id.radioDeceased);
					RadioButton moved1=(RadioButton)myCustomAlert.FindViewById(Resource.Id.radioMoved);
					nameChange1.Checked = false;
					deceased1.Checked = false;
					moved1.Checked = false;

					if(checkBoxType.Equals("ER_NC")){
						nameChange1.Checked = true;
					}
					else if(checkBoxType.Equals("ER_D")){
						deceased1.Checked = true;
					}
					else if(checkBoxType.Equals("ER_M")){
						moved1.Checked = true;
					}
				}

				else
				{
					if (residentDict.ContainsKey("itr_firstNames") && residentDict ["itr_firstNames"] != null && residentDict.ContainsKey("itr_status") && residentDict ["itr_status"].ToString ().Equals("ER_NC")) {
						//Console.WriteLine ("before get new names ....");
						firstname.Text = residentDict ["itr_firstNames"].ToString ();
						firstNameNew= residentDict ["itr_firstNames"].ToString ();

					}
					else {
						firstname.Text = residentDict ["firstNames"].ToString ();
						firstNameNew=firstname.Text.ToString ();
						//firstname.Text = residentDict ["itr_firstNames"].ToString ();
					}

					//Console.WriteLine ("before get new names @@@@");

					String firstnameEdit = firstname.Text.ToString();

					if(residentDict.ContainsKey("itr_surname") && residentDict ["itr_surname"]!=null && residentDict.ContainsKey("itr_status") && residentDict ["itr_status"].ToString ().Equals("ER_NC")){
						surname.Text=residentDict ["itr_surname"].ToString ();
						surNameNew= residentDict ["itr_surname"].ToString ();
					}
					else {
						surname.Text = residentDict ["surname"].ToString ();
						surNameNew = surname.Text.ToString ();
					}

					String surnameEdit = surname.Text.ToString ();
					//Console.WriteLine ("Editing");
					//string fullname = RemoveSpecialCharacters(firstname.Text.ToString() + " " + surname.Text.ToString());
					//ItrTypeGroup = (RadioGroup)myCustomAlert.FindViewById(Resource.Id.itrType);
					RadioButton nameChange=(RadioButton)myCustomAlert.FindViewById(Resource.Id.radioNameChange);
					RadioButton deceased=(RadioButton)myCustomAlert.FindViewById(Resource.Id.radioDeceased);
					RadioButton moved=(RadioButton)myCustomAlert.FindViewById(Resource.Id.radioMoved);
					if(residentDict.ContainsKey("itr_status") && residentDict ["itr_status"]!=null && residentDict ["itr_status"].ToString ().Equals("ER_NC")){
						nameChange.Checked = true;
						deceased.Checked = false;
						moved.Checked = false;
					}
					else
						if(residentDict.ContainsKey("itr_status") && residentDict ["itr_status"]!=null && residentDict ["itr_status"].ToString ().Equals("ER_D")){
							nameChange.Checked = false;
							deceased.Checked = true;
							moved.Checked = false;
						}
						else if(residentDict.ContainsKey("itr_status") && residentDict ["itr_status"]!=null && residentDict ["itr_status"].ToString ().Equals("ER_M")){
							nameChange.Checked = false;
							deceased.Checked = false;
							moved.Checked = true;
						}
						else{
							nameChange.Checked = false;
							deceased.Checked = false;
							moved.Checked = false;
						}







				}



				//set alert for executing the task
				AlertDialog.Builder alert = new AlertDialog.Builder (Activity);

				//alert.SetTitle ("Request ITR");

				alert.SetView(myCustomAlert);
				//Console.WriteLine ("Before the submission");
				alert.SetPositiveButton ("Submit", (senderAlert, args) => 
					{

						//Console.WriteLine("in submit");
						//return true;
						//change value write your own set of instructions
						//you can also create an event for the same in xamarin
						//instead of writing things here
						if(checkNetwork()){
							ItrTypeGroup = (RadioGroup)myCustomAlert.FindViewById(Resource.Id.itrType);
							int selectedId = ItrTypeGroup.CheckedRadioButtonId;

							// find the radiobutton by returned id
							itrType = (RadioButton)myCustomAlert.FindViewById(selectedId);

							string  fName = firstname.Text.ToString();
							string  sName = surname.Text.ToString();

							if(itrType == null || itrType.Tag == null)
							{
								Toast newProperties = new Toast (this.Activity);
								newProperties = Toast.MakeText (Activity.ApplicationContext,"Please specify ITR type", ToastLength.Short);
								newProperties.Show ();
								return;
							}


							string type = itrType.Tag.ToString();

							if(string.IsNullOrWhiteSpace(fName) || string.IsNullOrWhiteSpace(sName) || string.IsNullOrWhiteSpace(type) )
							{
								Toast newProperties = new Toast (this.Activity);
								newProperties = Toast.MakeText (Activity.ApplicationContext,"Please fill out mandatory fields", ToastLength.Short);
								newProperties.Show ();
								return;
							}

							fullname = fName + " " + sName;

							if(type.Equals("ER_NC")){
								if(itrNameChanges.ContainsKey(clickId)){
									itrNameChanges[clickId] = new ITRChanges(){
										IsNameChanged=true,
										NewItrFirstName = fName,
										NewItrSureName = sName,
										CheckBoxType = type
									};
								}
								else
									itrNameChanges.Add(clickId, new ITRChanges(){
										IsNameChanged=false,
										NewItrFirstName = fName,
										NewItrSureName = sName,
										CheckBoxType= type
									});
							}
							else{
								if(itrNameChanges.ContainsKey(clickId)){
									itrNameChanges[clickId] = new ITRChanges(){
										IsNameChanged=false,
										NewItrFirstName = residentDict ["firstNames"].ToString(),
										NewItrSureName = residentDict ["surname"].ToString(),
										CheckBoxType= type
									};
								}
								else
									itrNameChanges.Add(clickId, new ITRChanges(){
										IsNameChanged=false,
										NewItrFirstName = residentDict ["firstNames"].ToString(),
										NewItrSureName = residentDict ["surname"].ToString(),
										CheckBoxType= type
									});
							}

							string response=NetworkCalls.updateResidentsFlag(fName,sName,fullname,type,clickId,DataController.token, DataController.uprn);
							string responseResident = NetworkCalls.getResidents (DataController.token, DataController.canvassID, DataController.uprn);	
						}
						else{
							showNetworkError();

						}



					});

				alert.SetNegativeButton ("Cancel", (senderAlert, args) => {
					//perform your own task for this conditional button click
				} );

				//run the alert in UI thread to display in the screen
				Activity.RunOnUiThread (() => {
					alert.Show();
				} );

			}
			catch(Exception ex){
				Toast noNetwork = new Toast (this.Activity);
				noNetwork = Toast.MakeText (Activity.ApplicationContext, "Please select the status type to proceed", ToastLength.Short);
				noNetwork.Show ();
				//Console.WriteLine (ex.Message);
				//Console.WriteLine ("|||||||||||||||||"+ex.StackTrace);
			}
		}

		public void checkResponder (CheckBox responder)
		{
			int index = Convert.ToInt32 (responder.Tag.ToString ());
			string residentID = "";
			currResident = residents [index];
			string Responder = "";
			if (responder.Checked) {
				residentID = currResident ["id"].ToString ();
				Responder = "YES";
				currResident ["responder"] = Responder;
				residents [index] = currResident;
				TableRow tr = (TableRow)View.FindViewWithTag (residentID);
				tr.SetBackgroundColor (Resources.GetColor (Resource.Color.highlight));
			} else {
				residentID = currResident ["id"].ToString ();
				Responder = "NO";
				currResident ["responder"] = Responder;
				residents [index] = currResident;
				TableRow tr = (TableRow)View.FindViewWithTag (residentID);
				tr.SetBackgroundColor (Resources.GetColor (Resource.Color.highlight));
			}
			//Console.WriteLine ("responder: " + responder.Tag);
		}

		public void checkEncourage (CheckBox encourage)
		{
			int index = Convert.ToInt32 (encourage.Tag.ToString ());
			currResident = residents [index];
			string Encourage = "";
			string residentID = "";
			if (encourage.Checked) {
				residentID = currResident ["id"].ToString ();
				Encourage = "YES";

				currResident ["encourage"] = Encourage;
				residents [index] = currResident;
				TableRow tr = (TableRow)View.FindViewWithTag (residentID);
				tr.SetBackgroundColor (Resources.GetColor (Resource.Color.highlight));
			} else {
				residentID = currResident ["id"].ToString ();
				Encourage = "NO";
				currResident ["encourage"] = Encourage;
				residents [index] = currResident;
				TableRow tr = (TableRow)View.FindViewWithTag (residentID);
				tr.SetBackgroundColor (Resources.GetColor (Resource.Color.highlight));
			}
			//Console.WriteLine ("Encourage: " + encourage.Tag);
		}

		public void checkOnlineReg (CheckBox onlineReg)
		{
			int index = Convert.ToInt32 (onlineReg.Tag.ToString ());
			currResident = residents [index];
			string OnlineReg = "";
			string residentID = "";
			if (onlineReg.Checked) {
				residentID = currResident ["id"].ToString ();
				OnlineReg = "YES";
				currResident ["onlineReg"] = OnlineReg;
				residents [index] = currResident;
				TableRow tr = (TableRow)View.FindViewWithTag (residentID);
				tr.SetBackgroundColor (Resources.GetColor (Resource.Color.highlight));
			} else {
				residentID = currResident ["id"].ToString ();
				OnlineReg = "NO";
				currResident ["onlineReg"] = OnlineReg;
				residents [index] = currResident;
				TableRow tr = (TableRow)View.FindViewWithTag (residentID);
				tr.SetBackgroundColor (Resources.GetColor (Resource.Color.highlight));
			}
			//Console.WriteLine ("Postal Request: " + onlineReg.Tag);
		}


		public void checkResponderNew (CheckBox responder)
		{
			int index = Convert.ToInt32 (responder.Tag.ToString ());



			string residentID = "";
			currResident = newPersons [index];
			string Responder = "";
			if (responder.Checked) {
				residentID = currResident ["id"].ToString ();

				Responder = "YES";
				currResident ["responder"] = Responder;
				newPersons [index] = currResident;
				TableRow tr = (TableRow)View.FindViewWithTag (residentID);
				tr.SetBackgroundColor (Resources.GetColor (Resource.Color.highlight));
			} else {
				residentID = currResident ["id"].ToString ();
				Responder = "NO";
				currResident ["responder"] = Responder;
				newPersons [index] = currResident;
				TableRow tr = (TableRow)View.FindViewWithTag (residentID);
				tr.SetBackgroundColor (Resources.GetColor (Resource.Color.highlight));
			}
			//Console.WriteLine ("responder: " + responder.Tag);
		}

		public void checkEncourageNew (CheckBox encourage)
		{
			int index = Convert.ToInt32 (encourage.Tag.ToString ());
			currResident = newPersons [index];
			string Encourage = "";
			string residentID = "";
			if (encourage.Checked) {
				residentID = currResident ["id"].ToString ();
				Encourage = "YES";

				currResident ["encourage"] = Encourage;
				newPersons [index] = currResident;
				TableRow tr = (TableRow)View.FindViewWithTag (residentID);
				tr.SetBackgroundColor (Resources.GetColor (Resource.Color.highlight));
			} else {
				residentID = currResident ["id"].ToString ();
				Encourage = "NO";
				currResident ["encourage"] = Encourage;
				residents [index] = currResident;
				TableRow tr = (TableRow)View.FindViewWithTag (residentID);
				tr.SetBackgroundColor (Resources.GetColor (Resource.Color.highlight));
			}
			//Console.WriteLine ("Encourage: " + encourage.Tag);
		}

		public void checkOnlineRegNew (CheckBox onlineReg)
		{
			int index = Convert.ToInt32 (onlineReg.Tag.ToString ());
			currResident = newPersons [index];
			string OnlineReg = "";
			string residentID = "";
			if (onlineReg.Checked) {
				residentID = currResident ["id"].ToString ();
				OnlineReg = "YES";
				currResident ["onlineReg"] = OnlineReg;
				newPersons [index] = currResident;
				TableRow tr = (TableRow)View.FindViewWithTag (residentID);
				tr.SetBackgroundColor (Resources.GetColor (Resource.Color.highlight));
			} else {
				residentID = currResident ["id"].ToString ();
				OnlineReg = "NO";
				currResident ["onlineReg"] = OnlineReg;
				newPersons [index] = currResident;
				TableRow tr = (TableRow)View.FindViewWithTag (residentID);
				tr.SetBackgroundColor (Resources.GetColor (Resource.Color.highlight));
			}
			//Console.WriteLine ("Postal Request: " + onlineReg.Tag);
		}



	
		public override void OnCreateOptionsMenu(IMenu menu, MenuInflater inflater)
		{
			inflater.Inflate(Resource.Menu.residentMenuNew, menu);
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

				alert.SetPositiveButton ("Yes", (senresponderderAlert, args) => {
					DataController.propertyChange = true;
					updateResidents ();
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

				return true;
			}
			return base.OnOptionsItemSelected(item);
		}

		public void updateResidents()
		{

			for(int i = 0; i < residents.Count; i++){

				Dictionary<string, object> residentDict = new Dictionary<string, object> ();
				Dictionary<string, object> residentPrevDict = new Dictionary<string, object> ();
				string responder, encourage, onlineReg;
				residentDict = residents[i];

				//string  = residentDict ["nationality"].ToString ();
				if (residentDict ["responder"] != null) {
					responder = residentDict ["responder"].ToString ();
				} else {
					responder = "NO";
				}
				if (residentDict ["encourage"] != null) {
					encourage = residentDict ["encourage"].ToString ();
				} else {
					encourage = "NO";
				}
				if (residentDict ["onlineReg"] != null) {
					onlineReg = residentDict ["onlineReg"].ToString ();
				} else {
					onlineReg = "NO";
				}
				string residentID = residentDict ["id"].ToString ();

				string response2=NetworkCalls.updateResidentsNew (responder, encourage, onlineReg, residentID, DataController.token, DataController.uprn);

				//Console.WriteLine ("residentUpdate.Count:::" + residentUpdate.Count + " iiii :" + i);
				if (residentUpdate.Count  > i) 
				{
					//Console.WriteLine ("BOOOOOOOOOOOOOOOOOOOOOOOOOOOO:::" + " iiii :" + i);

					residentPrevDict = residentUpdate [i];

					//Console.WriteLine ("FOOOOOOOOOOOOOOOOOOOOOOOOOOOO:::" + " iiii :" + i);

					string nationality = residentPrevDict ["nationality"].ToString ();

					string optOut = residentPrevDict ["optOut"].ToString ();
					string jury = residentPrevDict ["jury"].ToString ();
					string absent = residentPrevDict ["absent"].ToString ();
					string residentIDPrev = residentPrevDict ["id"].ToString ();
					string response1=NetworkCalls.updateResidents (nationality, optOut, jury, absent, residentIDPrev, DataController.token, DataController.uprn);
				}


			}
				
			//Console.WriteLine ("LOOOOOP ENDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDD111111111111");


			for(int i = 0; i < newPersons.Count; i++)
			{
				//Console.WriteLine ("SECOND LOPPPPPP: " + i);

				Dictionary<string, object> residentDict = new Dictionary<string, object> ();
				string responder, encourage, onlineReg;
				residentDict = newPersons[i];

				//Console.WriteLine ("AFTER GETTTTTTTTTTTTT: " + i);

				if (residentDict ["responder"] != null) {
					responder = residentDict ["responder"].ToString ();
				} else {
					responder = "NO";
				}
				if (residentDict ["encourage"] != null) {
					encourage = residentDict ["encourage"].ToString ();
				} else {
					encourage = "NO";
				}
				if (residentDict ["onlineReg"] != null) {
					onlineReg = residentDict ["onlineReg"].ToString ();
				} else {
					onlineReg = "NO";
				}
				string residentID = residentDict ["id"].ToString ();
				string response=NetworkCalls.updateResidentsNew (responder, encourage, onlineReg, residentID, DataController.token, DataController.uprn);

			}
				
			//Console.WriteLine ("LOOOOOP ENDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDD2222222222222222222222222");

			NetworkCalls.updatePropertyNoteITR (DataController.uprn, RemoveSpecialCharacters(note.Text), DataController.token);
			NetworkCalls.updatePropertyNote (DataController.uprn, RemoveSpecialCharacters(notePrev), DataController.token);

			//Console.WriteLine ("DataController.propertyToChange:::" + DataController.propertyToChange);

			//Console.WriteLine ("addressessssssssss:::" + addresses.Count);

			if (addresses.Count > DataController.propertyToChange) {

				propertyDict = addresses [DataController.propertyToChange];
				propertyDict ["notesItr"] = RemoveSpecialCharacters(note.Text);
				addresses [DataController.propertyToChange] = propertyDict;
			}
				

			if(true)
			{
				Toast newProperties = new Toast (this.Activity);
				newProperties = Toast.MakeText (Activity.ApplicationContext,"Property confirmed", ToastLength.Short);
				newProperties.Show ();
			}


			removeFragment ();
		}
		/*async void OnAlertYesNoClicked (object sender, EventArgs e)
		{
			var answer = await DisplayAlert ("Question?", "Would you like to play a game", "Yes", "No");
			//Debug.WriteLine ("Answer: " + answer);
		}*/
		public void removeFragment()
		{

			try
			{
				Android.Support.V4.App.FragmentTransaction ft = FragmentManager.BeginTransaction ();
				ft.Remove (this);
				ft.Show (FragmentManager.FindFragmentByTag ("canvassesFragment"));
				ft.Commit ();
			}

			catch(Exception ex) 
			{
				//Console.WriteLine ("Ex From REEEEEEEEE" + ex.ToString());
			}




		}

		public void addPerson(TableLayout tl, LayoutInflater inflater){
			Dictionary<string, object> residentNew = new Dictionary<string, object> ();

			TableRow notes =  new TableRow(this.Activity);
			notes.Tag = "notes";
			note = new EditText (this.Activity);
			note.Hint = "Notes";
			if (DataController.note != "") {
				note.Text = DataController.note;
			}
			note.Gravity = GravityFlags.Center;

			TableRow.LayoutParams stretchRow = new TableRow.LayoutParams();
			stretchRow.Span = 5;

			notes.AddView(note, stretchRow);
			tl.AddView (notes);

			TableRow btnRow =  new TableRow(this.Activity);
			btnRow.Tag = "btnRow";

			Button requestITR = new Button(this.Activity);
			requestITR.Text = "Add Person";


			requestITR.Click += (object sender, EventArgs e) => {

				LayoutInflater viewInflater = this.Activity.LayoutInflater;
				var myCustomAlert = inflater.Inflate(Resource.Layout.RequestITR, null);

				EditText firstname = (EditText)myCustomAlert.FindViewById(Resource.Id.firstnameEdit);

				EditText surname = (EditText)myCustomAlert.FindViewById(Resource.Id.surnameEdit);
				ItrTypeGroup = (RadioGroup)myCustomAlert.FindViewById(Resource.Id.itrType);
				//set alert for executing the task
				AlertDialog.Builder alert = new AlertDialog.Builder (Activity);
				//string firstnameEdit = firstname.Text;
				//string surnameEdit = surname.Text;
				alert.SetTitle ("Request ITR");

				alert.SetView(myCustomAlert);

				alert.SetPositiveButton ("Confirm", (senderAlert, args) => {
					//change value write your own set of instructions
					//you can also create an event for the same in xamarin
					//instead of writing things here
					//Console.WriteLine(firstname.Text);
					if(checkNetwork()){
						try{


							string  fName = firstname.Text.ToString();
							string  sName = surname.Text.ToString();
							int selectedId = ItrTypeGroup.CheckedRadioButtonId;
							itrType = (RadioButton)myCustomAlert.FindViewById(selectedId);

							string fullname = RemoveSpecialCharacters(fName + " " + sName);

							if(itrType == null || itrType.Tag == null)
							{
								Toast newProperties = new Toast (this.Activity);
								newProperties = Toast.MakeText (Activity.ApplicationContext,"Please specify ITR type", ToastLength.Short);
								newProperties.Show ();
								return;
							}

							string type = itrType.Tag.ToString();

							if(string.IsNullOrWhiteSpace(fName) || string.IsNullOrWhiteSpace(sName) || string.IsNullOrWhiteSpace(type) )
							{
								Toast newProperties = new Toast (this.Activity);
								newProperties = Toast.MakeText (Activity.ApplicationContext,"Please fill out mandatory fields", ToastLength.Short);
								newProperties.Show ();
								return;
							}

							var responseString = NetworkCalls.requestITR(DataController.uprn, DataController.houseID,firstname.Text.ToString(),surname.Text.ToString(), fullname, DataController.canvassID, type, DataController.token);

							var newPerson = JsonConvert.DeserializeObject<Dictionary<string, object>>(responseString);
							//Console.WriteLine("jsonDict " + newPerson);


							int tag = newPersons.Count; 


							newPerson.Add("responder","NO");
							newPerson.Add("encourage","NO");
							newPerson.Add("onlineReg","NO");
							newPersons.Add(newPerson);

							var uniqueId = string.Empty;

							if (newPerson.ContainsKey ("id")) {
								if (!string.IsNullOrWhiteSpace(newPerson["id"].ToString ())) {
									uniqueId = newPerson ["id"].ToString ();
									//Console.WriteLine("sdsdsds");
								}
							} 


							tl.RemoveView (tl.FindViewWithTag ("notes"));
							tl.RemoveView (tl.FindViewWithTag ("btnRow"));

							TableRow tr = new TableRow(this.Activity);
							tr.Tag = uniqueId;
							TextView itr = new TextView(this.Activity);
							TextView name = new TextView(this.Activity);
							name.Text = " " + fullname;
							name.TextSize = 20.0f;
							//name.SetTextColor (Resources.GetColor (Resource.Color.highlight));
							name.Click += (object sender1, EventArgs e1) => {
								//string responseResidentNew = NetworkCalls.getResidents (DataController.token, DataController.canvassID, DataController.uprn);
								residentEdit (uniqueId, tl, inflater,name,newPerson);
								//string responseResidentNew = NetworkCalls.getResidents (DataController.token, DataController.canvassID, DataController.uprn);
								//Console.WriteLine("Thilina Herath");
							};
							/*TextView  = new TextView(this.Activity);
						nationality.Text = "TBC";
						nationality.TextSize = 18.0f;
						nationality.SetTextColor (Resources.GetColor (Resource.Color.tableText));*/

							//adasdadasdadasdadadadsdasdasdsasd
		
							CheckBox responder = new CheckBox (this.Activity);
							//Console.WriteLine ("RESPONDER");
							responder.Tag = tag;
							responder.CheckedChange += (object sender1, CompoundButton.CheckedChangeEventArgs e1) => {
								checkResponderNew (responder);
							};
								
							CheckBox encourage = new CheckBox (this.Activity);
							encourage.Tag = tag;
							encourage.CheckedChange += (object sender1, CompoundButton.CheckedChangeEventArgs e1) => {
								checkEncourageNew (encourage);
							};

							CheckBox onlineReg = new CheckBox (this.Activity);
							onlineReg.Tag = tag;
							onlineReg.CheckedChange += (object sender1, CompoundButton.CheckedChangeEventArgs e1) => {
								checkOnlineRegNew (onlineReg);
							};

							tr.SetBackgroundColor (Resources.GetColor (Resource.Color.highlight));
							tr.AddView(itr);
							tr.AddView(name);
							//tr.AddView(nationality);
							tr.AddView(responder);
							tr.AddView(encourage);
							tr.AddView(onlineReg);
							tl.AddView(tr);

							addPerson(tl, inflater);
						}
						catch(Exception ex)
						{
							//Console.WriteLine(ex.ToString());
						}
					}else{
						showNetworkError();
					}

					//					note.Text = note.Text + " ITR Requested for: " + firstname.Text.ToString() + " " + surname.Text.ToString() + ",";

				});

				alert.SetNegativeButton ("Cancel", (senderAlert, args) => {
					//perform your own task for this conditional button click

				} );
				//run the alert in UI thread to display in the screen
				Activity.RunOnUiThread (() => {
					alert.Show();
				} );

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
				if ((c >= '0' && c <= '9') || (c >= 'A' && c <= 'Z') || (c >= 'a' && c <= 'z') || c == '.' || c == '_' || c == '@' || c == ' ' || c== '-') {
					sb.Append (c);
				}
			}
			return sb.ToString ();
		}


	}


	public class ITRChanges{
		public bool IsNameChanged {get;set;}
		public string NewItrSureName {get;set;}
		public string NewItrFirstName {get;set;}
		public string CheckBoxType {get;set;}

	}

}

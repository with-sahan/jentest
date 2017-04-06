using System;
using System.Collections.Generic;
using Android.Locations;
using Android.Gms.Maps;
using Android.Gms.Maps.Model;


namespace NavDrawer
{
	public static class DataController
	{
		public static string token { get; set; }
		public static string role { get; set; }
		public static string managerID { get; set; }
		public static string userID { get; set; }
		public static string lat { get; set; }
		public static string lng { get; set; }
		public static string accuracy { get; set; }
		public static string locationType { get; set; }
		public static string userEmail { get; set; }
		public static string canvassID { get; set; }
		public static List<Dictionary<string, object>> addresses { get; set; }
		public static List<Dictionary<string, object>> residents { get; set; }
		public static string address { get; set; }
		public static string uprn { get; set; }
		public static string houseID { get; set; }
		public static List<LatLng> coords { get; set; }
		public static bool propertyChange { get; set; }
		public static string note { get; set; }
		//public static List<Dictionary<string, object>> propertyToChange { get; set; }
		public static int propertyToChange { get; set; }
		public static string version = "1.0.4";
		public static bool propertyReset { get; set; }
		public static string url { get; set; }
		public static string fileType { get; set; }
	}
}



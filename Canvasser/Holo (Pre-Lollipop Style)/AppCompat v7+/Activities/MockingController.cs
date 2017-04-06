using System;
using System.Collections.Generic;

namespace NavDrawer
{
	public static class MockingController
	{
		/*public MockingController ()
		{
		}*/

		public static List<Dictionary<string, object>> getResidentsPrev(){
			List<Dictionary<string, object>> residentsTest = new List<Dictionary<string, object>>();
			for (int i = 0; i < 3; i++)
			{
				var mockResident = new Dictionary<string, object>
				{
					{ "id", i },
					{ "fullName", "John Deo" },
					{ "nationality", "UK" },
					{ "optOut", "NO" },
					{ "jury", "NO"},
					{ "absent", "NO"},
				};
				residentsTest.Add(mockResident);
			}
			return residentsTest;
		}

		public static List<Dictionary<string, object>> getResidents(){
			List<Dictionary<string, object>> residentsTest = new List<Dictionary<string, object>>();
			for (int i = 0; i < 3; i++)
			{
				var mockResident = new Dictionary<string, object>
				{
					{ "id", i },
					{ "fullName", "John Deo" },
					{ "responder", "NO" },
					{ "encourage", "NO" },
					{ "onlineReg", "NO"}
				};
				residentsTest.Add(mockResident);
			}
			return residentsTest;
		}
		public static List<Dictionary<string, object>> getProperties(){
			List<Dictionary<string, object>> addressesTest = new List<Dictionary<string, object>>();
			for (int i = 0; i < 10; i++)
			{
				var mockAddress = new Dictionary<string, object>
				{
					{ "id", i },
					{ "uprn", i },
					{ "fullAddress", "No 2/A, Bellwood road, Airland" },
					{ "canvassID", "0011343C" },
					{ "visitCount", "0"},
					{ "status", "D"},
				};
				addressesTest.Add(mockAddress);
			}
			return addressesTest;
		}
	}
}





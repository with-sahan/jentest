//using System;
//using System.Collections.Generic;
//
//using Android.Content;
//using Android.Support.V4.App;
//using Android.Views;
//using Android.Widget;
//
//using NavDrawer.Activities;
//using NavDrawer.Adapters;
//using NavDrawer.Models;
//using Fragment = Android.Support.V4.App.Fragment;
//namespace NavDrawer.Fragments
//{
//    public class FriendsAllFragment : Fragment
//    {
//        public FriendsAllFragment()
//        {
//            this.RetainInstance = true;
//        }
//
//        private List<FriendViewModel> _friends;
//        public override View OnCreateView(LayoutInflater inflater, ViewGroup container, Android.OS.Bundle savedInstanceState)
//        {
//            var ignored = base.OnCreateView(inflater, container, savedInstanceState);
//            var view = inflater.Inflate(Resource.Layout.fragment_friends_all, null);
//  
//            return view;
//        }
//
//        private void GridOnItemClick(object sender, AdapterView.ItemClickEventArgs itemClickEventArgs)
//        {
//            var intent = new Intent(Activity, typeof(FriendActivity));
//            intent.PutExtra("Title", _friends[itemClickEventArgs.Position].Title);
//            intent.PutExtra("Image", _friends[itemClickEventArgs.Position].Image);
//            StartActivity(intent);
//        }
//    }
//}
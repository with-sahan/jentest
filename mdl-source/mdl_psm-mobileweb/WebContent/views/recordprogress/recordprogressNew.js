
'use strict';

angular.module('newApp').controller('mdl.mobileweb.controller.recordprogressNew',
		['$rootScope', '$scope', 'mdl.mobileweb.service.dashboard', 'mdl.mobileweb.service.recordprogress', 'mdl.mobileweb.service.login', 'toaster', 'mdl.mobileweb.service.json', '$http', 'modalService', '$location',
		 function ($rootScope, $scope, dashboardService, recordprogressService, loginService, toaster, jsonService, $http, modalService, $location) {


		     // ng-show="vm.typeResult.typecount==2"

		     var vm = this;

		     vm.typeResult = '1';

		     vm.pollingStationList = [];
		     vm.electionlist = [];
		     vm.electionId;
		     vm.periodProgress = {};
		     vm.periodProgress.ballotPappersIssued = "";
		     vm.periodProgress.postalPackRecieved = "";
		     vm.periodProgress.postalPacksCollected = "";
		     vm.bpNames = {}

		     vm.progressSummery = [];
		     vm.progressSummery.ballotpapers = "0";
		     vm.progressSummery.postalpacks = "0";
		     vm.periodProgress.ballotPappersSpoiled = "0";
		     vm.progressSummery.postalpackscollected = "0";
		     vm.org_state = [];

		     vm.buttonDisabled = false;
		     vm.fieldDisabled = false;
		     vm.stationstatus = false;

		     vm.polling_Station_Election = [];

		     vm.postalPacksTotalCollected = 0;
		     vm.stationId = 0;

		     vm.BPA_identifier = "0";
		     var ballotTotalArray = new Array(vm.progressSummery.length);
		     var ballotIssuedFullTotal = 0;
		     var tenderedTotalArray = new Array(vm.progressSummery.length);
		     var tenderedIssuedFullTotal = 0;

		     vm.popup_topic = "Name of Person Uplifting";
		     vm.popup_user = "";

		     vm.collect_packs_electionid = 0;
		     vm.collect_packs_stationid = 0;

		     vm.postalPacksOnloadSet = new Array(vm.progressSummery.length);

		     var progressSummeryArray = new Array(vm.progressSummery.length);

		     vm.stationstatuscheck = function (stationId) {
		         dashboardService.getpollingstationclosedstatus(stationId, function (response) {
		             var res = response.result.entry;
		             if (res.response == "success") {
		                 if ((res.open_status == 1) && (res.closed_status == 0)) {
		                     //							toaster.pop("info","can do record progress");
		                     vm.stationstatus = true;
		                 }
		                 else if (res.open_status == 0) {
		                     vm.stationstatus = false;
		                     toaster.pop("info", "Station Not Opened!", "Cannot do record progress to unopened stations.");
		                 }
		                 else if (res.closed_status == 1) {
		                     vm.stationstatus = false;
		                     toaster.pop("error", "Station Closed!", "Cannot do record progress to closed stations.");
		                 }
		                 else {
		                     vm.stationstatus = false;
		                     toaster.pop("error", "Error!", "Please try again later.");
		                 }
		             }
		             else {
		                 toaster.pop("error", "Error!", "Try again later");
		             }
		         });
		     }

		     vm.showCloseButton = function (electionid, stationId) {
		         recordprogressService.showCloseButton(electionid, stationId, function (response) {

		             if (response.result.entry.response == "success") {
		                 vm.buttonshowDetails = response.result.entry.buttonshow;

		             } else {
		                 toaster.pop("error", "Error!", "Try again later");
		             }
		         });
		     }

		     vm.checkElectionClosed = 0;
		     vm.checkElection = function (eid, stationid, callback) {
		         $rootScope.cui_blocker(true);//UI blocker started
		         dashboardService.getElectionStatus(eid, stationid, function (response) {
		             vm.checkElectionClosed = response.result.entry.electionstatus;
		             vm.electionstatus = response.result.entry;
		             $rootScope.cui_blocker(false);//UI blocker close
		             if (callback)
		                 callback();
		         });
		     }

		     vm.getBPNames = function (eid) {
		         $rootScope.cui_blocker(true);//UI blocker started
		         dashboardService.getBPNames(eid, function (response) {
		             vm.bpNames = response.result.entry;
		             $rootScope.cui_blocker(false);//UI blocker close
		         });
		     }

		     vm.getEList = function (stationid) {
		         dashboardService.getEllectionList(stationid, function (response) {
		             var res = response.result.entry;
		             if (jsonService.whatIsIt(res) == "Object") {
		                 vm.electionlist[0] = res;
		             }
		             else if (jsonService.whatIsIt(res) == "Array") {
		                 vm.electionlist = res;
		             }

		             vm.getProgress(vm.electionlist[0].electionid, stationid);
		             vm.showCloseButton(vm.electionlist[0].electionid, stationid);
		             vm.checkElection(vm.electionlist[0].electionid, stationid);

		             dashboardService.getBallotType(vm.electionlist[0].electionid, function (response) {
		                 vm.typeResult = response.result.entry;
		             });

		         })
		     };

		     vm.getStationList = function () {
		         dashboardService.getPollingStations(function (response) {
		             var resp = response.result.entry;
		             if (jsonService.whatIsIt(resp) == "Object") {
		                 vm.pollingStationList[0] = resp;
		                 vm.getEList(vm.pollingStationList[0].id)
		             }
		             else if (jsonService.whatIsIt(resp) == "Array") {
		                 vm.pollingStationList = resp;
		                 vm.getEList(vm.pollingStationList[0].id)
		             }
		             vm.stationstatuscheck(vm.pollingStationList[0].id);
		         })
		     };

		     vm.getStationList();

		     vm.getElectionByID = function (election_Id, callback) {
		         recordprogressService.getElectionByID(function (response) {
		             vm.oneOfElections = response.result.entry;
		             vm.BPA_identifier = vm.oneOfElections.BPA_identifier;

		             if (callback)
		                 callback();
		         }, election_Id)
		     };

		     vm.getProgressApiCall = function (electionid, stationId) {
		         recordprogressService.getProgress(electionid, stationId, function (response) {

		             var isAllSucess = "1";
		             for (var row in response.results) {
		                 if (row.response != "success" && row.ballotpapers != null) {
		                     isAllSucess = "0";
		                     break;
		                 }
		             }
		             if (isAllSucess == "1") {
		                 //alert("");
		                 vm.progressSummery = response.results;

		                 //vm.templateModal2.eid = electionid;
		                 //vm.templateModal2.sid = stationId;

		                 if (vm.BPA_identifier == "0") {
		                     for (var i = 0; i < vm.progressSummery.length; i++) {
		                         var ballotpapersrecievedTotal = vm.progressSummery[i];
		                         if (ballotpapersrecievedTotal.ballotpapers != null) {
		                             vm.progressSummery[i].ballotpapers = parseInt(ballotpapersrecievedTotal.ballotpapers, 10);
		                         }

		                         if (ballotpapersrecievedTotal.tenballotpapers != null) {
		                             vm.progressSummery[i].tenballotpapers = parseInt(ballotpapersrecievedTotal.tenballotpapers, 10);
		                         }
		                     }
		                     //if user navigate to another page wthout saving data
		                     angular.copy(vm.progressSummery, vm.org_state);
		                 } else if (vm.BPA_identifier == "1") {

		                     var balotPaperStart = -1;
		                     var tenderdStart = -1;

		                     //Cumulative counts
		                     var cumilativeBallotCount = 0;
		                     var cumilativeTenderdCount = 0;
		                     var cumilativeBallotCount2 = 0;
		                     var cumilativeTenderdCount2 = 0;

		                     balotPaperStart = parseInt(vm.polling_Station_Election.ballotstart);
		                     tenderdStart = parseInt(vm.polling_Station_Election.tenderstart);

		                     if (balotPaperStart == -1 || tenderdStart == -1) {
		                         toaster.pop("error", "Data loading error!", "");
		                     } else {

		                         var balPapaersFlag = false;
		                         var tenBalPapersFlag = false;
		                         var balPapaers2Flag = false;
		                         var tenBalPapers2Flag = false;

		                         for (var i = 0; i < response.results.length; i++) {
		                             var row = response.results[i];

		                             var balPapaers = 0;
		                             var tenBalPapers = 0;
		                             var balPapaers2 = 0;
		                             var tenBalPapers2 = 0;

		                             //if balotpapers issued in this hour
		                             if (row.ballotpapers != 0) {

		                                 if (balPapaersFlag == true) {
		                                     balPapaers = cumilativeBallotCount + balotPaperStart + (row.ballotpapers || 0);
		                                     cumilativeBallotCount = cumilativeBallotCount + row.ballotpapers;
		                                 } else {
		                                     balPapaersFlag = true;
		                                     balPapaers = cumilativeBallotCount + balotPaperStart + (row.ballotpapers || 0) - 1;
		                                     cumilativeBallotCount = cumilativeBallotCount + row.ballotpapers - 1;
		                                 }
		                             }
		                             if (row.tenballotpapers != 0) {
		                                 if (tenBalPapersFlag == true) {
		                                     tenBalPapers = cumilativeTenderdCount + tenderdStart + (row.tenballotpapers || 0);
		                                     cumilativeTenderdCount = cumilativeTenderdCount + row.tenballotpapers;
		                                 }
		                                 else {
		                                     tenBalPapersFlag = true;
		                                     tenBalPapers = cumilativeTenderdCount + tenderdStart + (row.tenballotpapers || 0) - 1;
		                                     cumilativeTenderdCount = cumilativeTenderdCount + row.tenballotpapers - 1;
		                                 }
		                             }
		                             if (row.ballotpapers2 != 0) {
		                                 if (balPapaers2Flag == true) {
		                                     balPapaers2 = cumilativeBallotCount2 + balotPaperStart + (row.ballotpapers2 || 0);
		                                     cumilativeBallotCount2 = cumilativeBallotCount2 + row.ballotpapers2;
		                                 }
		                                 else {
		                                     balPapaers2Flag = true;
		                                     balPapaers2 = cumilativeBallotCount2 + balotPaperStart + (row.ballotpapers2 || 0) - 1;
		                                     cumilativeBallotCount2 = cumilativeBallotCount2 + row.ballotpapers2 - 1;
		                                 }
		                             }
		                             if (row.tenballotpapers2 != 0) {
		                                 if (tenBalPapers2Flag == true) {
		                                     tenBalPapers2 = cumilativeTenderdCount2 + tenderdStart + (row.tenballotpapers2 || 0);
		                                     cumilativeTenderdCount2 = cumilativeTenderdCount2 + row.tenballotpapers2;
		                                 }
		                                 else {
		                                     tenBalPapers2Flag = true;
		                                     tenBalPapers2 = cumilativeTenderdCount2 + tenderdStart + (row.tenballotpapers2 || 0) - 1;
		                                     cumilativeTenderdCount2 = cumilativeTenderdCount2 + row.tenballotpapers2 - 1;
		                                 }
		                             }






		                             vm.progressSummery[i].ballotpapers = balPapaers;
		                             vm.progressSummery[i].tenballotpapers = tenBalPapers;
		                             vm.progressSummery[i].ballotpapers2 = balPapaers2;
		                             vm.progressSummery[i].tenballotpapers2 = tenBalPapers2;
		                         }
		                         //if user navigate to another page wthout saving data
		                         angular.copy(vm.progressSummery, vm.org_state);
		                     }
		                 }

		             }
		             else {
		                 toaster.pop("error", "Data loading error!", "");
		             }
		             vm.postalPacksTotalCollected = vm.postalPacksTotalOnload();
		         });

		         vm.showCloseButton(electionid, stationId);
		     }

		     vm.getPollingStationElectionDetails = function (electionid, pollingstationid, callback) {
		         recordprogressService.getPollingStationElectionDetails(function (response) {
		             vm.polling_Station_Election = response.result.entry;

		             if (callback)
		                 callback();
		         }, electionid, pollingstationid)
		     };

		     vm.getProgress = function (electionid, stationId) {
		         dashboardService.getBallotType(electionid, function (response) {
		             vm.typeResult = response.result.entry;
		         });
		         vm.getBPNames(electionid);
		         vm.electionId = electionid;
		         vm.stationId = stationId;
		         vm.getElectionByID(electionid, function () {
		             vm.getPollingStationElectionDetails(electionid, stationId, function () {
		                 vm.checkElection(electionid, stationId, function () {
		                     vm.getProgressApiCall(electionid, stationId);
		                 });
		             });
		         });

		     }

		     vm.tenderedShow = false;
		     vm.mainballowStats = true;
		     vm.tenderedControl = function (action) {
		         if (action) {
		             vm.mainballowStats = false;
		             vm.tenderedShow = true;
		         }
		         else {
		             vm.mainballowStats = true;
		             vm.tenderedShow = false;
		         }

		     }

		     vm.stationcheck = function (stationid, eid) {
		         vm.electionlist = [];
		         vm.getEList(stationid);
		         vm.recordProgress = [];
		         vm.periodProgress = {};
		         vm.periodProgress.ballotPappersIssued = "";
		         vm.periodProgress.ballotPappersSpoiled = "";
		         vm.periodProgress.postalPackRecieved = "";
		         vm.periodProgress.postalPacksCollected = "";

		         vm.progressSummery = [];
		         vm.progressSummery.ballotpapers = "0";
		         vm.progressSummery.postalpacks = "0";
		         vm.progressSummery.postalpackscollected = "0";
		         vm.stationstatuscheck(stationid);

		     }

		     vm.saveTimeSlot = function (electionId, stationId, data, toastEnable, successCallback) {

		         $rootScope.cui_blocker(true);//UI blocker started
		         recordprogressService.updateProgress(electionId, stationId, data, function (response) {

		             if (response.response && response.response === 'sucess') {

		                 if (toastEnable) {
		                     toaster.pop("success", "Data saved Successfully", "");
		                 }

		                 if (successCallback) {
		                     successCallback();
		                 }
		             } else if (toastEnable && response.response != 'invalid ballot paper count') {
		                 toaster.pop("error", "Ballot Paper Count is Invalid!", "Please try again later.");
		             }
		             $rootScope.cui_blocker();
		         });
		     }

		     vm.validateValue = function (val) { // Validate for positive valid number
		         if (!isNaN(val) && val >= 0)
		             return true;
		         else
		             return false;
		     }

		     vm.save = function (stationId, updateObj, tendred, successCallback) {
		         var totals = vm.getTotals();
		         var ballotPaperSaved = totals.ballotIssuedTotal - totals.spoiltBallotsTotal;
		         var tenderdBallotPaperSaved = totals.tendredballotIssuedTotal - totals.tendredspoiltBallotsTotal;
		         var ballotPaperSaved2 = totals.ballotIssuedTotal2 - totals.spoiltBallotsTotal2;
		         var tenderdBallotPaperSaved2 = totals.tendredballotIssuedTotal2 - totals.tendredspoiltBallotsTotal2;

		         var ballotturnoutTemp = parseInt(vm.electionstatus.ballotturnout, 10) + 1;
		         var tendturnoutTemp = parseInt(vm.electionstatus.tendturnout, 10) + 1;

		         angular.copy(vm.progressSummery, vm.org_state);

		         var isValidInput = true;
		         var validateToastMsg = "";
		         if (ballotturnoutTemp < totals.ballotIssuedTotal) {
		             isValidInput = false;
		             validateToastMsg = "Your ballot paper count (" + totals.ballotIssuedTotal + ") is greater than total ballot turnout (" + ballotturnoutTemp + "). Please correct.";
		         }
		         else if (ballotturnoutTemp < totals.ballotIssuedTotal2) {
		             isValidInput = false;
		             validateToastMsg = "Your ballot " + vm.bpNames.paper2 + "  count (" + totals.ballotIssuedTotal2 + ") is greater than total ballot turnout (" + ballotturnoutTemp + "). Please correct.";
		         }
		         else if (tendturnoutTemp < totals.tendredballotIssuedTotal) {
		             isValidInput = false;
		             validateToastMsg = "Your Tendered ballot paper count (" + totals.tendredballotIssuedTotal + ") is greater than total tendered ballot turnout (" + tendturnoutTemp + "). Please correct.";
		         }
		         else if (tendturnoutTemp < totals.tendredballotIssuedTotal2) {
		             isValidInput = false;
		             validateToastMsg = "Your Tendered ballot " + vm.bpNames.paper2 + "  count (" + totals.tendredballotIssuedTotal + ") is greater than total tendered ballot turnout (" + tendturnoutTemp + "). Please correct.";
		         } 
		         
		         if (vm.postalPacksTotalOnload() > vm.getTotals().postalPacksTotal) {
	            	 toaster.pop("error", "Total Postal Packs are smaller than Collected Postal Packs!", "");
	             } else {
	            	 if (vm.BPA_identifier == "1") {
			             if ((totals.ballotIssuedTotal) < 0) {
			                 toaster.pop("error", "Ballot Paper Issued should be greater than " + vm.polling_Station_Election.ballotstart + " and smaller than " + vm.polling_Station_Election.ballotend + "!", "");
			             }
			             else if ((totals.ballotIssuedTotal) > (vm.polling_Station_Election.ballotend - vm.polling_Station_Election.ballotstart + 1)) {
			                 toaster.pop("error", "Ballot Paper Issued should be greater than " + vm.polling_Station_Election.ballotstart + " and smaller than " + vm.polling_Station_Election.ballotend + "!", "");
			             }
			             else if ((totals.tendredballotIssuedTotal) < 0) {
			                 toaster.pop("error", "Tendered Paper Issued should be greater than " + vm.polling_Station_Election.tenderstart + " and smaller than " + vm.polling_Station_Election.tenderend + "!", "");
			             }
			             else if ((totals.tendredballotIssuedTotal) > (vm.polling_Station_Election.tenderend - vm.polling_Station_Election.tenderstart + 1)) {
			                 toaster.pop("error", "Tendered Paper Issued should be greater than " + vm.polling_Station_Election.tenderstart + " and smaller than " + vm.polling_Station_Election.tenderend + "!", "");
			             }
			             else if ((totals.ballotIssuedTotal2) < 0) {
			                 toaster.pop("error", "Ballot " + vm.bpNames.paper2 + " issued should be greater than " + vm.polling_Station_Election.ballotstart + " and smaller than " + vm.polling_Station_Election.ballotend + "!", "");
			             }
			             else if ((totals.ballotIssuedTotal2) > (vm.polling_Station_Election.ballotend - vm.polling_Station_Election.ballotstart + 1)) {
			                 toaster.pop("error", "Ballot " + vm.bpNames.paper2 + " issued should be greater than " + vm.polling_Station_Election.ballotstart + " and smaller than " + vm.polling_Station_Election.ballotend + "!", "");
			             }
			             else if ((totals.tendredballotIssuedTotal2) < 0) {
			                 toaster.pop("error", "Tendered " + vm.bpNames.paper2 + " issued should be greater than " + vm.polling_Station_Election.tenderstart + " and smaller than " + vm.polling_Station_Election.tenderend + "!", "");
			             }
			             else if ((totals.tendredballotIssuedTotal2) > (vm.polling_Station_Election.tenderend - vm.polling_Station_Election.tenderstart + 1)) {
			                 toaster.pop("error", "Tendered " + vm.bpNames.paper2 + " issued should be greater than " + vm.polling_Station_Election.tenderstart + " and smaller than " + vm.polling_Station_Election.tenderend + "!", "");
			             }
			             else if ((ballotPaperSaved >= 0) && (tenderdBallotPaperSaved >= 0) && (ballotPaperSaved2 >= 0) && (tenderdBallotPaperSaved2 >= 0) && isValidInput) {
			                 var hasError = false;
			                 var progressData = [];

			                 angular.forEach(updateObj, function (value, key) {

			                     var toastMsg = '';  //Validate Input
			                     if (!vm.checkPassingValidValues(updateObj, value.ballotpapers, key)) {
			                         toastMsg = "You have enterd invalid values, Check them again! ";
			                     } else if (!vm.checkPassingValidValues2(updateObj, value.tenballotpapers, key)) {
			                         toastMsg = "You have enterd invalid values, Check them again! ";
			                     }
			                     else if (!vm.validateValue(value.ballotpapers))
			                         toastMsg = "Ballot Papers ";
			                     else if (!vm.validateValue(value.postalpacks))
			                         toastMsg = "Postalpacks ";
			                     else if (!vm.validateValue(value.postalpackscollected))
			                         toastMsg = "Postalpacks collected ";
			                     else if (!vm.validateValue(value.spoiltballots))
			                         toastMsg = "Spolit Ballots ";
			                     else if (!vm.validateValue(value.tenballotpapers))
			                         toastMsg = "Tendered ballot papers ";
			                     else if (!vm.validateValue(value.tenspoiltballots))
			                         toastMsg = "Tendered Spoilt ballots ";

			                     if (toastMsg.length > 0) {
			                         hasError = true;
			                         toaster.pop("error", toastMsg + " - Invalid record with a minus value is not saved, please correct.", "");
			                     }
			                     else {
			                         vm.saveObj = {};
			                         vm.saveObj.ballotPapers = vm.checkAssigningValuesGeneric(value, key, updateObj, 'ballotpapers', vm.polling_Station_Election.ballotstart);
			                         vm.saveObj.postalPacks = value.postalpacks;
			                         vm.saveObj.postalPacksCollected = value.postalpackscollected;
			                         vm.saveObj.spoiltBallots = value.spoiltballots;
			                         vm.saveObj.tenBallotPapers = vm.checkAssigningValuesGeneric(value, key, updateObj, 'tenballotpapers', vm.polling_Station_Election.tenderstart);
			                         vm.saveObj.tenSpoiltBallots = value.tenspoiltballots;
			                         vm.saveObj.ballotPapers2 = vm.checkAssigningValuesGeneric(value, key, updateObj, 'ballotpapers2', vm.polling_Station_Election.ballotstart);
			                         vm.saveObj.postalPacks2 = value.postalpacks2;
			                         vm.saveObj.postalPacksCollected2 = value.postalpackscollected2;
			                         vm.saveObj.spoiltBallots2 = value.spoiltballots2;
			                         vm.saveObj.tenBallotPapers2 = vm.checkAssigningValuesGeneric(value, key, updateObj, 'tenballotpapers2', vm.polling_Station_Election.tenderstart);
			                         vm.saveObj.tenSpoiltBallots2 = value.tenspoiltballots2;
			                         vm.saveObj.updateTime = value.time.split('-')[0].split(':')[0];

			                         progressData.push(vm.saveObj);
			                     }
			                 });


			                 vm.saveTimeSlot(vm.electionId, stationId, progressData, false, successCallback);

			                 if (!hasError)
			                     toaster.pop("success", "Data saved Successfully", "");

			                 if (tendred & !hasError)
			                     vm.tenderedControl(false);

			             } else {
			                 if (!isValidInput)
			                     toaster.pop("error", validateToastMsg, "");
			                 else
			                     toaster.pop("error", "The number of ballot papers issued should be greater than the number of spolied ballots!", "");
			             }
			         } else if (vm.BPA_identifier == "0") {
			             if ((ballotPaperSaved >= 0) && (tenderdBallotPaperSaved >= 0) && (ballotPaperSaved2 >= 0) && (tenderdBallotPaperSaved2 >= 0) && isValidInput) {
			                 var hasError = false;
			                 var progressData = [];
			                 angular.forEach(updateObj, function (value, key) {
			                     vm.saveObj = {};
			                     var toastMsg = '';  //Validate Input
			                     if (!vm.validateValue(value.ballotpapers))
			                         toastMsg = "Ballot Papers ";
			                     else if (!vm.validateValue(value.postalpacks))
			                         toastMsg = "Postalpacks ";
			                     else if (!vm.validateValue(value.postalpackscollected))
			                         toastMsg = "Postalpacks collected ";
			                     else if (!vm.validateValue(value.spoiltballots))
			                         toastMsg = "Spolit Ballots ";
			                     else if (!vm.validateValue(value.tenballotpapers))
			                         toastMsg = "Tendered ballot papers ";
			                     else if (!vm.validateValue(value.tenspoiltballots))
			                         toastMsg = "Tendered Spoilt ballots ";

			                     if (toastMsg.length > 0) {
			                         hasError = true;
			                         toaster.pop("error", toastMsg + " - Invalid record with a minus value is not saved, please correct. Rest of the records Saved successfully", "");
			                     }
			                     else {
			                         vm.saveObj.ballotPapers = value.ballotpapers;
			                         vm.saveObj.postalPacks = value.postalpacks;
			                         vm.saveObj.postalPacksCollected = value.postalpackscollected;
			                         vm.saveObj.spoiltBallots = value.spoiltballots;
			                         vm.saveObj.tenBallotPapers = value.tenballotpapers;
			                         vm.saveObj.tenSpoiltBallots = value.tenspoiltballots;
			                         vm.saveObj.updateTime = value.time.split('-')[0].split(':')[0];
			                         vm.saveObj.ballotPapers2 = value.ballotpapers2
			                         vm.saveObj.postalPacks2 = value.postalpacks2;
			                         vm.saveObj.postalPacksCollected2 = value.postalpackscollected2;
			                         vm.saveObj.spoiltBallots2 = value.spoiltballots2;
			                         vm.saveObj.tenBallotPapers2 = value.tenballotpapers2;
			                         vm.saveObj.tenSpoiltBallots2 = value.tenspoiltballots2;
			                         progressData.push(vm.saveObj);

			                     }
			                 });

			                 vm.saveTimeSlot(vm.electionId, stationId, progressData, false, successCallback);

			                 if (!hasError)
			                     toaster.pop("success", "Data saved Successfully", "");

			                 if (tendred)
			                     vm.tenderedControl(false);

			             } else {
			                 if (!isValidInput)
			                     toaster.pop("error", validateToastMsg, "");
			                 else
			                     toaster.pop("error", "The number of ballot papers issued should be greater than the number of spolied ballots!", "");
			             }
			         }
	             }

		         
		     };

		     vm.totalByPropertyForPapaerNumber = function (property, maxValue) {
		         var valuesArray = [];
		         var total = 0;

		         for (var i = 0; i < vm.progressSummery.length; i++) {
		             var summeryItem = vm.progressSummery[i];
		             valuesArray.push(summeryItem[property] || 0);
		         }
		         if (Math.max.apply(Math, valuesArray) > 0) {
		             total = (Math.max.apply(Math, valuesArray) - maxValue) + 1;
		         }

		         return total;
		     }

		     vm.getTotals = function () {
		         var totals = {};
		         totals.ballotIssuedTotal = 0
		         totals.spoiltBallotsTotal = 0;
		         totals.tendredballotIssuedTotal = 0
		         totals.tendredspoiltBallotsTotal = 0
		         totals.postalPacksTotal = 0
		         totals.postalPacksCollectedTotal = 0
		         totals.ballotIssuedTotal2 = 0
		         totals.spoiltBallotsTotal2 = 0;
		         totals.tendredballotIssuedTotal2 = 0
		         totals.tendredspoiltBallotsTotal2 = 0

		         //Calculate the *.spoilt
		         //That is spoiltBallotsTotal, tendredspoiltBallotsTotal,spoiltBallotsTotal2,tendredspoiltBallotsTotal2
		         for (var i = 0; i < vm.progressSummery.length; i++) {
		             //the ONE'S (spoiltBallotsTotal &  tendredspoiltBallotsTotal)
		             totals.spoiltBallotsTotal += (vm.progressSummery[i].spoiltballots || 0);
		             totals.tendredspoiltBallotsTotal += (vm.progressSummery[i].tenspoiltballots || 0);

		             //the TWO's (spoiltBallotsTotal2 &  tendredspoiltBallotsTotal2)
		             totals.spoiltBallotsTotal2 += (vm.progressSummery[i].spoiltballots2 || 0);
		             totals.tendredspoiltBallotsTotal2 += (vm.progressSummery[i].tenspoiltballots2 || 0);

		             // Postal Packs
		             totals.postalPacksTotal += (vm.progressSummery[i].postalpacks || 0);
		             totals.postalPacksCollectedTotal += (vm.progressSummery[i].postalpackscollected || 0);
		         }

		         //Calculate *.ballots
		         //That is ballotIssuedTotal, tendredballotIssuedTotal,ballotIssuedTotal2,tendredballotIssuedTotal2

		         if (vm.BPA_identifier == "0") {
		             for (var i = 0; i < vm.progressSummery.length; i++) {
		                 //the ONE'S (ballotIssuedTotal & tendredballotIssuedTotal)
		                 totals.ballotIssuedTotal += (vm.progressSummery[i].ballotpapers || 0);
		                 totals.tendredballotIssuedTotal += (vm.progressSummery[i].tenballotpapers || 0);

		                 //the TWO's(ballotIssuedTotal2 & tendredballotIssuedTotal2)
		                 totals.ballotIssuedTotal2 += (vm.progressSummery[i].ballotpapers2 || 0);
		                 totals.tendredballotIssuedTotal2 += (vm.progressSummery[i].tenballotpapers2 || 0);
		             }
		         } else if (vm.BPA_identifier == "1") {
		             //the ONE'S (ballotIssuedTotal & tendredballotIssuedTotal)
		             totals.ballotIssuedTotal += vm.totalByPropertyForPapaerNumber('ballotpapers', vm.polling_Station_Election.ballotstart);
		             totals.tendredballotIssuedTotal += vm.totalByPropertyForPapaerNumber('tenballotpapers', vm.polling_Station_Election.tenderstart);

		             //the TWO's(ballotIssuedTotal2 & tendredballotIssuedTotal2)
		             totals.ballotIssuedTotal2 += vm.totalByPropertyForPapaerNumber('ballotpapers2', vm.polling_Station_Election.ballotstart);
		             totals.tendredballotIssuedTotal2 += vm.totalByPropertyForPapaerNumber('tenballotpapers2', vm.polling_Station_Election.tenderstart);;
		         }
		         return totals;
		     }

		     //vm.postalPacksOnloadSet = vm.progressSummery;
		     vm.postalPacksTotalOnload = function () {
		         var total4 = 0;
		         for (var i = 0; i < vm.progressSummery.length; i++) {
		             var postalTotalOnload = vm.progressSummery[i];
		             //vm.postalPacksOnloadSet[i] = vm.progressSummery[i].postalpackscollected;

		             if (postalTotalOnload.postalpackscollected != null)
		                 total4 += parseInt(postalTotalOnload.postalpackscollected, 10);
		         }
		         return total4;

		     }

		     $scope.rec_electionid = '';
		     $scope.rec_stationId = '';

		     $scope.callConfirmation = function (electionid, stationId) {
		         $scope.templateModal.body = "Are you sure you want to complete progress: No further Information can be recorded"
		         $scope.templateModal.save = function () { $scope.closeStation(); };
		         if (vm.postalPacksTotalOnload() !== vm.getTotals().postalPacksTotal)
		             toaster.pop("error", " You have postal packs still to be collected", "Please collect postal packs.");
		         else {
		             $scope.rec_electionid = electionid;
		             $scope.rec_stationId = stationId;
		             modalService.load('rec_progress');
		         }
		     };

		     $scope.closeStation = function () {
		         if ($scope.rec_electionid.length > 0 && $scope.rec_stationId.length > 0) {
		             recordprogressService.closeStation($scope.rec_electionid, $scope.rec_stationId, function (response) {
		                 if (response.result.entry.response == "success") {
		                     vm.closeStationDetails = response.result.entry;
		                     //vm.buttonDisabled = true;
		                     //vm.fieldDisabled = true;
		                     vm.checkElectionClosed = 1;
		                     toaster.pop("success", "Election closed successfully", "");
		                     vm.onRouteChangeOff();
		                     modalService.close('rec_progress');
		                 } else {
		                     toaster.pop("error", "Error!", "Try again later");
		                 }
		             });
		         }
		     }

		     vm.postalPackCollected = function (electionid, stationId) {
		         if ((isNaN(vm.getTotals().postalPacksTotal)) || (vm.getTotals().postalPacksTotal < 0)) {
		             toaster.pop("error", "Enter a valid value for Postal Packs!", "");
		         } else {
		             if (vm.postalPacksTotalOnload() === vm.getTotals().postalPacksTotal) {
		                 toaster.pop("success", "Collected Postal Packs are same as Total Postal Packs!", "No need to save it.");
		             } else if (vm.postalPacksTotalOnload() > vm.getTotals().postalPacksTotal) {
		            	 toaster.pop("error", "Total Postal Packs are smaller than Collected Postal Packs!", "");
		             } else {
		                 vm.save(stationId, vm.progressSummery, false, function () { vm.assignPerson(electionid, stationId); })
		             }

		         }

		     }

		     //modalcolouredfooter
		     vm.template2 = "views/closestation/popup_collect_packs.html";
		     vm.templateModal2 = {
		         id: "rec_progress2",
		         body: "Are you sure you want to complete progress: No further Information can be recorded",
		         closeCaption: "No",
		         saveCaption: "Yes",
		     };

		     vm.assignPerson = function (electionid, stationId) {
		         vm.templateModal2.eid = electionid;
		         vm.templateModal2.sid = stationId;

		         vm.templateModal2.save = function () {
		             vm.collectingPostalPacks(electionid, stationId, vm.popup_user);
		             modalService.close('rec_progress2');
		         },

                 vm.templateModal2.close = function () { modalService.close('rec_progress2'); };
		         modalService.load('rec_progress2');
		     };

		     vm.collectingPostalPacks = function (electionid, stationId, uplifting_person_name) {
		         recordprogressService.postalPackCollected_V2(electionid, stationId, uplifting_person_name, function (response) {

		             if (response.result.entry.response == "success") {
		                 vm.postalPackDetails = response.result.entry;

		                 if (vm.getTotals().postalPacksTotal == 0) {
		                     toaster.pop("success", "Postal Packs are Collected!", "There are no packs to Collect!");
		                     $rootScope.cui_blocker(false);//UI blocker close
		                 } else {
		                     $rootScope.cui_blocker(true);//UI blocker started
		                     $rootScope.cui_blocker(false);//UI blocker close
		                 }

		                 vm.getProgress(electionid, stationId);
		             } else {
		                 toaster.pop("error", "Error!", "Try again later");
		             }

		         });

		         
		     };

		     /*vm.postalPackCollected_V2 = function (electionid, stationId, assigned_person_name, update_time) {
		         recordprogressService.postalPackCollected_V2(electionid, stationId, assigned_person_name, update_time, function (response) {

		             if (response.result.entry.response == "success") {
		                 vm.postalPackDetails2 = response.result.entry;
		             } else {
		                 toaster.pop("error", "Error!", "Try again later");
		             }

		         });
		     };*/

		     vm.checkNumberValidity = function (ballotpaperscount, key1) {
		         var count = 0;

		         var largestValue = 0;
		         var last_element = 0;
		         var passing_value_index = 0;

		         passing_value_index = ballotTotalArray.indexOf(ballotpaperscount);

		         if (ballotTotalArray[passing_value_index + 1] == 0) {
		             if ((ballotpaperscount < ballotTotalArray[passing_value_index - 1])) {

		                 $scope.templateModal.body = "Are you sure you want to update this value?"
		                 $scope.templateModal.save = function () {
		                     vm.updatingCells(ballotpaperscount, ballotTotalArray, key1);
		                     modalService.close('rec_progress');
		                 };
		                 modalService.load('rec_progress');
		             } else {
		                 //$scope.templateModal.body = "";
		                 $scope.templateModal.body = "Did you save all data before you close this election?"
		                 $scope.templateModal.save = function () { $scope.closeStation(); };
		             }


		         } else if (ballotTotalArray[passing_value_index + 1] > 0) {
		             if ((ballotpaperscount < ballotTotalArray[passing_value_index - 1]) || (ballotpaperscount > ballotTotalArray[passing_value_index + 1])) {

		                 $scope.templateModal.body = "Are you sure you want to update this value?"
		                 $scope.templateModal.save = function () {
		                     vm.updatingCells2(ballotpaperscount, ballotTotalArray, key1);
		                     modalService.close('rec_progress');
		                 };
		                 modalService.load('rec_progress');
		             } else {
		                 //$scope.templateModal.body = "";
		                 $scope.templateModal.body = "Did you save all data before you close this election?"
		                 $scope.templateModal.save = function () { $scope.closeStation(); };
		             }
		         }
		     };

		     vm.checkNumberValidity2 = function (tenderedpaperscount, key1) {
		         var count = 0;
		         var largestValue = 0;
		         var last_element = 0;
		         var passing_value_index = 0;

		         passing_value_index = tenderedTotalArray.indexOf(tenderedpaperscount);

		         if (tenderedTotalArray[passing_value_index + 1] == 0) {
		             if ((tenderedpaperscount < tenderedTotalArray[passing_value_index - 1])) {
		                 $scope.templateModal.body = "Are you sure you want to update this value?"
		                 $scope.templateModal.save = function () {
		                     vm.updatingCells3(tenderedpaperscount, tenderedTotalArray, key1);
		                     modalService.close('rec_progress');
		                 };
		                 modalService.load('rec_progress');
		             } else {
		                 //$scope.templateModal.body = ""
		                 $scope.templateModal.body = "Did you save all data before you close this election?"
		                 $scope.templateModal.save = function () { $scope.closeStation(); };
		             }


		         } else if (tenderedTotalArray[passing_value_index + 1] > 0) {
		             if ((tenderedpaperscount < tenderedTotalArray[passing_value_index - 1]) || (tenderedpaperscount > tenderedTotalArray[passing_value_index + 1])) {
		                 $scope.templateModal.body = "Are you sure you want to update this value?"
		                 $scope.templateModal.save = function () {
		                     vm.updatingCells4(tenderedpaperscount, tenderedTotalArray, key1);
		                     modalService.close('rec_progress');
		                 };
		                 modalService.load('rec_progress');
		             } else {
		                 //$scope.templateModal.body = "";
		                 $scope.templateModal.body = "Did you save all data before you close this election?"
		                 $scope.templateModal.save = function () { $scope.closeStation(); };
		             }
		         }
		     };

		     //modalcolouredfooter
		     $scope.template = "views/templatemodal/modalcolouredfooter.html";
		     $scope.templateModal = {
		         id: "rec_progress",
		         header: "Confirmation",
		         body: "Did you save all data before you close this election?",
		         closeCaption: "No",
		         saveCaption: "Yes",
		         save: function () {
		             $scope.closeStation();
		         },
		         close: function () { modalService.close('rec_progress'); }
		     };
		     vm.onRouteChangeOff = $scope.$on('$locationChangeStart', function (event, newUrl, oldUrl) {
		         if (!angular.equals(vm.org_state, vm.progressSummery)) {
		             vm.newUrl = newUrl;
		             event.preventDefault();

		             $scope.templateModal.body = "You have unsaved data before navigating to another page. Are you sure you want to leave this page?"
		             $scope.templateModal.save = function () {
		                 vm.onRouteChangeOff();
		                 $location.path($location.url(vm.newUrl).hash()); //Go to page 
		                 modalService.close('rec_progress');
		             };
		             modalService.load('rec_progress');
		         }
		         else {
		             $scope.templateModal.body = "Did you save all data before you close this election?"
		             $scope.templateModal.save = function () { $scope.closeStation(); };
		         }

		     });

		     vm.updatingCells = function (ballotpaperscount, ballotTotalArray, key1) {

		         var passing_value_index = 0;
		         passing_value_index = ballotTotalArray.indexOf(ballotpaperscount);
		         for (var i = 0; i < key1; i++) {
		             if (vm.progressSummery[i].ballotpapers > ballotpaperscount) {
		                 vm.progressSummery[i].ballotpapers = 0;
		             }

		         }
		     };

		     vm.updatingCells2 = function (ballotpaperscount, ballotTotalArray, key1) {

		         var passing_value_index = 0;
		         passing_value_index = ballotTotalArray.indexOf(ballotpaperscount);
		         for (var i = 0; i < key1; i++) {
		             if (vm.progressSummery[i].ballotpapers > ballotpaperscount) {
		                 vm.progressSummery[i].ballotpapers = 0;
		             }
		         }
		         /*if(ballotTotalArray[key1+1]<ballotpaperscount) {
                     vm.progressSummery[key1+1].ballotpapers = 0;
                 }*/
		         for (var i = (key1 + 1) ; i < vm.progressSummery.length; i++) {
		             vm.progressSummery[i].ballotpapers = 0;
		         }
		     };

		     vm.updatingCells3 = function (tenderedpaperscount, tenderedTotalArray, key1) {

		         var passing_value_index = 0;
		         passing_value_index = tenderedTotalArray.indexOf(tenderedpaperscount);
		         for (var i = 0; i < key1; i++) {
		             if (vm.progressSummery[i].tenballotpapers > tenderedpaperscount) {
		                 vm.progressSummery[i].tenballotpapers = 0;
		             }

		         }
		     };

		     vm.updatingCells4 = function (tenderedpaperscount, tenderedTotalArray, key1) {

		         var passing_value_index = 0;
		         passing_value_index = tenderedTotalArray.indexOf(tenderedpaperscount);
		         for (var i = 0; i < key1; i++) {
		             if (vm.progressSummery[i].tenballotpapers > tenderedpaperscount) {
		                 vm.progressSummery[i].tenballotpapers = 0;
		             }
		         }
		         if (tenderedTotalArray[key1 + 1] < tenderedpaperscount) {
		             vm.progressSummery[key1 + 1].tenballotpapers = 0;
		         }
		     };

		     vm.checkPassingValidValues = function (updateObj, ballotpapers, key) {
		         if (key > 0) {
		             var prevValue = parseInt(updateObj[key - 1].ballotpapers);
		             if (prevValue > 0) {
		                 if (parseInt(ballotpapers) > 0) {
		                     var diffBallotPapers = parseInt(ballotpapers) - parseInt(updateObj[key - 1].ballotpapers);
		                     if (diffBallotPapers < 0) {
		                         return false;
		                     } else if (diffBallotPapers > 0) {
		                         return true;
		                     } else {
		                         return false;
		                     }
		                 } else if (parseInt(ballotpapers) < 0) {
		                     return false;
		                 } else {
		                     return true;
		                 }
		             } else {
		                 var ballotOtherSet = [];
		                 var count3 = 0;
		                 var lastValue = 0;
		                 for (var i = 0; i < key; i++) {
		                     if (parseInt(updateObj[i].ballotpapers) > 0) {
		                         ballotOtherSet[count3] = parseInt(updateObj[i].ballotpapers);
		                         count3++;
		                     }
		                 }

		                 if (ballotOtherSet.length > 0) {
		                     lastValue = parseInt(ballotOtherSet[count3 - 1]);
		                 }

		                 if (parseInt(ballotpapers) > 0) {
		                     if (lastValue > 0) {
		                         var checkPositiveValue = (parseInt(ballotpapers) - parseInt(lastValue));
		                         if (checkPositiveValue < 0) {
		                             return false;
		                         } else {
		                             return true;
		                         }
		                     } else {
		                         var diffBallotPapers2 = parseInt(ballotpapers) - parseInt(vm.polling_Station_Election.ballotstart);
		                         if (diffBallotPapers2 < 0) {
		                             return false;
		                         } else {
		                             return true;
		                         }
		                     }

		                 } else if (parseInt(ballotpapers) < 0) {
		                     return false;
		                 } else {
		                     return true;
		                 }

		             }

		         } else {
		             if (parseInt(ballotpapers) > 0) {
		                 var checkPositiveValue = (parseInt(ballotpapers) - parseInt(vm.polling_Station_Election.ballotstart));
		                 if (checkPositiveValue < 0) {
		                     return false;
		                 } else {
		                     return true;
		                 }

		             } else if (parseInt(ballotpapers) < 0) {
		                 return false;
		             } else {
		                 return true;
		             }

		         }
		     }

		     vm.checkPassingValidValues2 = function (updateObj, tenballotpapers, key) {
		         if (key > 0) {
		             var prevValue = parseInt(updateObj[key - 1].tenballotpapers);
		             if (prevValue > 0) {
		                 if (parseInt(tenballotpapers) > 0) {
		                     var diffBallotPapers = parseInt(tenballotpapers) - parseInt(updateObj[key - 1].tenballotpapers);
		                     if (diffBallotPapers < 0) {
		                         return false;
		                     } else if (diffBallotPapers > 0) {
		                         return true;
		                     } else {
		                         return false;
		                     }
		                 } else if (parseInt(tenballotpapers) < 0) {
		                     return false;
		                 } else {
		                     return true;
		                 }

		             } else {
		                 var ballotOtherSet = [];
		                 var count3 = 0;
		                 var lastValue = 0;
		                 for (var i = 0; i < key; i++) {
		                     if (parseInt(updateObj[i].tenballotpapers) > 0) {
		                         ballotOtherSet[count3] = parseInt(updateObj[i].tenballotpapers);
		                         count3++;
		                     }
		                 }

		                 if (ballotOtherSet.length > 0) {
		                     lastValue = parseInt(ballotOtherSet[count3 - 1]);
		                 }

		                 if (parseInt(tenballotpapers) > 0) {
		                     if (lastValue > 0) {
		                         var checkPositiveValue = (parseInt(tenballotpapers) - parseInt(lastValue));
		                         if (checkPositiveValue < 0) {
		                             return false;
		                         } else {
		                             return true;
		                         }
		                     } else {
		                         var diffBallotPapers2 = parseInt(tenballotpapers) - parseInt(vm.polling_Station_Election.tenderstart);
		                         if (diffBallotPapers2 < 0) {
		                             return false;
		                         } else {
		                             return true;
		                         }
		                     }

		                 } else if (parseInt(tenballotpapers) < 0) {
		                     return false;
		                 } else {
		                     return true;
		                 }

		             }

		         } else {
		             if (parseInt(tenballotpapers) > 0) {
		                 var checkPositiveValue = (parseInt(tenballotpapers) - parseInt(vm.polling_Station_Election.tenderstart));
		                 if (checkPositiveValue < 0) {
		                     return false;
		                 } else {
		                     return true;
		                 }

		             } else if (parseInt(tenballotpapers) < 0) {
		                 return false;
		             } else {
		                 return true;
		             }

		         }
		     }

		     vm.checkAssigningValuesGeneric = function (value, key, updateObj, property, startValue) {
		         if (key > 0) {
		             var prevValue = parseInt(updateObj[key - 1][property]);
		             if (prevValue > 0) {
		                 var diffBallotPapers = parseInt(value[property]) - parseInt(updateObj[key - 1][property]);
		                 if (diffBallotPapers > 0) {
		                     return diffBallotPapers;
		                 } else {
		                     return 0;
		                 }
		             } else {
		                 var ballotOtherSet = [];
		                 var count3 = 0;
		                 var lastValue = 0;
		                 for (var i = 0; i < key; i++) {
		                     if (parseInt(updateObj[i][property]) > 0) {
		                         ballotOtherSet[count3] = parseInt(updateObj[i][property]);
		                         count3++;
		                     }
		                 }

		                 if (ballotOtherSet.length > 0) {
		                     lastValue = parseInt(ballotOtherSet[count3 - 1]);
		                 }

		                 if (parseInt(value[property]) > 0) {
		                     if (lastValue > 0) {
		                         var checkPositiveValue = (parseInt(value[property]) - parseInt(lastValue));
		                         if (checkPositiveValue > 0) {
		                             return checkPositiveValue;
		                         }
		                     } else {
		                         var diffBallotPapers2 = parseInt(value[property]) - parseInt(startValue) + 1;
		                         if (diffBallotPapers2 > 0) {
		                             return diffBallotPapers2;
		                         }
		                     }

		                 } else {
		                     if (parseInt(value[property]) == 0) {
		                         return 0;
		                     }

		                 }

		             }

		         } else {
		             if (parseInt(value[property]) > 0) {
		                 var checkPositiveValue = (parseInt(value[property]) - parseInt(startValue) + 1);
		                 if (checkPositiveValue > 0) {
		                     return checkPositiveValue;
		                 }

		             } else {
		                 if (parseInt(value[property]) == 0) {
		                     return 0;
		                 }

		             }

		         }
		     }


		 }])
	  .directive('focusctrl', function ($timeout, $parse) {
	      return {
	          restrict: 'A',
	          link: function (scope, element, attrs) {

	              element.bind("focus", function (e) {
	                  if (element.val() == 0) element.val('');
	              })

	              element.bind("blur", function (e) {
	                  if (element.val() == '') { element.val(0); }
	              });
	          }
	      }
	  });

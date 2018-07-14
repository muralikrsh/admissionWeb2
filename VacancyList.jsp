<%@page import="java.sql.*, java.io.*, campus.*, java.util.*"%>
<!DOCTYPE html>
<html  style="height: 95%;">
<title>Vacancy List</title>
	<head>
	<meta charset="utf-8">
    <link href="Styles/Style.css" rel="stylesheet" type="text/css" />
    <link href="Styles/jquery-ui.css" rel="stylesheet" type="text/css" />
    <link href="Styles/superfish-native.css" rel="stylesheet" type="text/css" />
	<link href="css/button-style.css" rel="stylesheet" type="text/css" />

	<script src="ui/minified/jquery-1.7.2.min.js"></script>
	<script src="ui/minified/jquery.ui.core.min.js"></script>
	<script src="ui/minified/jquery.ui.widget.min.js"></script>
	<script src="ui/jquery.validation.js"></script>
    <script src="Scripts/hoverIntent.js" type="text/javascript"></script>
    <script src="Scripts/superfish.js" type="text/javascript"></script>
    <script src="Scripts/CustomScript.js" type="text/javascript"></script>

	<script>

		String.prototype.trim = function() {
			return this.replace(/^\s+|\s+$/g,"");
		}

		function updateAeroVacant() 
		{
			var xmlHttp;
			if (window.XMLHttpRequest) { // Mozilla, Safari, ...
				var xmlHttp = new XMLHttpRequest();
			}else if (window.ActiveXObject) { // IE
				var xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");
			}
			var strURL="VacancyListResult.jsp?";
			xmlHttp.open('POST', strURL, true);
			xmlHttp.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
			xmlHttp.send("CourseName="+document.getElementById("aero").value+"&Vacancy="+document.getElementById("aeroVacancy").value);
			xmlHttp.onreadystatechange = function() {
				if (xmlHttp.readyState == 4) {
					alert("Updated");
				}
			}
		}
		
		function updateAutoVacant() 
		{
			var xmlHttp;
			if (window.XMLHttpRequest) { // Mozilla, Safari, ...
				var xmlHttp = new XMLHttpRequest();
			}else if (window.ActiveXObject) { // IE
				var xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");
			}
			var strURL="VacancyListResult.jsp?";
			xmlHttp.open('POST', strURL, true);
			xmlHttp.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
			xmlHttp.send("CourseName="+document.getElementById("auto").value+"&Vacancy="+document.getElementById("autoVacancy").value);
			xmlHttp.onreadystatechange = function() {
				if (xmlHttp.readyState == 4) {
					alert("Updated");
				}
			}
		}
		
		function updateBioInfoVacant() 
		{
			var xmlHttp;
			if (window.XMLHttpRequest) { // Mozilla, Safari, ...
				var xmlHttp = new XMLHttpRequest();
			}else if (window.ActiveXObject) { // IE
				var xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");
			}
			var strURL="VacancyListResult.jsp?";
			xmlHttp.open('POST', strURL, true);
			xmlHttp.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
			xmlHttp.send("CourseName="+document.getElementById("bioInfo").value+"&Vacancy="+document.getElementById("bioInfoVacancy").value);
			xmlHttp.onreadystatechange = function() {
				if (xmlHttp.readyState == 4) {
					alert("Updated");
				}
			}
		}
		
		function updateBioMedicalVacant() 
		{
			var xmlHttp;
			if (window.XMLHttpRequest) { // Mozilla, Safari, ...
				var xmlHttp = new XMLHttpRequest();
			}else if (window.ActiveXObject) { // IE
				var xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");
			}
			var strURL="VacancyListResult.jsp?";
			xmlHttp.open('POST', strURL, true);
			xmlHttp.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
			xmlHttp.send("CourseName="+document.getElementById("bioMedical").value+"&Vacancy="+document.getElementById("bioMedicalVacancy").value);
			xmlHttp.onreadystatechange = function() {
				if (xmlHttp.readyState == 4) {
					alert("Updated");
				}
			}
		}
		
		function updateBioProcesVacant() 
		{
			var xmlHttp;
			if (window.XMLHttpRequest) { // Mozilla, Safari, ...
				var xmlHttp = new XMLHttpRequest();
			}else if (window.ActiveXObject) { // IE
				var xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");
			}
			var strURL="VacancyListResult.jsp?";
			xmlHttp.open('POST', strURL, true);
			xmlHttp.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
			xmlHttp.send("CourseName="+document.getElementById("bioProces").value+"&Vacancy="+document.getElementById("bioProcesVacancy").value);
			xmlHttp.onreadystatechange = function() {
				if (xmlHttp.readyState == 4) {
					alert("Updated");
				}
			}
		}
		
		function updateChemicalVacant() 
		{
			var xmlHttp;
			if (window.XMLHttpRequest) { // Mozilla, Safari, ...
				var xmlHttp = new XMLHttpRequest();
			}else if (window.ActiveXObject) { // IE
				var xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");
			}
			var strURL="VacancyListResult.jsp?";
			xmlHttp.open('POST', strURL, true);
			xmlHttp.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
			xmlHttp.send("CourseName="+document.getElementById("chemical").value+"&Vacancy="+document.getElementById("chemicalVacancy").value);
			xmlHttp.onreadystatechange = function() {
				if (xmlHttp.readyState == 4) {
					alert("Updated");
				}
			}
		}
		
		function updateCivilVacant() 
		{
			var xmlHttp;
			if (window.XMLHttpRequest) { // Mozilla, Safari, ...
				var xmlHttp = new XMLHttpRequest();
			}else if (window.ActiveXObject) { // IE
				var xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");
			}
			var strURL="VacancyListResult.jsp?";
			xmlHttp.open('POST', strURL, true);
			xmlHttp.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
			xmlHttp.send("CourseName="+document.getElementById("civil").value+"&Vacancy="+document.getElementById("civilVacancy").value);
			xmlHttp.onreadystatechange = function() {
				if (xmlHttp.readyState == 4) {
					alert("Updated");
				}
			}
		}
		
		function updateCivilInfraVacant() 
		{
			var xmlHttp;
			if (window.XMLHttpRequest) { // Mozilla, Safari, ...
				var xmlHttp = new XMLHttpRequest();
			}else if (window.ActiveXObject) { // IE
				var xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");
			}
			var strURL="VacancyListResult.jsp?";
			xmlHttp.open('POST', strURL, true);
			xmlHttp.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
			xmlHttp.send("CourseName="+document.getElementById("civilInfra").value+"&Vacancy="+document.getElementById("civilInfraVacancy").value);
			xmlHttp.onreadystatechange = function() {
				if (xmlHttp.readyState == 4) {
					alert("Updated");
				}
			}
		}
		
		function updateCompComVacant() 
		{
			var xmlHttp;
			if (window.XMLHttpRequest) { // Mozilla, Safari, ...
				var xmlHttp = new XMLHttpRequest();
			}else if (window.ActiveXObject) { // IE
				var xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");
			}
			var strURL="VacancyListResult.jsp?";
			xmlHttp.open('POST', strURL, true);
			xmlHttp.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
			xmlHttp.send("CourseName="+document.getElementById("compCom").value+"&Vacancy="+document.getElementById("compComVacancy").value);
			xmlHttp.onreadystatechange = function() {
				if (xmlHttp.readyState == 4) {
					alert("Updated");
				}
			}
		}
		
		function updateCompIntegVacant() 
		{
			var xmlHttp;
			if (window.XMLHttpRequest) { // Mozilla, Safari, ...
				var xmlHttp = new XMLHttpRequest();
			}else if (window.ActiveXObject) { // IE
				var xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");
			}
			var strURL="VacancyListResult.jsp?";
			xmlHttp.open('POST', strURL, true);
			xmlHttp.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
			xmlHttp.send("CourseName="+document.getElementById("compInteg").value+"&Vacancy="+document.getElementById("compIntegVacancy").value);
			xmlHttp.onreadystatechange = function() {
				if (xmlHttp.readyState == 4) {
					alert("Updated");
				}
			}
		}
		
		function updateCompScienceVacant() 
		{
			var xmlHttp;
			if (window.XMLHttpRequest) { // Mozilla, Safari, ...
				var xmlHttp = new XMLHttpRequest();
			}else if (window.ActiveXObject) { // IE
				var xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");
			}
			var strURL="VacancyListResult.jsp?";
			xmlHttp.open('POST', strURL, true);
			xmlHttp.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
			xmlHttp.send("CourseName="+document.getElementById("compScience").value+"&Vacancy="+document.getElementById("compScienceVacancy").value);
			xmlHttp.onreadystatechange = function() {
				if (xmlHttp.readyState == 4) {
					alert("Updated");
				}
			}
		}
		
		function updateCompSoftVacant() 
		{
			var xmlHttp;
			if (window.XMLHttpRequest) { // Mozilla, Safari, ...
				var xmlHttp = new XMLHttpRequest();
			}else if (window.ActiveXObject) { // IE
				var xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");
			}
			var strURL="VacancyListResult.jsp?";
			xmlHttp.open('POST', strURL, true);
			xmlHttp.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
			xmlHttp.send("CourseName="+document.getElementById("compSoft").value+"&Vacancy="+document.getElementById("compSoftVacancy").value);
			xmlHttp.onreadystatechange = function() {
				if (xmlHttp.readyState == 4) {
					alert("Updated");
				}
			}
		}
		
		function updateElecControlVacant() 
		{
			var xmlHttp;
			if (window.XMLHttpRequest) { // Mozilla, Safari, ...
				var xmlHttp = new XMLHttpRequest();
			}else if (window.ActiveXObject) { // IE
				var xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");
			}
			var strURL="VacancyListResult.jsp?";
			xmlHttp.open('POST', strURL, true);
			xmlHttp.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
			xmlHttp.send("CourseName="+document.getElementById("eControl").value+"&Vacancy="+document.getElementById("eControlVacancy").value);
			xmlHttp.onreadystatechange = function() {
				if (xmlHttp.readyState == 4) {
					alert("Updated");
				}
			}
		}
		
		function updateEEEVacant() 
		{
			var xmlHttp;
			if (window.XMLHttpRequest) { // Mozilla, Safari, ...
				var xmlHttp = new XMLHttpRequest();
			}else if (window.ActiveXObject) { // IE
				var xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");
			}
			var strURL="VacancyListResult.jsp?";
			xmlHttp.open('POST', strURL, true);
			xmlHttp.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
			xmlHttp.send("CourseName="+document.getElementById("eee").value+"&Vacancy="+document.getElementById("eeeVacancy").value);
			xmlHttp.onreadystatechange = function() {
				if (xmlHttp.readyState == 4) {
					alert("Updated");
				}
			}
		}
		
		function updateECEVacant() 
		{
			var xmlHttp;
			if (window.XMLHttpRequest) { // Mozilla, Safari, ...
				var xmlHttp = new XMLHttpRequest();
			}else if (window.ActiveXObject) { // IE
				var xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");
			}
			var strURL="VacancyListResult.jsp?";
			xmlHttp.open('POST', strURL, true);
			xmlHttp.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
			xmlHttp.send("CourseName="+document.getElementById("ece").value+"&Vacancy="+document.getElementById("eceVacancy").value);
			xmlHttp.onreadystatechange = function() {
				if (xmlHttp.readyState == 4) {
					alert("Updated");
				}
			}
		}
		
		function updateEIEVacant() 
		{
			var xmlHttp;
			if (window.XMLHttpRequest) { // Mozilla, Safari, ...
				var xmlHttp = new XMLHttpRequest();
			}else if (window.ActiveXObject) { // IE
				var xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");
			}
			var strURL="VacancyListResult.jsp?";
			xmlHttp.open('POST', strURL, true);
			xmlHttp.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
			xmlHttp.send("CourseName="+document.getElementById("eie").value+"&Vacancy="+document.getElementById("eieVacancy").value);
			xmlHttp.onreadystatechange = function() {
				if (xmlHttp.readyState == 4) {
					alert("Updated");
				}
			}
		}
		
		function updateETEVacant() 
		{
			var xmlHttp;
			if (window.XMLHttpRequest) { // Mozilla, Safari, ...
				var xmlHttp = new XMLHttpRequest();
			}else if (window.ActiveXObject) { // IE
				var xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");
			}
			var strURL="VacancyListResult.jsp?";
			xmlHttp.open('POST', strURL, true);
			xmlHttp.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
			xmlHttp.send("CourseName="+document.getElementById("ete").value+"&Vacancy="+document.getElementById("eteVacancy").value);
			xmlHttp.onreadystatechange = function() {
				if (xmlHttp.readyState == 4) {
					alert("Updated");
				}
			}
		}
		
		function updateFoodVacant() 
		{
			var xmlHttp;
			if (window.XMLHttpRequest) { // Mozilla, Safari, ...
				var xmlHttp = new XMLHttpRequest();
			}else if (window.ActiveXObject) { // IE
				var xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");
			}
			var strURL="VacancyListResult.jsp?";
			xmlHttp.open('POST', strURL, true);
			xmlHttp.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
			xmlHttp.send("CourseName="+document.getElementById("food").value+"&Vacancy="+document.getElementById("foodVacancy").value);
			xmlHttp.onreadystatechange = function() {
				if (xmlHttp.readyState == 4) {
					alert("Updated");
				}
			}
		}
		
		function updateAeroVacant() 
		{
			var xmlHttp;
			if (window.XMLHttpRequest) { // Mozilla, Safari, ...
				var xmlHttp = new XMLHttpRequest();
			}else if (window.ActiveXObject) { // IE
				var xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");
			}
			var strURL="VacancyListResult.jsp?";
			xmlHttp.open('POST', strURL, true);
			xmlHttp.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
			xmlHttp.send("CourseName="+document.getElementById("aero").value+"&Vacancy="+document.getElementById("aeroVacancy").value);
			xmlHttp.onreadystatechange = function() {
				if (xmlHttp.readyState == 4) {
					alert("Updated");
				}
			}
		}
		
		function updateGeneticsVacant() 
		{
			var xmlHttp;
			if (window.XMLHttpRequest) { // Mozilla, Safari, ...
				var xmlHttp = new XMLHttpRequest();
			}else if (window.ActiveXObject) { // IE
				var xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");
			}
			var strURL="VacancyListResult.jsp?";
			xmlHttp.open('POST', strURL, true);
			xmlHttp.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
			xmlHttp.send("CourseName="+document.getElementById("genetics").value+"&Vacancy="+document.getElementById("geneticsVacancy").value);
			xmlHttp.onreadystatechange = function() {
				if (xmlHttp.readyState == 4) {
					alert("Updated");
				}
			}
		}
		
		function updateIndusBioVacant() 
		{
			var xmlHttp;
			if (window.XMLHttpRequest) { // Mozilla, Safari, ...
				var xmlHttp = new XMLHttpRequest();
			}else if (window.ActiveXObject) { // IE
				var xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");
			}
			var strURL="VacancyListResult.jsp?";
			xmlHttp.open('POST', strURL, true);
			xmlHttp.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
			xmlHttp.send("CourseName="+document.getElementById("indusBio").value+"&Vacancy="+document.getElementById("indusBioVacancy").value);
			xmlHttp.onreadystatechange = function() {
				if (xmlHttp.readyState == 4) {
					alert("Updated");
				}
			}
		}
		
		function updateITVacant() 
		{
			var xmlHttp;
			if (window.XMLHttpRequest) { // Mozilla, Safari, ...
				var xmlHttp = new XMLHttpRequest();
			}else if (window.ActiveXObject) { // IE
				var xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");
			}
			var strURL="VacancyListResult.jsp?";
			xmlHttp.open('POST', strURL, true);
			xmlHttp.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
			xmlHttp.send("CourseName="+document.getElementById("it").value+"&Vacancy="+document.getElementById("itVacancy").value);
			xmlHttp.onreadystatechange = function() {
				if (xmlHttp.readyState == 4) {
					alert("Updated");
				}
			}
		}
		
		function updateLeatherVacant() 
		{
			var xmlHttp;
			if (window.XMLHttpRequest) { // Mozilla, Safari, ...
				var xmlHttp = new XMLHttpRequest();
			}else if (window.ActiveXObject) { // IE
				var xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");
			}
			var strURL="VacancyListResult.jsp?";
			xmlHttp.open('POST', strURL, true);
			xmlHttp.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
			xmlHttp.send("CourseName="+document.getElementById("leather").value+"&Vacancy="+document.getElementById("leatherVacancy").value);
			xmlHttp.onreadystatechange = function() {
				if (xmlHttp.readyState == 4) {
					alert("Updated");
				}
			}
		}
		
		function updateMechVacant() 
		{
			var xmlHttp;
			if (window.XMLHttpRequest) { // Mozilla, Safari, ...
				var xmlHttp = new XMLHttpRequest();
			}else if (window.ActiveXObject) { // IE
				var xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");
			}
			var strURL="VacancyListResult.jsp?";
			xmlHttp.open('POST', strURL, true);
			xmlHttp.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
			xmlHttp.send("CourseName="+document.getElementById("mech").value+"&Vacancy="+document.getElementById("mechVacancy").value);
			xmlHttp.onreadystatechange = function() {
				if (xmlHttp.readyState == 4) {
					alert("Updated");
				}
			}
		}
		
		function updateMechatronicsVacant() 
		{
			var xmlHttp;
			if (window.XMLHttpRequest) { // Mozilla, Safari, ...
				var xmlHttp = new XMLHttpRequest();
			}else if (window.ActiveXObject) { // IE
				var xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");
			}
			var strURL="VacancyListResult.jsp?";
			xmlHttp.open('POST', strURL, true);
			xmlHttp.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
			xmlHttp.send("CourseName="+document.getElementById("mechatronics").value+"&Vacancy="+document.getElementById("mechatronicsVacancy").value);
			xmlHttp.onreadystatechange = function() {
				if (xmlHttp.readyState == 4) {
					alert("Updated");
				}
			}
		}
		
		function updateNanoVacant() 
		{
			var xmlHttp;
			if (window.XMLHttpRequest) { // Mozilla, Safari, ...
				var xmlHttp = new XMLHttpRequest();
			}else if (window.ActiveXObject) { // IE
				var xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");
			}
			var strURL="VacancyListResult.jsp?";
			xmlHttp.open('POST', strURL, true);
			xmlHttp.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
			xmlHttp.send("CourseName="+document.getElementById("nano").value+"&Vacancy="+document.getElementById("nanoVacancy").value);
			xmlHttp.onreadystatechange = function() {
				if (xmlHttp.readyState == 4) {
					alert("Updated");
				}
			}
		}
		
		function updateProductionVacant() 
		{
			var xmlHttp;
			if (window.XMLHttpRequest) { // Mozilla, Safari, ...
				var xmlHttp = new XMLHttpRequest();
			}else if (window.ActiveXObject) { // IE
				var xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");
			}
			var strURL="VacancyListResult.jsp?";
			xmlHttp.open('POST', strURL, true);
			xmlHttp.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
			xmlHttp.send("CourseName="+document.getElementById("production").value+"&Vacancy="+document.getElementById("productionVacancy").value);
			xmlHttp.onreadystatechange = function() {
				if (xmlHttp.readyState == 4) {
					alert("Updated");
				}
			}
		}

		
		function cancel(){
			location.href='Home.jsp';
		}
    </script>
	<%@include file="MBHandler.jsp" %>
	</head>
	<body>
	<%@include file="CCMenu.jsp" %>
	<div class="content_container">
	<form id='courseform' name="courseform" method='POST' action='AddCourseResult.jsp' enctype="multipart/form-data">
	<tr><td colspan=2>&nbsp;</td></tr>
	<tr><td colspan=2>&nbsp;</td></tr>
		<table class=" valign_top textbox_medium tbl_p5 textarea_normal" width="90%">

			<tr><td colspan=2 class="button navy gradient">	Vacancy List Set up</td></tr>
			<tr><td colspan=2>&nbsp;</td></tr>
			<tr>
			<td class="label">Aeronautical Engineering&nbsp;</td>
			<td><input type="hidden" name="aero" value="Aeronautical Engineering" id="aero"/> <input type="text" name="aeroVacancy" value="" id="aeroVacancy"/> </td>
			<td><input type="button" class="clickButton" value="Update" onClick="javascript:updateAeroVacant()"/></td>
			</tr>
			<tr>
			<td class="label">Automobile Engineering&nbsp;</td>
			<td><input type="hidden" name="auto" value="Automobile Engineering" id="auto"/><input type="text" name="autoVacancy" value="" id="autoVacancy"/></td>
			<td><input type="button" class="clickButton" value="Update" onClick="javascript:updateAutoVacant()"/></td>
			</tr>
			<tr>
			<td class="label">Bio Informatics&nbsp;</td>
			<td><input type="hidden" name="bioInfo" value="Bio Informatics" id="bioInfo"/><input type="text" name="bioInfoVacancy" value="" id="bioInfoVacancy"/></td>
			<td><input type="button" class="clickButton" value="Update" onClick="javascript:updateBioInfoVacant()"/></td>
			</tr>
			<tr>
			<td class="label">Bio Medical Engineering&nbsp;</td>
			<td><input type="hidden" name="bioMedical" value="Bio Medical Engineering" id="bioMedical"/><input type="text" name="bioMedicalVacancy" value="" id="bioMedicalVacancy"/></td>
			<td><input type="button" class="clickButton" value="Update" onClick="javascript:updateBioMedicalVacant()"/></td>
			</tr>
			<tr>
			<td class="label">Bio Process&nbsp;</td>
			<td><input type="hidden" name="bioProces" value="Bio Process" id="bioProces"/><input type="text" name="bioProcesVacancy" value="" id="bioProcesVacancy"/></td>
			<td><input type="button" class="clickButton" value="Update" onClick="javascript:updateBioProcesVacant()"/></td>
			</tr>
			<tr>
			<td class="label">Chemical Engineering&nbsp;</td>
			<td><input type="hidden" name="chemical" value="Chemical Engineering" id="chemical"/><input type="text" name="chemicalVacancy" value="" id="chemicalVacancy"/></td>
			<td><input type="button" class="clickButton" value="Update" onClick="javascript:updateChemicalVacant()"/></td>
			</tr>
			<tr>
			<td class="label">Civil Engineering&nbsp;</td>
			<td><input type="hidden" name="civil" value="Civil Engineering" id="civil"/><input type="text" name="civilVacancy" value="" id="civilVacancy"/></td>
			<td><input type="button" class="clickButton" value="Update" onClick="javascript:updateCivilVacant()"/></td>
			</tr>
			<tr>
			<td class="label">Civil Infrastructure Engineering&nbsp;</td>
			<td><input type="hidden" name="civilInfra" value="Civil Infrastructure Engineering" id="civilInfra"/><input type="text" name="civilInfraVacancy" value="" id="civilInfraVacancy"/></td>
			<td><input type="button" class="clickButton" value="Update" onClick="javascript:updateCivilInfraVacant()"/></td>
			</tr>
			<tr>
			<td class="label">Computer and Communication&nbsp;</td>
			<td><input type="hidden" name="compCom" value="Computer and Communication" id="compCom"/><input type="text" name="compComVacancy" value="" id="compComVacancy"/></td>
			<td><input type="button" class="clickButton" value="Update" onClick="javascript:updateCompComVacant()"/></td>
			</tr>
			<tr>
			<td class="label">Computer Integrated Manufacturing&nbsp;</td>
			<td><input type="hidden" name="compInteg" value="Computer Integrated Manufacturing" id="compInteg"/><input type="text" name="compIntegVacancy" value="" id="compIntegVacancy"/></td>
			<td><input type="button" class="clickButton" value="Update" onClick="javascript:updateCompIntegVacant()"/></td>
			</tr>
			<tr>
			<td class="label">Computer Science and Engineering&nbsp;</td>
			<td><input type="hidden" name="compScience" value="Computer Science and Engineering" id="compScience"/><input type="text" name="compScienceVacancy" value="" id="compScienceVacancy"/></td>
			<td><input type="button" class="clickButton" value="Update" onClick="javascript:updateCompScienceVacant()"/></td>
			</tr>
			<tr>
			<td class="label">Computer Software Engineering&nbsp;</td>
			<td><input type="hidden" name="compSoft" value="Computer Software Engineering" id="compSoft"/><input type="text" name="compSoftVacancy" value="" id="compSoftVacancy"/></td>
			<td><input type="button" class="clickButton" value="Update" onClick="javascript:updateCompSoftVacant()"/></td>
			</tr>
			<tr>
			<td class="label">Electrical and Control Engineering&nbsp;</td>
			<td><input type="hidden" name="eControl" value="Electrical and Control Engineering" id="eControl"/><input type="text" name="eControlVacancy" value="" id="eControlVacancy"/></td>
			<td><input type="button" class="clickButton" value="Update" onClick="javascript:updateElecControlVacant()"/></td>
			</tr>
			<tr>
			<td class="label">Electrical and Electronics  Engineering&nbsp;</td>
			<td><input type="hidden" name="eee" value="Electrical and Electronics  Engineering" id="eee"/><input type="text" name="eeeVacancy" value="" id="eeeVacancy"/></td>
			<td><input type="button" class="clickButton" value="Update" onClick="javascript:updateEEEVacant()"/></td>
			</tr>
			<tr>
			<td class="label">Electronics and Communication Engineering&nbsp;</td>
			<td><input type="hidden" name="ece" value="Electronics and Communication Engineering" id="ece"/><input type="text" name="eceVacancy" value="" id="eceVacancy"/></td>
			<td><input type="button" class="clickButton" value="Update" onClick="javascript:updateECEVacant()"/></td>
			</tr>
			<tr>
			<td class="label">Electronics and Instrumentation Engineering&nbsp;</td>
			<td><input type="hidden" name="eie" value="Electronics and Instrumentation Engineering" id="eie"/><input type="text" name="eieVacancy" value="" id="eieVacancy"/></td>
			<td><input type="button" class="clickButton" value="Update" onClick="javascript:updateEIEVacant()"/></td>
			</tr>
			<tr>
			<td class="label">Electronics and Telecommunication Engineering&nbsp;</td>
			<td><input type="hidden" name="ete" value="Electronics and Telecommunication Engineering" id="ete"/><input type="text" name="eteVacancy" value="" id="eteVacancy"/></td>
			<td><input type="button" class="clickButton" value="Update" onClick="javascript:updateETEVacant()"/></td>
			</tr>
			<tr>
			<td class="label">Food Process Engineering&nbsp;</td>
			<td><input type="hidden" name="food" value="Food Process Engineering" id="food"/><input type="text" name="foodVacancy" value="" id="foodVacancy"/></td>
			<td><input type="button" class="clickButton" value="Update" onClick="javascript:updateFoodVacant()"/></td>
			</tr>
			<tr>
			<td class="label">Genetics Engineering&nbsp;</td>
			<td><input type="hidden" name="genetics" value="Genetics Engineering" id="genetics"/><input type="text" name="geneticsVacancy" value="" id="geneticsVacancy"/></td>
			<td><input type="button" class="clickButton" value="Update" onClick="javascript:updateGeneticsVacant()"/></td>
			</tr>
			<tr>
			<td class="label">Industrial Bio Technology&nbsp;</td>
			<td><input type="hidden" name="indusBio" value="Industrial Bio Technology" id="indusBio"/><input type="text" name="indusBioVacancy" value="" id="indusBioVacancy"/></td>
			<td><input type="button" class="clickButton" value="Update" onClick="javascript:updateIndusBioVacant()"/></td>
			</tr>
			<tr>
			<td class="label">Information Technology&nbsp;</td>
			<td><input type="hidden" name="it" value="Information Technology" id="it"/><input type="text" name="itVacancy" value="" id="itVacancy"/></td>
			<td><input type="button" class="clickButton" value="Update" onClick="javascript:updateITVacant()"/></td>
			</tr>
			<tr>
			<td class="label">Leather Technology&nbsp;</td>
			<td><input type="hidden" name="leather" value="Leather Technology" id="leather"/><input type="text" name="leatherVacancy" value="" id="leatherVacancy"/></td>
			<td><input type="button" class="clickButton" value="Update" onClick="javascript:updateLeatherVacant()"/></td>
			</tr>
			<tr>
			<td class="label">Mechanical Engineering&nbsp;</td>
			<td><input type="hidden" name="mech" value="Mechanical Engineering" id="mech"/><input type="text" name="mechVacancy" value="" id="mechVacancy"/></td>
			<td><input type="button" class="clickButton" value="Update" onClick="javascript:updateMechVacant()"/></td>
			</tr>
			<tr>
			<td class="label">Mechatronics  Engineering&nbsp;</td>
			<td><input type="hidden" name="mechatronics" value="Mechatronics  Engineering" id="mechatronics"/><input type="text" name="mechatronicsVacancy" value="" id="mechatronicsVacancy"/></td>
			<td><input type="button" class="clickButton" value="Update" onClick="javascript:updateMechatronicsVacant()"/></td>
			</tr>
			<tr>
			<td class="label">Nano Technology&nbsp;</td>
			<td><input type="hidden" name="nano" value="Nano Technology" id="nano"/><input type="text" name="nanoVacancy" value="" id="nanoVacancy"/></td>
			<td><input type="button" class="clickButton" value="Update" onClick="javascript:updateNanoVacant()"/></td>
			</tr>
			<tr>
			<td class="label">Production Engineering&nbsp;</td>
			<td><input type="hidden" name="production" value="Production Engineering" id="production"/><input type="text" name="productionVacancy" value="" id="productionVacancy"/></td>
			<td><input type="button" class="clickButton" value="Update" onClick="javascript:updateProductionVacant()"/></td>
			</tr>
			<tr><td colspan=2>&nbsp;</td></tr>
			<tr><td colspan=2><div id='resultCell'></div></td></tr>
			<tr><td colspan=2>&nbsp;</td></tr>
			</table>
	</form>
</div>
</section>
<%@include file="Footer.jsp" %>
</div>
</body>
</html>
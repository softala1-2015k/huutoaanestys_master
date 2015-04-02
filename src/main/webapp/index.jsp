<%@page contentType="text/html;charset=UTF-8"%>
<%@page pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>


<!doctype html>
<html class="no-js">
<head>

	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	
	<title>Huutoäänestys</title>
	
	<meta name="description" content="">
	<meta name="viewport" content="width=device-width" initial-scale="1">
	
	<!-- SCROLLS -->
	<link rel="stylesheet" href="http://netdna.bootstrapcdn.com/bootstrap/3.0.0/css/bootstrap.min.css" />
	<link rel="stylesheet" href="http://netdna.bootstrapcdn.com/font-awesome/4.0.0/css/font-awesome.css" />
	
	<!-- SPELLS -->
	<script src="http://ajax.googleapis.com/ajax/libs/angularjs/1.2.25/angular.min.js"></script>
	<script	src="http://ajax.googleapis.com/ajax/libs/angularjs/1.2.25/angular-route.js"></script>
	<script	src="http://ajax.googleapis.com/ajax/libs/angularjs/1.2.25/angular-animate.js"></script>
	<script	src="http://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
	<script	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/js/bootstrap.min.js"></script>
	
	<link rel="stylesheet" href="resources/css/style.css">

</head>


<body ng-app="huutoaanestysFrontApp">
	<!--[if lt IE 7]><p class="browsehappy">Looks like your browser is <strong>older than dinosaurs! </strong>Please <a href="http://browsehappy.com/">upgrade your browser</a> to improve your experience.</p><![endif]-->

	<!-- Add your site or application content here -->
	
	<div class="header">
		<div class="navbar navbar-default" role="navigation">
			<div class="container">
				<div class="navbar-header">

					<button type="button" class="navbar-toggle collapsed"
						data-toggle="collapse" data-target="#js-navbar-collapse">
						<span class="sr-only">Toggle navigation</span> 
						<span class="icon-bar"></span> 
						<span class="icon-bar"></span>
						<span class="icon-bar"></span>
					</button>

					<a class="navbar-brand" href="#/">huutoaanestysFront</a>
				</div>

				<div class="collapse navbar-collapse" id="js-navbar-collapse">

					<ul class="nav navbar-nav">
						<li class="active"><a href="#/">Home</a></li>
						<li><a ng-href="#/hops">HOPS</a></li>
					</ul>
				</div>
			</div>
		</div>
	</div>
	

	<div class="container">
		<!-- View files will load into this div -->
		<div ng-view=""></div>
	</div>

	<div class="footer">
		<div class="container">
			<p>
				<span class="glyphicon glyphicon-heart"></span> from the Yeoman team
			</p>
		</div>
	</div>


	<!-- build:js({.tmp,app}) scripts/scripts.js -->
	<script src="resources/app/app.js"></script>
	<script src="resources/app/controllers/main.js"></script>
	<script src="resources/app/controllers/hops.js"></script>
	<!-- endbuild -->

</body>
</html>

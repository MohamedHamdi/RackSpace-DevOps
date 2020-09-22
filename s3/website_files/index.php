<?php

ini_set('display_errors', 'On');
error_reporting(E_ALL);

$curl_cmd = 'curl --connect-timeout 1';
$meta_host = '169.254.169.254';
$meta_data['ami-id'] = $ami_id = exec($curl_cmd." http://".$meta_host."/latest/meta-data/ami-id/");
$meta_data['instance-id'] = $instance_id = exec($curl_cmd." http://".$meta_host."/latest/meta-data/instance-id/");
$meta_data['availability-zone'] = $reg_az = exec($curl_cmd." http://".$meta_host."/latest/meta-data/placement/availability-zone/");
$meta_data['public-hostname'] = $public_hostname = exec($curl_cmd." http://".$meta_host."/latest/meta-data/public-hostname/");
$meta_data['public-ipv4'] = $public_ipv4 = exec($curl_cmd." http://".$meta_host."/latest/meta-data/public-ipv4/");
$meta_data['local-hostname'] = $local_hostname = exec($curl_cmd." http://".$meta_host."/latest/meta-data/local-hostname/");
$meta_data['local-ipv4'] = $local_ipv4 = exec($curl_cmd." http://".$meta_host."/latest/meta-data/local-ipv4/");
$server_name = $_SERVER['SERVER_NAME'];
$server_ip = $meta_data['public-ipv4'];
$server_software = $_SERVER['SERVER_SOFTWARE'];
$client_ip = $_SERVER['REMOTE_ADDR'];
$client_agent = $_SERVER['HTTP_USER_AGENT'];
$page_title =  'AWS Cloud - ' . $server_name;
$php_self = $_SERVER['SCRIPT_NAME'];

$dbname = 'mariadb';
$dbuser = 'root';
$dbpass = 'MyRDSsimplePassword';
$dbhost = 'mariadb.c02wqcagbcro.us-west-1.rds.amazonaws.com';

/** Check for page refresh, defaults to 5 mins **/
if (empty($_GET['refresh'])) {
	 $page_refresh = 300;
   } else {
	 $page_refresh = $_GET['refresh'];
}

/** find the availability zone **/
 function findAZ ($az) {
	// check if the value is null/empty
	if (empty($az) || !isset($az)) {
	return 'Error: unknown az';
	}
	$az = strtolower($az);
	return $az;		
 } //end function
 
 /** find the region **/
 function findRegion ($region) {
 	// check if the value is null/empty
	if (empty($region) || !isset($region)) {
	return 'Error: unknown region';
	}
	$region = substr($region, 0,-1);
	$region = strtoupper($region);
	return $region;
 } //end function

?>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
	<meta http-equiv="Content-type" content="text/html; charset=UTF-8" />
	<meta http-equiv="Content-Language" content="en-us" />
	<meta http-equiv="imagetoolbar" content="no" />
	<meta name="MSSmartTagsPreventParsing" content="true" />
	<meta name="description" content="Description" />
	<meta name="keywords" content="Keywords" />
</head>

<body class="about">
<div id="page-container">
	<div id="header">
	</div>
	
		<div>
<!--			<h3>AWS  - Region</h3>
			<p><?php echo findRegion($meta_data['availability-zone']); ?></p><br>
		        <h3>Availability Zone</h3>
			<p><?php echo findAZ($meta_data['availability-zone']); ?></p><br> --> 
		</div>
	
	<div id="content">
		<div class="padding">
			<h2>EC2 Metadata</h2>
			<?php
			    //metadata table
			    echo '<table border="0" bgcolor="#ffffff" cellpadding="5" cellspacing="0" width="100%">';
			    echo '<tr><th align="left">Metadata</th><th align="left">Value</th></tr>';
			    foreach($meta_data as $x=>$x_value) {
			       echo '<tr>';
			    	echo '<td nowrap><span class="key">'. $x . '</span></td>';
			            echo '<td no wrap><span class="value">'. $x_value . '</span></td>';
			       echo '</tr>';
			    }
			    echo '</table>';
				?>
		</div>
	</div> <!-- End Content -->

</div> <!-- End Page Container -->
</body>
</html>
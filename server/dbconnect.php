<?php
$servername = "localhost";
$username   = "id18428551_jiehui279096";
$password   = "2386_stuDiYUUM17"; 
$dbname     = "id18428551_cuckoo_app";

$conn = new mysqli($servername, $username, $password, $dbname);
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}
?>
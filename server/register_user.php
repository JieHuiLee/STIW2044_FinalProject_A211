<?php

use PHPMailer\PHPMailer\PHPMailer;
use PHPMailer\PHPMailer\Exception;

require '/fluttermycuckoodb/public_html/PHPMailer/src/Exception.php';
require '/fluttermycuckoodb/public_html/PHPMailer/src/PHPMailer.php';
require '/fluttermycuckoodb/public_html/PHPMailer/src/SMTP.php';

include_once("dbconnect.php");
$user_email = $_POST['email'];
$password = $_POST['password'];
$passha1 = sha1($password);
$otp = rand(1000,9999);
$rating = "0";
$credit = "0";
$status = "active";

$sqlregister = "INSERT INTO tbl_user(user_email,password,otp,rating,credit,status) VALUES('$user_email','$passha1','$otp','$rating','$credit','$status')";
if ($conn->query($sqlregister) === TRUE){
    echo "success";
    sendEmail($otp,$user_email);
}else{
    echo "failed";
}

function sendEmail($otp,$user_email){
    $mail = new PHPMailer(true); 
    $mail->SMTPDebug = 0; 
    $mail->isSMTP(); 
    $mail->Host       = 'mail.jh00.com';
    $mail->SMTPAuth   = true; 
    $mail->Username   = 'smtp@jh00.com'; 
    $mail->Password   = 'P8CxH;6zak.43H';
    $mail->SMTPSecure = 'tls';         
    $mail->Port       = 587;
    
    $from = "smtp@jh00.com";
    $to = $user_email;
    $subject = "From Cuckoo. Please verify your account";
    $message = "<p>Click the below link to verify your account<br><br>
    <a href='http://jh00.com/fluttermycuckoodb/php/verify_account.php?email=".$user_email."&key=".$otp."'>Click Me</a>";
    
    $mail->setFrom($from,"Cuckoo");
    $mail->addAddress($to);
    
    //content
    $mail->isHTML(true);                            
    $mail->Subject = $subject;
    $mail->Body    = $message;
    $mail->send();
    
}    
?>

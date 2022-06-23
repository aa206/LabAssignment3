<?php
if(!isset($_POST)){
    echo "failed";
}

include_once("dbconnect.php");
$email = $_POST['email'];
$password = $_POST['password'];
$sqllogin = "SELECT * FROM registration WHERE myt_email = '$email' AND myt_password = '$password'";
$result = $conn->query($sqllogin);
$numrow = $result->num_rows;

if ($numrow > 0){
    while ($row = $result->fetch_assoc()){
        $user['email'] = $row['myt_email'];
        $user['password'] = $row['myt_password'];
    }
    $response = array('status' => 'success', 'data' => $user);
    sendJsonResponse($response);
} else{
    $response = array('status' => 'error', 'data' => null);
    sendJsonResponse($response);
}

function sendJsonResponse($sentArray){
    header('Content-Type: application/json');
    echo json_encode($sentArray);
}
?>
<?php

include_once("dbconnect.php");

$sqlloadtutors = "SELECT * FROM tbl_tutors";

$result = $conn->query($sqlloadtutors);
if ($result->num_rows > 0){
    $tutors["tutors"] = array();
while ($row = $result->fetch_assoc()){
    $tutorlist = array();
    $tutorlist['tutor_id'] = $row['tutor_id'];
    $tutorlist['tutor_email'] = $row['tutor_email'];
    $tutorlist['tutor_phone'] = $row['tutor_phone'];
    $tutorlist['tutor_name'] = $row['tutor_name'];
    $tutorlist['tutor_description'] = $row['tutor_description'];
    $tutorlist['tutor_datereg'] = $row['tutor_datereg'];

    array_push($tutors["tutors"],$tutorlist);
    }
    $response = array('status' => 'success', 'data' => $tutors);
    sendJsonResponse($response);
}else{
    $response = array('status' => 'error', 'data' => null);
    sendJsonResponse($response);
}

function sendJsonResponse($sentArray){
    header('Content-Type: application/json');
    echo json_encode($sentArray);
}
?>
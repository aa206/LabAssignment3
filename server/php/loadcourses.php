<?php

include_once("dbconnect.php");

$sqlloadcourses = "SELECT * FROM tbl_subjects";

$result = $conn->query($sqlloadcourses);
if ($result->num_rows > 0) {
    $subjects["subjects"] = array();
while ($row = $result->fetch_assoc()) {
    $subjectlist = array();
    $subjectlist['subject_id'] = $row['subject_id'];
    $subjectlist['subject_name'] = $row['subject_name'];
    $subjectlist['subject_description'] = $row['subject_description'];
    $subjectlist['subject_price'] = $row['subject_price'];
    $subjectlist['subject_sessions'] = $row['subject_sessions'];
    $subjectlist['subject_rating'] = $row['subject_rating'];

    array_push($subjects["subjects"],$subjectlist);
    }
    $response = array('status' => 'success', 'data' => $subjects);
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
<?php

try{
    $connect = new mysqli('127.0.0.1', 'root', 'root', 'aws_db');
}
catch(Exception $e){
    echo $e->getMessage();
}

if(!$connect){
    die('Could not connect: '.mysqli_connect_error());
}

$connect->set_charset("utf8");

$sql = "SELECT * FROM teste";
$result = mysqli_query($connect, $sql);
if(!$result){
    die('Could not get data: '.mysqli_error($connect));
}

while($row = mysqli_fetch_array($result)){
    echo $row['id'].' '.$row['teste'].' '.$row['createad_at'].PHP_EOL;
}
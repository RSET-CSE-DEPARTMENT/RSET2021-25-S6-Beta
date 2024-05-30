<?php

if(isset($_POST["submit"]))
{
    //Grabbing the data
    $username = $_POST["username"];
    $password = $_POST["password"];
    
    $conn=new mysqli('localhost','root','','ac')
    if($conn->connect_error){
        die('Connection Failed : '.$conn->connect_error);
    }else{
        $stmt = $conn->prepare("insert into users(username,password)
        values(?,?)");
        $stmt->bind_param("ss",$username,$password);
        $stmt->execute();
        echo "login successfull..";
        $stmt->close();
        $conn->close();
    }
    //Instantiate SignupContr class

    //Running error handlers and user signup

    //Going back to front page
}
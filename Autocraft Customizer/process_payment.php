<?php
$cardnumber = filter_input(INPUT_POST, 'card_number');
$expiry = filter_input(INPUT_POST, 'expiry_date');
$cvv = filter_input(INPUT_POST, 'cvv');
//$amount = filter_input(INPUT_POST, 'amount');
$file = 'data1.txt';
$cost = file_get_contents($file);
$file = 'data.txt';
$username = file_get_contents($file);
if (!empty($cardnumber))
{
    if (!empty($expiry))
    {
        if(!empty($cvv))
        {
            if(!empty($cvv))
            {
        $host = "localhost";
        $dbusername = "root";
        $dbpassword = "";
        $dbname = "ac";
        $conn =new mysqli($host,$dbusername,$dbpassword,$dbname);
        if(mysqli_connect_error()){
            die('Connect Error('.mysqli_connect_errno().')'.mysqli_connect_error());
            }
        else{
            $file = 'data1.txt';
            $cost = file_get_contents($file);
            $sql = "INSERT INTO payment ( username, card_number, expiry_date,cvv,amount) values ('$username','$cardnumber','$expiry','$cvv','$cost')";
            if($conn->query($sql)){
                header("Location: succesfull.html");
                exit;
            }
            else{
                echo "Error:".$sql."<br>".$conn->error;
            }
        $conn->close();
            }
            }
        }
    }
    // Create connection
    else
    {
    echo "Password should not be empty";
    die();
    }
}
else
{
    echo "Username should not be empty";
    die();
}
?>
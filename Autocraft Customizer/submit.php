<?php
$paint = filter_input(INPUT_POST, 'paint');
$alloy = filter_input(INPUT_POST, 'alloy');
$interior = filter_input(INPUT_POST, 'interior');
$upholstery = filter_input(INPUT_POST, 'upholstery');
$seat = filter_input(INPUT_POST, 'seat');
$file = 'data.txt';
$username = file_get_contents($file);
if (!empty($paint))
{
    if (!empty($alloy))
    {
        if(!empty($interior))
        {
            if(!empty($upholstery))
            {
                if(!empty($seat))
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
            $cost = $paint + $alloy + $interior + $upholstery + $seat + 1500000;
            $file = 'data1.txt';
            file_put_contents($file, $cost);
            $sql = "INSERT INTO cart (username, paint, alloy, interior, upholstery, seat, cost) values ('$username','$paint','$alloy','$interior','$upholstery','$seat','$cost')";
            if($conn->query($sql)){
                header("Location: payment.php");
                exit;
            }
            else{
                echo "Error:".$sql."<br>".$conn->error;
            }
        $conn->close();
            }
            }
            else{
                echo "Please select an option from each segment.";
                die(); 
            }
        }
        else{
            echo "Please select an option from each segment.";
            die();
        }
    }
    // Create connection
    else
    {
    echo "Please select an option from each segment.";
    die();
    }
}
else
{
    echo "Please select an option from each segment.";
    die();
}
}
else{
    echo "Please select an option from each segment.";
                die();
}
?>
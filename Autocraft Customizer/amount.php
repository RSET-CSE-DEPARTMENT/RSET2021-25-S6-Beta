<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Button in PHP</title>
</head>
<body>
    <?php
    $host = "localhost";
    $dbusername = "root";
    $dbpassword = "";
    $dbname = "ac";
    $conn =new mysqli($host,$dbusername,$dbpassword,$dbname);
    if(mysqli_connect_error()){
        die('Connect Error('.mysqli_connect_errno().')'.mysqli_connect_error());
        }
    else{
        $file='data1.txt';
        $cost=file_get_contents($file);
        echo "Total amount is : "; 
        echo $cost;
    }

    // Example button
    echo '<button type="button">Click Me!</button>';
    ?>
</body>
</html>
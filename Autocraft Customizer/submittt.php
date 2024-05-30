<?php
// Check if form is submitted
if ($_SERVER["REQUEST_METHOD"] == "POST") {
    // Establish connection to your database
    $host = "localhost";
    $dbusername = "root";
    $dbpassword = "";
    $dbname = "ac";
    $conn =new mysqli($host,$dbusername,$dbpassword,$dbname);

    // Check connection
    if(mysqli_connect_error()){
        die('Connect Error('.mysqli_connect_errno().')'.mysqli_connect_error());
        }
    else{
        $sql = "INSERT INTO payment ( card_number, expiry_date,cvv,amount) values ('$cardnumber','$expiry','$cvv','$amount')";
        if($conn->query($sql)){
            header("Location: succesfull.html");
            exit;
        }
        else{
            echo "Error:".$sql."<br>".$conn->error;
        }
    $conn->close();
        }
    $paint = $_POST["paint"];
    $sql = "INSERT INTO cart (paint, alloy, interior, upholstery, seat) VALUES ('$paint', '$','$','$','$','$')";
    if ($conn->query($sql) === TRUE) {
        //echo "New record created successfully";
        header("Location: payment.html");
        exit;
    } else {
        echo "Error: " . $sql . "<br>" . $conn->error;
    }
    // Close database connection
    $conn->close();
}
?>
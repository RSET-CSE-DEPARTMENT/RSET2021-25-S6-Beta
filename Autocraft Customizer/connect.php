<?php
$username = filter_input(INPUT_POST, 'username');
$password = filter_input(INPUT_POST, 'password');
$file = 'data.txt';
file_put_contents($file, $username);
if (!empty($username) && !empty($password)) {
    $host = "localhost";
    $dbusername = "root";
    $dbpassword = "";
    $dbname = "ac";
    $conn = new mysqli($host, $dbusername, $dbpassword, $dbname);
    if(mysqli_connect_error()) {
        die('Connect Error (' . mysqli_connect_errno() . ') ' . mysqli_connect_error());
    } else {
        $sql = "SELECT * FROM users WHERE username = ?";
        $stmt = $conn->prepare($sql);
        $stmt->bind_param("s", $username);
        $stmt->execute();
        $result = $stmt->get_result();

        if ($result->num_rows > 0) {
            $user = $result->fetch_assoc();
            if ($password==$user['password']) {
                header("Location: preview.html");
                exit;
            } else {
                echo "Invalid password";
            }
        } else {
            echo "User not found";
        }
        $stmt->close();
        $conn->close();
    }
} else {
    echo "Username or password should not be empty";
}
?>

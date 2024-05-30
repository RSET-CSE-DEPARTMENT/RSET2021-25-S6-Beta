    <?php
    $username = filter_input(INPUT_POST, 'username');
    $Email = filter_input(INPUT_POST, 'Email');
    $password = filter_input(INPUT_POST, 'password');
    $rpassword = filter_input(INPUT_POST, 'rpassword');
    if (!empty($username))
    {
        if (!empty($Email))
        {
            if(!empty($password))
            {
                if(!empty($rpassword))
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
                $sql = "INSERT INTO users ( username, Email, password, rpassword) values ('$username','$Email','$password','$rpassword')";
                if($conn->query($sql)){
                    header("Location: autocraftcustomizer.html#customize");
                    exit;
                }
                else{
                    echo "Error:".$sql."<br>".$conn->error; 
                }
            $conn->close();
                }
                }
                else{
                    echo "Confirm password";
                    die();
                }
            }
            else{
                echo "Password Should not be empty";
                die();
            }
        }
        // Create connection
        else
        {
        echo "Email should not be empty";
        die();
        }
    }
    else
    {
        echo "Username should not be empty";
        die();
    }
    ?>
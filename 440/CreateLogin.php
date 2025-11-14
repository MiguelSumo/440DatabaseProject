<?php 
    echo "<!DOCTYPEHTML>\n";
    ini_set('display_errors', '1');
    ini_set('display_startup_errors', '1');
    error_reporting(E_ALL);
    require_once "DatabaseConnection.php";
    $conn = "mysql:host=".Conn_Host.";dbname=".Conn_Database.";ccharset=utf8mb4";
    $options = [
        \PDO::ATTR_ERRMODE            => \PDO::ERRMODE_EXCEPTION,
        \PDO::ATTR_DEFAULT_FETCH_MODE => \PDO::FETCH_ASSOC,
        \PDO::ATTR_EMULATE_PREPARES   => false,
    ];
    $pdo = new PDO($conn, Conn_Username, Conn_Password,$options);
?>
<html>
    <head>
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    </head>
    <body>
        <form id="createLoginForm" style="text-align: center">
            <h2>Create a New Login</h2>
            Firstname: <input type="text" name="firstname"><br><br>
            Middle Initial: <input type="text" name="middleinitial" maxlength="1" size="1"><br><br>
            Lastname: <input type="text" name="lastname"><br><br>
            Suffix: <input type="text" name="suffix"><br><br>
            Email: <input type="text" name="email"><br><br>
            Phone Number: <input type="text" name="phonenumber"><br><br>

            <p id="error" style="color: red;text-align:center"></p>
            Username: <input type="text" name="newusername"><br><br>
            Password: <input type="password" name="newpassword"><br><br>
            <input type="button" id="createLoginButton" value="Create Login">
        </form>
        <script>
            $("#createLoginButton").click(function(){
                var username = $(this).find('input[name="newusername"]').val();
                var password = $(this).find('input[name="newpassword"]').val();
                if (username === "" || password === ""){
                    $("#error").text("Please enter both a username and password.");
                    return;
                }
                $.ajax({
                    type: "POST",
                    url: "CreateLoginHandler.php",
                    data: $("#createLoginForm").serialize(),
                    success: function(data){
                        alert("Login created successfully!");
                        window.location.href = "index.html";
                    },
                    error: function(data){
                        $("#error").text("Error creating login. Please try again." . data.responseText);
                    }
                });
            });
        </script>
    </body>


</html>
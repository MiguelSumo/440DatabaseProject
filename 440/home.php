<?php 
    session_start();
    if (!isset($_SESSION['userid'])){
        header('Location: index.php');
    }
echo "<!DOCTYPE html>"; 
?>
<html>
    <head>
        <title>Home Page</title>
    <body>
        <h1> Hello World! This is the home page.
            <div style="text-align: right"> 
                <input type="button" value="Logout" onclick="window.location.href='logout.php'">
            </div>
        </h1>

    </body>

</html>
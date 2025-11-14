<?php session_start(); ?>
<!DOCTYPE HTML>
<html> 
    <head>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js" type="text/javascript"></script>
        <title>
            CIS 440 Car Rental Project
        </title>
    </head>
    <body>
        <h1 style="text-align: center"> Welcome to the 440 Car Rental Project! </h1>
        <h3 style="text-align: center"> Please log in to continue. </h3>
        <p style="text-align: center" id="enteruname"> </p>
        <form id="loginform" method="post" style="text-align: center">
            Username: <input type="text" name="username"><br><br>
            Password: <input type="password" name="password"><br><br>
            <input type="submit" value="Login">
        </form>
        <p style="text-align: center"><input type="button" value="CreateLogin" id="MakeLogin"></p>
        <script type="text/javascript">
            $("#loginform").submit(function(e) {
                e.preventDefault();
                if ($(this).find('input[name="username"]').val() == "" || $(this).find('input[name="password"]').val() == "" ){
                    $("#enteruname").text("Please enter both a username and password.");
                    return;
                }
                $.ajax({
                    type: "POST",
                    url: "login.php",
                    data: $("#loginform").serialize(),
                    success: function(data){
                        window.location.href=data;
                    }
                       
                });
            });        
            $("#MakeLogin").click(function(){
                window.location.href = "CreateLogin.php";
            });
        </script>
    </body>
</html>
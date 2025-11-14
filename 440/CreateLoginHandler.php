<?php 
    ini_set('display_errors', '1');
    ini_set('display_startup_errors', '1');
    error_reporting(E_ALL);
    require_once 'DatabaseConnection.php';
    $conn = "mysql:host=".Conn_Host.";dbname=".Conn_Database.";charset=utf8mb4";
    $options = [
        \PDO::ATTR_ERRMODE            => \PDO::ERRMODE_EXCEPTION,
        \PDO::ATTR_DEFAULT_FETCH_MODE => \PDO::FETCH_ASSOC,
        \PDO::ATTR_EMULATE_PREPARES   => false,
    ];
    $_POST = json_decode(file_get_contents("php://input"), true);
    $pdo = new PDO($conn, Conn_Username, Conn_Password,$options);
    $sql = "call CreateUser(?,?,?,?,?,?,?,?);";
    $stm = $pdo->prepare($sql);
    $stm->bindParam(1,$_POST['firstname'],PDO::PARAM_STR);
    $stm->bindParam(2,$_POST['middleinitial'],PDO::PARAM_STR);
    $stm->bindParam(3,$_POST['lastname'],PDO::PARAM_STR);
    $stm->bindParam(4,$_POST['suffix'],PDO::PARAM_STR);
    $stm->bindParam(5,$_POST['email'],PDO::PARAM_STR);
    $stm->bindParam(6,$_POST['phonenumber'],PDO::PARAM_STR,10);
    $stm->bindParam(7,$_POST['newusername'],PDO::PARAM_STR);
    $passwordhash = password_hash($_POST['newpassword'], PASSWORD_BCRYPT);
    $stm->bindParam(8,$passwordhash,PDO::PARAM_STR);
    $stm->execute();
?>
<?php 
    session_start();
    ob_start();
    $options = [
        \PDO::ATTR_ERRMODE            => \PDO::ERRMODE_EXCEPTION,
        \PDO::ATTR_DEFAULT_FETCH_MODE => \PDO::FETCH_ASSOC,
        \PDO::ATTR_EMULATE_PREPARES   => false,
    ];
    require_once 'DatabaseConnection.php';
    $conn = "mysql:host=".Conn_Host.";dbname=".Conn_Database.";ccharset=utf8mb4";
    $pdo = new PDO($conn, Conn_Username, Conn_Password,$options);
    $sql = "call GetUser(?,?,?,?);";
    $stm = $pdo->prepare($sql);
    $stm->bindParam(1, $_POST['username'], PDO::PARAM_STR);
    $stm->bindParam(2, $password, PDO::PARAM_STR);
    $stm->bindParam(3, $userid, PDO::PARAM_INT);
    $stm->bindParam(4, $priv,PDO::PARAM_STR);
    $stm->execute();
    $results = $stm->fetch();
    if (password_verify($_POST['password'], $results['pword'])){;
        $_SESSION['userid'] = $results['uid'];
        $_SESSION['privilege'] = $results['priv'];
        if ($_SESSION['privilege'] === 'p'){
            echo "home.php";
            die();
        }
        else if ($_SESSION['privilege'] === 'e'){
            echo "data.php";
            die();
        }
    } else {
        header("HTTP/1.1 304 Not Modified");
        die("0");
    }
?>
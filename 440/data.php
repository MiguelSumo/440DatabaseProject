<?php
    session_start();
    if (!isset($_SESSION['privilege']) || $_SESSION['privilege'] !== 'e'){
        header('Location: index.php');
    }
    echo "<!DOCTYPEHTML>\n";
    require_once "DatabaseConnection.php";
    $conn = new mysqli(Conn_Host, Conn_Username, Conn_Password, Conn_Database);
    if ($conn->connect_error){
        die("Failed to connect to MySQL Database: ". $conn->connect_error);
    }
    $sql = "Call GetRevenueByLocation();";
    $results = $conn->query($sql);
    echo "<html>\n";
    echo "
        <table border='1' id='phones'>
        <tbody>
        <tr>
        <th><b>Revenue By Location<b></th>
        <th><b>1</b></th>
        <th><b>2</b></th>
        <th><b>3</b></th>
        <th><b>4</b></th>
        <th><b>5</b></th>";
        while($row = mysqli_fetch_array($results)){
            echo "<tr>";
            echo "<td>".$row['']."</td>";
            echo "<td>".$row['1']."</td>";
            echo "<td>".$row['2']."</td>";
            echo "<td>".$row['3']."</td>";
            echo "<td>".$row['4']."</td>";
            echo "<td>".$row['5']."</td>";
            echo "</tr>";
        }
        echo "</tbody>\n";
        echo "</table>\n";
        echo "<br><br>\n";
        echo "<input type='button' value='Logout' onclick=\"window.location.href='logout.php'\">\n";
    echo "</html>";
?>

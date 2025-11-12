<?php
    echo "<!DOCTYPEHTML>\n";
    ini_set('display_errors', '1');
    ini_set('display_startup_errors', '1');
    error_reporting(E_ALL);
    require_once "DatabaseConnection.php";
    $conn = new mysqli(Conn_Host, Conn_Username, Conn_Password, Conn_Database);
    if ($conn->connect_error){
        die("Failed to connect to MySQL Database: ". $conn->connect_error);
    }
    $sql = "Select * from phones;";
    $results = $conn->query($sql);
    echo "<html>\n";
    echo "
        <table border='1' id='phones'>
        <tbody>
        <tr>
        <th><b>Phoneid<b></th>
        <th><b>PartyID</b></th>
        <th><b>PhoneType</b></th>
        <th><b>CountryCode</b></th>
        <th><b>PhoneNumber</b></th>";
        while($row = mysqli_fetch_array($results)){
            echo "<tr>";
            echo "<td>".$row['PhoneID']."</td>";
            echo "<td>".$row['PartyID']."</td>";
            echo "<td>".$row['PhoneType']."</td>";
            echo "<td>".$row['CountryCode']."</td>";
            echo "<td>".$row['PhoneNumber']."</td>";
            echo "</tr>";
        }
        echo "</tbody>\n";
        echo "</table>\n";
    echo "</html>";
?>

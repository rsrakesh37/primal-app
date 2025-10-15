<?php
// Check PHP configuration and available extensions
echo "<h2>PHP Configuration Check</h2>";
echo "<strong>PHP Version:</strong> " . phpversion() . "<br>";
echo "<strong>Server:</strong> " . $_SERVER['SERVER_SOFTWARE'] . "<br><br>";

echo "<h3>PDO Extensions:</h3>";
if (extension_loaded('pdo')) {
    echo "✅ PDO: Available<br>";
    $drivers = PDO::getAvailableDrivers();
    echo "<strong>Available PDO Drivers:</strong><br>";
    foreach ($drivers as $driver) {
        echo "- " . $driver . "<br>";
    }
} else {
    echo "❌ PDO: Not Available<br>";
}

echo "<br><h3>MySQL Extensions:</h3>";
echo extension_loaded('mysql') ? "✅ MySQL: Available<br>" : "❌ MySQL: Not Available<br>";
echo extension_loaded('mysqli') ? "✅ MySQLi: Available<br>" : "❌ MySQLi: Not Available<br>";
echo extension_loaded('pdo_mysql') ? "✅ PDO MySQL: Available<br>" : "❌ PDO MySQL: Not Available<br>";

echo "<br><h3>All Loaded Extensions:</h3>";
$extensions = get_loaded_extensions();
sort($extensions);
foreach ($extensions as $ext) {
    echo "- " . $ext . "<br>";
}

// Check if we can use MySQLi as alternative
echo "<br><h3>Alternative Connection Test:</h3>";
if (extension_loaded('mysqli')) {
    echo "✅ MySQLi is available - we can use this as alternative<br>";
} else {
    echo "❌ No MySQL extensions available<br>";
}
?>
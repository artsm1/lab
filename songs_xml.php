<?php
$songs = "songs.txt";
$songs_shuffled = "songs_shuffled.txt";

if (!isset($_SERVER["REQUEST_METHOD"]) || $_SERVER["REQUEST_METHOD"] != "GET") {
	header("HTTP/1.1 400 Invalid Request");
	die("ERROR 400: Invalid request - This service accepts only GET requests.");
}

$top = "";

if (isset($_REQUEST["top"])) {
	$top = preg_replace("/[^0-9]*/", "", $_REQUEST["top"]);
}

if (!file_exists($songs)) {
	header("HTTP/1.1 500 Server Error");
	die("ERROR 500: Server error - Unable to read input file: $songs");
}

header("Content-type: application/xml");

print "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n";
print "<songs>\n";

// $lines = file($songs_shuffled);
// for($j=0;$j<$top;$j++){
// 	for($i=0;$i<count($lines);$i++){
// 		list($title, $artist, $rank, $genre, $time) = explode("|", trim($lines[$i]));
// 		if($rank == $j+1){
// 			print "\t<song rank=\"$rank\">\n";
// 			print "\t\t<title>$title</title>\n";
// 			print "\t\t<artist>$artist</artist>\n";
// 			print "\t\t<genre>$genre</genre>\n";
// 			print "\t\t<time>$time</time>\n";
// 			print "\t</song>\n";
// 		}
// 	}
// }

$lines = file($songs);
for ($i = 0; $i < count($lines); $i++) {
	list($title, $artist, $rank, $genre, $time) = explode("|", trim($lines[$i]));
	if ($rank <= $top) {
		print "\t<song rank=\"$rank\">\n";
		print "\t\t<title>$title</title>\n";
		print "\t\t<artist>$artist</artist>\n";
		print "\t\t<genre>$genre</genre>\n";
		print "\t\t<time>$time</time>\n";
		print "\t</song>\n";
	}
}

print "</songs>";

?>

<?php 
    if(strlen($_REQUEST['Digits'])) {
        switch($_REQUEST['Digits']) {
            case 1: 
                header("Location: listener.php");
                die;
            case 2: 
                header("Location: speaker.php");
                die;
            case 3: 
                header("Location: moderator.php");
                die;
        }
    }
?>
<Response>
    <Gather numDigits="1" action="menu.php">
        <Say>Press 1 to join as a listener</Say>
        <Say>Press 2 to join as a speaker</Say>
        <Say>Press 3 to join as a moderator</Say>
    </Gather>
</Response>
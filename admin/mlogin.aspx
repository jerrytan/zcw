<%@ Page Language="C#" EnableViewStateMac="false" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8" />
    <title></title>
    <script src="jquery.terminal/jquery-1.7.1.min.js" type="text/javascript"></script>
    <script src="jquery.terminal/jquery.mousewheel-min.js" type="text/javascript"></script>
    <script src="jquery.terminal/jquery.terminal-min.js" type="text/javascript"></script>
    <link href="jquery.terminal/jquery.terminal.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript">
        jQuery(document).ready(function ($) {
            $('body').terminal("Ashx/Manager.ashx", {
                login: true,
                greetings: "You are authenticated",
                onBlur: function () {
                    // the height of the body is only 2 lines initialy
                    return false;
                }
            });
        });
    </script>
</head>
<body>
</body>
</html>

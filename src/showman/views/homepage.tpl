<!DOCTYPE html>

<html>
	<head>{{template "header.html" .}}
        <style>
        .center-outer {
            position: absolute;
            top: 50%;
            left: 50%;
            margin-left: -50px;
            margin-top: -50px;
            width: 100px;
            height: 100px;
            display: table;
            border: thin solid #888;
            border-radius: 50%;
        }
        .center-outer:hover {
            background: #000;
            color: #fff;
        }
        .center-inner {
            display: table-cell;
            width: 100%;
            height: 100%;
            vertical-align: middle;
            text-align: center;
        }
        </style>
    </head>
  	<body style="margin-top: 50px">
        {{template "fragments/navbar.html" .}}
        <a href="/index">
        <div class="center-outer">
            <div class="center-inner">
                <i class="fa fa-bolt fa-2x"></i>
            </div>
        </div>
        </a>
	</body>
</html>

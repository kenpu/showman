<!DOCTYPE html>

<html>
    <head>{{template "header.html" .}}</head>
    <body style="margin-top: 50px;">
        {{template "fragments/navbar.html" .}}
        <ul navbar style="display:none">
            <li class="active"><a href="#">({{.Filename}})</a></li>
        </ul>

        <lego></lego>
            
        <script>
        requirejs(["jquery", "angular", "js/ng/directives", "js/ng/controllers"], function($, angular) {
            angular.module("app", ["commonDirectives", "commonControllers"]);
            angular.bootstrap($("html"), ["app"])
        });
        </script>
    </body>
</html>

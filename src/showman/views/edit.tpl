<!DOCTYPE html>

<html>
    <head>{{template "header.html" .}}</head>
    <body>
        <div class="container">
            <h1 style="font-size: 16pt; font-weight: bold; border-bottom: thin solid #888">{{.filename}}</h1>    

            <editor filename="{{.filename}}"></editor>
        </div>
        <script>
        requirejs(["jquery", "angular", "js/ng/directives"], function($, angular) {
            angular.module("app", ["commonDirectives"]);
            angular.bootstrap($("html"), ["app"])
        });
        </script>
    </body>
</html>

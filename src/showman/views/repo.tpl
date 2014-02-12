<html>
    {{template "header.html" .}}
    <body style="margin-top: 50px">
        {{template "fragments/navbar.html" .}}

        <div class="container">
            <h1 style="font-size: 16pt; font-weight: bold; border-bottom: thin solid black">Articles</h1>

            <filelist resource="/index/"></filelist>
        </div>
        <script>
        requirejs(["jquery", "angular", "js/ng/directives"], function($, angular) {
            angular.module("app", ["commonDirectives"]);
            angular.bootstrap($("html"), ["app"])
        });
        </script>
    </body>
</html>
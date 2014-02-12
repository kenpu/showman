<!doctype html>
<html>
<head>
    {{template "header.html" .}}
    <script>requirejs(["js/content"]);</script>
</head>
<body>
    <h1> Content </h1>

{{.Content}}

    <hr>
    <script>
    var C = {{.ContentJS}};
    </script>
</body>
</html>
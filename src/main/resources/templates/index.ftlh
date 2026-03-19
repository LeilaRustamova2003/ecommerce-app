<!DOCTYPE html>
<html lang="ka">
<head>
    <meta charset="UTF-8">
    <title>E-Commerce Project</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            margin: 50px;
            background-color: #f4f7f6;
            color: #333;
        }
        .container {
            background-color: #fff;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0,0,0,0.1);
            max-width: 600px;
        }
        h1 { color: #2c3e50; border-bottom: 2px solid #3498db; padding-bottom: 10px; }
        .info-box { margin-top: 20px; font-size: 1.2em; }
        .label { font-weight: bold; color: #3498db; }
    </style>
</head>
<body>

<div class="container">
    <h1>პროექტის სტატუსი / Project Status</h1>

    <div class="info-box">
        <p>${message}</p>

        <p>
            <span class="label">სტუდენტი / Student:</span>
            ${student}
        </p>

        <p>
            <span class="label">თარიღი / Date:</span>
            2026-03-19
        </p>
    </div>
</div>

</body>
</html>
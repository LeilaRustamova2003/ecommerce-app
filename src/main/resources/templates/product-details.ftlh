<!DOCTYPE html>
<html xmlns:th="http://www.thymeleaf.org">
<head>
    <meta charset="UTF-8">
    <title th:text="${product.name}">Product</title>
    <style>
        * { box-sizing:border-box; margin:0; padding:0; font-family:Arial,sans-serif; }
        body { background:#eaeded; padding:20px; }
        .lang-bar { margin-bottom:10px; font-size:13px; }
        .lang-bar a { color:#007185; text-decoration:none; margin-right:10px; }
        .container { background:white; max-width:900px; margin:auto; display:flex; gap:30px; padding:25px; border-radius:4px; }
        .price { color:#B12704; font-size:26px; font-weight:bold; margin:15px 0; }
        .btn-atc { background:#ffd814; border:1px solid #fcd200; border-radius:20px; padding:12px 25px; cursor:pointer; font-weight:bold; }
        .info-box { margin-top:20px; background:#f7f7f7; padding:15px; border-radius:8px; }
    </style>
</head>
<body>
<div class="lang-bar">
    <a th:href="@{/product/{id}(id=${product.id},lang=ka)}" th:text="#{lang.ka}">ქართული</a>
    <a th:href="@{/product/{id}(id=${product.id},lang=en)}" th:text="#{lang.en}">English</a>
</div>
<a href="/" style="color:#007185;text-decoration:none;display:block;margin-bottom:15px;" th:text="#{product.back}">← Back</a>
<div class="container">
    <div><img th:src="${product.imageUrl}" th:alt="${product.name}" style="max-width:350px;max-height:350px;object-fit:contain;"></div>
    <div>
        <h1 th:text="${product.name}">Name</h1>
        <p style="margin:8px 0;color:#555;">
            <span th:text="#{product.category}">Category</span>: <strong th:text="${product.category}"></strong>
        </p>
        <div class="price" th:text="${product.price} + ' GEL'"></div>
        <p><span th:text="#{product.stock}">Stock</span>: <span th:text="${product.stock}"></span></p>
        <button class="btn-atc" onclick="alert('Added!')" style="margin-top:15px;">
            <span th:text="#{product.add_to_cart}">Add to Cart</span>
        </button>
        <div class="info-box">
            <h3 th:text="#{product.description}">Description</h3>
            <p style="margin-top:8px;" th:text="${product.description}"></p>
        </div>
    </div>
</div>
</body>
</html>
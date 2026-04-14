<!DOCTYPE html>
<html lang="ka">
<head>
    <meta charset="UTF-8">
    <title>${product.name!''}</title>
    <style>
        * { box-sizing: border-box; margin: 0; padding: 0; font-family: Arial, sans-serif; }
        body { background: #eaeded; padding: 20px; }
        .container { background: white; max-width: 900px; margin: auto; display: flex; gap: 30px; padding: 25px; border-radius: 4px; }
        .price { color: #B12704; font-size: 26px; font-weight: bold; margin: 15px 0; }
        .btn-atc { background: #ffd814; border: 1px solid #fcd200; border-radius: 20px; padding: 12px 25px; cursor: pointer; font-weight: bold; }
    </style>
</head>
<body>
<a href="/" style="color: #007185; text-decoration: none; display: block; margin-bottom: 20px;">← უკან დაბრუნება</a>
<div class="container">
    <div class="image-box"><img src="${product.imageUrl!''}" style="max-width:350px;"></div>
    <div>
        <h1>${product.name!'Product'}</h1>
        <p>კატეგორია: ${product.category!''}</p>
        <div class="price">${(product.price!0)?c} GEL</div>

        <button class="btn-atc" onclick="addToCartAndGoBack()">კალათაში დამატება</button>

        <div style="margin-top:20px; background:#f7f7f7; padding:15px; border-radius:8px;">
            <h3>აღწერა:</h3>
            <p>ეს არის ${product.name!''}. მაღალი ხარისხის პროდუქტი.</p>
        </div>
    </div>
</div>

<script>
        function addToCartAndGoBack() {
            alert("პროდუქტი დამატებულია! (Product added!)");
            window.location.href = "/"; // Sepeti görmek için ana sayfaya döner
        }
    </script>
</body>
</html>
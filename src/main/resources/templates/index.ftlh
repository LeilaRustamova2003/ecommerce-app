<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>SmartShop | Premium Electronics</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600&display=swap" rel="stylesheet">

    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; font-family: 'Poppins', sans-serif; }
        body { background-color: #f4f7f6; color: #333; }

        /* Modern Navbar - Koyu Mavi */
        header {
            background-color: #002d5b;
            padding: 15px 5%;
            color: white;
            display: flex;
            justify-content: space-between;
            align-items: center;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
        .logo { font-size: 26px; font-weight: 600; color: #00d4ff; letter-spacing: 1px; }
        .user-info { font-size: 14px; text-align: right; }
        .user-info b { color: #00d4ff; }

        .container { max-width: 1200px; margin: 40px auto; padding: 0 20px; }
        h2 { margin-bottom: 30px; font-size: 32px; color: #002d5b; border-bottom: 3px solid #00d4ff; display: inline-block; padding-bottom: 5px; }

        /* Ürün Kartları */
        .product-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
            gap: 25px;
        }

        .product-card {
            background: white;
            padding: 25px;
            border-radius: 12px;
            display: flex;
            flex-direction: column;
            border: 1px solid #eee;
            transition: all 0.3s ease;
        }
        .product-card:hover {
            transform: translateY(-10px);
            box-shadow: 0 10px 20px rgba(0,0,0,0.08);
            border-color: #00d4ff;
        }

        .product-name { font-size: 20px; font-weight: 600; margin-bottom: 12px; color: #002d5b; }
        .product-desc { font-size: 14px; color: #666; margin-bottom: 20px; line-height: 1.6; flex-grow: 1; }
        .product-price { font-size: 22px; font-weight: 600; color: #2ecc71; margin-bottom: 20px; }

        /* SmartShop Mavisi Buton */
        .add-btn {
            background-color: #00d4ff;
            color: #002d5b;
            border: none;
            border-radius: 8px;
            padding: 12px;
            cursor: pointer;
            font-weight: 600;
            transition: background 0.3s;
        }
        .add-btn:hover { background-color: #0099cc; color: white; }
    </style>
</head>
<body>

<header>
    <div class="logo">SmartShop.ge</div>
    <div class="user-info">
        Welcome, <b>${userName}</b><br>
        <span>Member of TSU Tech Group</span>
    </div>
</header>

<div class="container">
    <h2>New Arrivals</h2>

    <div class="product-grid">
        <#list productList as product>
        <div class="product-card">
            <div class="product-name">${product.name}</div>
            <div class="product-desc">${product.description}</div>
            <div class="product-price">${product.price} GEL</div>
            <button class="add-btn">Buy Now</button>
        </div>
    </#list>
</div>
</div>

</body>
</html>
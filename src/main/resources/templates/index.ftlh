<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>SmartShop | Premium Electronics</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">

    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; font-family: 'Poppins', sans-serif; }
        body { background: #f0f2f5; color: #1a1a1a; min-height: 100vh; }

        /* --- Navigation & User Info --- */
        header {
            background-color: #131921;
            padding: 10px 5%;
            color: white;
            display: flex;
            justify-content: space-between;
            align-items: center;
            position: sticky;
            top: 0;
            z-index: 1000;
        }
        .logo { font-size: 22px; font-weight: 700; color: #febd69; text-decoration: none; }
        .nav-right { display: flex; gap: 20px; align-items: center; }
        .user-panel { font-size: 13px; text-align: right; }
        .user-panel b { color: #febd69; display: block; font-size: 15px; }

        /* --- Search Bar Section --- */
        .search-wrapper { background: #232f3e; padding: 10px 5%; display: flex; gap: 10px; }
        .search-input { flex: 1; padding: 10px 15px; border-radius: 4px; border: none; outline: none; font-size: 14px; }
        .search-submit { background: #febd69; border: none; padding: 10px 20px; border-radius: 4px; cursor: pointer; font-weight: 600; }

        /* --- Shopping Cart UI --- */
        .cart-trigger { position: relative; cursor: pointer; background: none; border: none; color: white; font-size: 24px; }
        .cart-badge {
            position: absolute; top: -5px; right: -8px;
            background: #f08804; color: black; font-size: 12px;
            padding: 2px 6px; border-radius: 50%; font-weight: bold;
        }

        /* --- Sidebar Cart Panel --- */
        #cartSidebar {
            position: fixed; right: -350px; top: 0; width: 320px; height: 100%;
            background: white; box-shadow: -5px 0 15px rgba(0,0,0,0.2);
            transition: 0.3s ease-in-out; z-index: 2000; padding: 20px;
            display: flex; flex-direction: column;
        }
        #cartSidebar.active { right: 0; }
        .cart-header { border-bottom: 2px solid #131921; padding-bottom: 15px; margin-bottom: 15px; display: flex; justify-content: space-between; align-items: center; }
        .cart-items { flex: 1; overflow-y: auto; }
        .cart-item { display: flex; justify-content: space-between; padding: 12px 0; border-bottom: 1px solid #eee; align-items: center; font-size: 13px; }
        .delete-item { color: #007185; cursor: pointer; font-weight: 600; border: none; background: none; font-size: 11px; }

        /* --- Product Grid & Cards --- */
        .container { max-width: 1200px; margin: 30px auto; padding: 0 15px; }
        .product-grid { display: grid; grid-template-columns: repeat(auto-fill, minmax(240px, 1fr)); gap: 20px; }

        .product-card {
            background: white; padding: 20px; border-radius: 8px;
            display: flex; flex-direction: column;
            border: 1px solid #ddd; transition: 0.2s; position: relative;
        }
        .product-card:hover { box-shadow: 0 4px 12px rgba(0,0,0,0.1); }

        .sale-badge { position: absolute; top: 10px; right: 10px; background: #e74c3c; color: white; padding: 3px 8px; border-radius: 4px; font-size: 11px; font-weight: bold; }
        .category-tag { font-size: 11px; color: #007185; font-weight: 600; text-transform: uppercase; margin-bottom: 8px; }
        .product-image { width: 100%; height: 150px; object-fit: contain; margin-bottom: 10px; }
        .product-name { font-size: 15px; font-weight: 600; height: 45px; overflow: hidden; margin-bottom: 10px; }

        .current-price { font-size: 19px; font-weight: 700; color: #B12704; }
        .old-price { text-decoration: line-through; color: #565959; font-size: 14px; margin-left: 8px; }

        /* --- Amazon Style Buttons --- */
        .btn-amazon {
            background: #ffd814; border: 1px solid #fcd200; border-radius: 20px;
            padding: 10px; cursor: pointer; font-size: 13px; width: 100%; font-weight: 500;
        }
        .btn-amazon:hover { background: #f7ca00; }
        .btn-checkout { background: #ffa41c; border-radius: 8px; margin-top: 15px; font-weight: 600; }
    </style>
</head>
<body>

<header>
    <a href="/" class="logo">SmartShop.ge</a>
    <div class="nav-right">
        <div class="user-panel">
            <span>Hello, <b>${userName}</b></span>
            <small>SmartShop Group</small>
        </div>
        <button class="cart-trigger" onclick="toggleCart()">
            <i class="fas fa-shopping-cart"></i>
            <span class="cart-badge" id="cartBadge">0</span>
        </button>
    </div>
</header>

<form action="/" method="get" class="search-wrapper">
    <input type="text" name="search" class="search-input" placeholder="Search products..." value="${searchQuery!''}">
    <button type="submit" class="search-submit">Search</button>
</form>

<div id="cartSidebar">
    <div class="cart-header">
        <h3>Shopping Cart</h3>
        <button onclick="toggleCart()" style="border:none; background:none; font-size:24px; cursor:pointer;">&times;</button>
    </div>
    <div id="cartItems" class="cart-items">
    </div>
    <div style="border-top: 1px solid #ddd; padding-top: 15px;">
        <div style="display:flex; justify-content:space-between; font-weight:700; font-size: 18px;">
            <span>Total:</span>
            <span id="cartTotal">0.00 GEL</span>
        </div>
        <button class="btn-amazon btn-checkout" onclick="alert('Proceeding to Payment...')">Checkout</button>
    </div>
</div>

<div class="container">
    <h2 style="margin-bottom: 20px;">Featured Products</h2>
    <div class="product-grid">
        <#list productList as product>
        <div class="product-card">
            <#if (product.oldPrice > product.price)>
            <div class="sale-badge">SALE</div>
        </#if>

        <div class="category-tag">${product.category}</div>
        <img src="${product.imageUrl}" class="product-image">
        <div class="product-name">${product.name}</div>

        <div style="margin-bottom: 15px;">
            <span class="current-price">${product.price} GEL</span>
            <#if (product.oldPrice > product.price)>
            <span class="old-price">${product.oldPrice} GEL</span>
        </#if>
    </div>

    <button class="btn-amazon" <#if (product.stock == 0)>disabled</#if>
onclick="addToCart('${product.name}', ${product.price})">
<#if (product.stock > 0)>Add to Cart<#else>Out of Stock</#if>
</button>
</div>
</#list>
</div>
</div>

<script>
    let cart = [];

    function toggleCart() {
        document.getElementById('cartSidebar').classList.toggle('active');
    }

    function addToCart(name, price) {
        const item = cart.find(i => i.name === name);
        if (item) {
            item.qty++;
        } else {
            cart.push({ name, price, qty: 1 });
        }
        renderCart();
        if(!document.getElementById('cartSidebar').classList.contains('active')) toggleCart();
    }

    function removeItem(name) {
        cart = cart.filter(i => i.name !== name);
        renderCart();
    }

    function renderCart() {
        const list = document.getElementById('cartItems');
        const badge = document.getElementById('cartBadge');
        const total = document.getElementById('cartTotal');

        list.innerHTML = '';
        let sum = 0, count = 0;

        if (cart.length === 0) {
            list.innerHTML = '<p style="text-align:center; color:#888; margin-top:20px;">Empty Cart</p>';
        }

        cart.forEach(item => {
            sum += item.price * item.qty;
            count += item.qty;
            list.innerHTML += `
                <div class="cart-item">
                    <div>
                        <strong>${item.name}</strong><br>
                        ${item.qty} x ${item.price} GEL
                    </div>
                    <button class="delete-item" onclick="removeItem('${item.name}')">Delete</button>
                </div>`;
        });

        badge.innerText = count;
        total.innerText = sum.toFixed(2) + " GEL";
    }
</script>

</body>
</html>
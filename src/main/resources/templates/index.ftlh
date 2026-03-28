<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>SmartShop | Premium Electronics</title>

    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">

    <style>
        :root { --amazon-blue: #131921; --amazon-light-blue: #232f3e; --amazon-gold: #febd69; }
        * { margin: 0; padding: 0; box-sizing: border-box; font-family: Arial, sans-serif; }
        body { background: #eaeded; color: #0f1111; font-size: 14px; }

        header {
            background: var(--amazon-blue);
            padding: 10px 5%;
            color: white;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .logo { font-size: 22px; font-weight: 700; color: var(--amazon-gold); text-decoration: none; }

        .nav-xshop-container {
            background: var(--amazon-light-blue);
            padding: 8px 5%;
            display: flex;
            gap: 15px;
            color: white;
        }

        .search-wrapper {
            background: var(--amazon-light-blue);
            padding: 10px 5%;
            display: flex;
            gap: 5px;
        }

        .search-input {
            flex: 1;
            padding: 10px;
            border-radius: 4px 0 0 4px;
            border: none;
        }

        .search-submit {
            background: var(--amazon-gold);
            border: none;
            padding: 10px 20px;
        }

        .main-container {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 20px;
            padding: 20px 5%;
        }

        .category-card {
            background: white;
            padding: 20px;
            display: flex;
            flex-direction: column;
            min-height: 420px;
        }

        .quad-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 10px;
        }

        .quad-item img {
            width: 100%;
            height: 100px;
            object-fit: contain;
        }

        .see-more {
            margin-top: auto;
            color: #007185;
            text-decoration: none;
        }

        .product-card {
            background: white;
            padding: 15px;
            text-align: center;
        }

        .product-card img {
            width: 100%;
            height: 200px;
            object-fit: contain;
        }

        /* CART */
        #cartSidebar {
            position: fixed;
            right: -350px;
            top: 0;
            width: 320px;
            height: 100%;
            background: white;
            box-shadow: -5px 0 15px rgba(0,0,0,0.2);
            transition: 0.3s;
            padding: 20px;
        }

        #cartSidebar.active {
            right: 0;
        }
    </style>
</head>

<body>

<header>
    <a href="/" class="logo">SmartShop.ge</a>

    <div style="display:flex; gap:20px; align-items:center;">
        <div>Hello, <b>${userName}</b></div>

        <button onclick="toggleCart()" style="background:none; border:none; color:white; font-size:20px; cursor:pointer; position:relative;">
            <i class="fas fa-shopping-cart"></i>
            <span id="cartBadge" style="position:absolute; top:-8px; right:-10px; background:#f08804; padding:2px 5px; border-radius:50%; font-size:10px;">0</span>
        </button>
    </div>
</header>

<div class="nav-xshop-container">
    <span>Today's Deals</span>
    <span>Customer Service</span>
    <span>Registry</span>
    <span>Sell</span>
</div>

<form action="/" method="get" class="search-wrapper">
    <input type="text" name="search" class="search-input" placeholder="Search SmartShop...">
    <button type="submit" class="search-submit">
        <i class="fas fa-search"></i>
    </button>
</form>

<!-- CART -->
<div id="cartSidebar">
    <h3>Your Basket</h3>
    <hr><br>
    <div id="cartItems"></div>
    <div style="margin-top:20px;">
        <strong>Total: <span id="cartTotal">0.00</span> GEL</strong>
    </div>
</div>

<div class="main-container">

    <#-- SEARCH -->
    <#if searchQuery?? && searchQuery?has_content>

    <#if productList?size == 0>
    <h2>No products found</h2>
    <#else>
    <#list productList as product>
    <div class="product-card">
        <img src="${product.imageUrl}">
        <h3>${product.name}</h3>
        <p>${product.price} GEL</p>
        <button onclick="addToCart('${product.name}', ${product.price})">Add to Cart</button>
    </div>
</#list>
</#if>

<#-- NORMAL -->
<#else>

<#macro quadCategory title categoryName>
<div class="category-card">
    <h3>${title}</h3>

    <div class="quad-grid">
        <#assign count = 0>
        <#list productList as product>
        <#if product.category == categoryName && count < 4>
        <div class="quad-item" onclick="addToCart('${product.name}', ${product.price})">
            <img src="${product.imageUrl}">
            <span>${product.name}</span>
        </div>
        <#assign count = count + 1>
    </#if>
</#list>
</div>

<a href="/category?type=${categoryName}" class="see-more">See more</a>
</div>
</#macro>

<@quadCategory title="Smart Watches" categoryName="Watch" />
<@quadCategory title="Laptops" categoryName="Computer" />
<@quadCategory title="Tablets" categoryName="Tablet" />
<@quadCategory title="Phones" categoryName="Phone" />
<@quadCategory title="Audio" categoryName="Audio" />
<@quadCategory title="Accessories" categoryName="PC Accessory" />

</#if>

</div>

<script>
let cart = [];

function toggleCart() {
    document.getElementById('cartSidebar').classList.toggle('active');
}

function addToCart(name, price) {
    const item = cart.find(i => i.name === name);
    if(item) item.qty++; else cart.push({name, price, qty:1});
    updateUI();
}

function updateUI() {
    let total = 0, count = 0;
    const list = document.getElementById('cartItems');
    list.innerHTML = '';

    cart.forEach(i => {
        total += i.price * i.qty;
        count += i.qty;

        list.innerHTML += `<div>${i.name} x${i.qty}</div>`;
    });

    document.getElementById('cartBadge').innerText = count;
    document.getElementById('cartTotal').innerText = total.toFixed(2);
}
</script>

</body>
</html>
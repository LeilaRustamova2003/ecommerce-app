<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>SmartShop</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">

    <script>
        let cart = [];

        function toggleCart() {
            const sidebar = document.getElementById('cartSidebar');
            if (sidebar) sidebar.classList.toggle('active');
        }

        function addToCart(name, price) {
            const item = cart.find(i => i.name === name);
            if (item) {
                item.qty++;
            } else {
                cart.push({name: name, price: parseFloat(price), qty: 1});
            }
            updateUI();
            if (!document.getElementById('cartSidebar').classList.contains('active')) toggleCart();
        }

        // Ürünü silme veya azaltma fonksiyonu
        function removeFromCart(name) {
            const index = cart.findIndex(i => i.name === name);
            if (index > -1) {
                if (cart[index].qty > 1) {
                    cart[index].qty--;
                } else {
                    cart.splice(index, 1);
                }
            }
            updateUI();
        }

        function updateUI() {
            let total = 0, count = 0;
            const list = document.getElementById('cartItems');
            if (!list) return;

            list.innerHTML = '';
            cart.forEach(i => {
                total += i.price * i.qty;
                count += i.qty;
                list.innerHTML += `
                <div style="display:flex; justify-content:space-between; align-items:center; margin-bottom:10px; border-bottom:1px solid #eee; padding-bottom:5px;">
                    <span style="font-size:12px; color:black;">` + i.name + ` (x` + i.qty + `)</span>
                    <div style="display:flex; align-items:center; gap:10px;">
                        <strong style="color:black;">` + (i.price * i.qty).toFixed(2) + `</strong>
                        <button onclick="removeFromCart('` + i.name + `')" style="background:#cc0000; color:white; border:none; padding:2px 6px; cursor:pointer; border-radius:3px;">X</button>
                    </div>
                </div>`;
            });
            document.getElementById('cartBadge').innerText = count;
            document.getElementById('cartTotal').innerText = total.toFixed(2);
        }

        function proceedToCheckout() {
            if (cart.length === 0) { alert("Basket is empty!"); return; }
            alert("Payment Page: " + document.getElementById('cartTotal').innerText + " GEL");
        }
    </script>

    <style>
        :root { --amazon-blue: #131921; --amazon-light-blue: #232f3e; --amazon-gold: #febd69; }
        * { margin: 0; padding: 0; box-sizing: border-box; font-family: Arial, sans-serif; }
        body { background: #eaeded; }
        header { background: var(--amazon-blue); padding: 10px 5%; color: white; display: flex; justify-content: space-between; align-items: center; }
        .logo { font-size: 22px; font-weight: 700; color: var(--amazon-gold); text-decoration: none; }
        .search-wrapper { background: var(--amazon-light-blue); padding: 10px 5%; display: flex; gap: 5px; }
        .search-input { flex: 1; padding: 10px; border-radius: 4px; border: none; }
        .main-container { display: grid; grid-template-columns: repeat(auto-fit, minmax(250px, 1fr)); gap: 20px; padding: 20px 5%; }
        .product-card { background: white; padding: 15px; border-radius: 4px; text-align: center; display: flex; flex-direction: column; justify-content: space-between; }
        .product-card img { width: 100%; height: 150px; object-fit: contain; }
        .btn-add { background: var(--amazon-gold); border: 1px solid #a88734; padding: 8px; cursor: pointer; border-radius: 3px; font-weight: bold; margin-top: 10px; }
        #cartSidebar { position: fixed; right: -350px; top: 0; width: 320px; height: 100%; background: white; box-shadow: -5px 0 15px rgba(0,0,0,0.2); transition: 0.3s; padding: 20px; z-index: 1000; display: flex; flex-direction: column; }
        #cartSidebar.active { right: 0; }
        #cartItems { flex-grow: 1; overflow-y: auto; margin-top: 15px; }
        .btn-checkout { background: #f0c14b; border: 1px solid #a88734; padding: 12px; width: 100%; margin-top: 10px; cursor: pointer; font-weight: bold; border-radius: 3px; }
    </style>
</head>
<body>

<header>
    <a href="/" class="logo">SmartShop.ge</a>
    <button onclick="toggleCart()" style="background:none; border:none; color:white; font-size:20px; cursor:pointer; position:relative;">
        <i class="fas fa-shopping-cart"></i>
        <span id="cartBadge" style="position:absolute; top:-8px; right:-10px; background:#f08804; padding:2px 5px; border-radius:50%; font-size:10px;">0</span>
    </button>
</header>

<form action="/" method="get" class="search-wrapper">
    <input type="text" name="search" class="search-input" placeholder="Search products...">
    <button type="submit" style="padding:10px 20px; background:var(--amazon-gold); border:none; cursor:pointer;"><i class="fas fa-search"></i></button>
</form>

<div id="cartSidebar">
    <h3 style="color:black;">Your Basket</h3><hr>
    <div id="cartItems"></div>
    <div style="border-top: 2px solid #eee; padding-top: 10px; color:black;">
        <strong>Total: <span id="cartTotal">0.00</span> GEL</strong>
        <button class="btn-checkout" onclick="proceedToCheckout()">Proceed to Checkout</button>
        <button onclick="toggleCart()" style="width:100%; margin-top:10px; cursor:pointer; border:none; background:none;">Close</button>
    </div>
</div>

<div class="main-container">
    <#if productList??>
    <#list productList as product>
    <div class="product-card">
        <img src="${product.imageUrl!''}">
        <h3 style="font-size:14px; margin:10px 0;">${product.name!'Product'}</h3>
        <div style="color: #B12704; font-weight: bold;">${(product.price!0)?c} GEL</div>
        <button class="btn-add" onclick="addToCart('${product.name!''}', ${(product.price!0)?c})">
            Add to Cart
        </button>
        <a href="/product/${(product.id!0)?c}" style="display:block; margin-top:8px; font-size:12px; color:#007185; text-decoration:none;">Details</a>
    </div>
</#list>
</#if>
</div>
</body>
</html>
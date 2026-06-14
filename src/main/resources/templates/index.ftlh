<!DOCTYPE html>
<html xmlns:th="http://www.thymeleaf.org"
      xmlns:sec="http://www.thymeleaf.org/extras/spring-security">
<head>
    <meta charset="UTF-8">
    <title>SmartShop</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        :root { --blue: #131921; --gold: #febd69; }
        * { margin:0; padding:0; box-sizing:border-box; font-family:Arial,sans-serif; }
        body { background:#eaeded; }
        header { background:var(--blue); padding:10px 5%; color:white; display:flex; justify-content:space-between; align-items:center; }
        .logo { font-size:22px; font-weight:700; color:var(--gold); text-decoration:none; }
        .header-right { display:flex; align-items:center; gap:15px; }
        .header-right a { color:white; text-decoration:none; font-size:13px; }
        .header-right button[type=submit] { background:none; border:none; color:white; cursor:pointer; font-size:13px; }
        .lang-bar { background:#232f3e; padding:5px 5%; font-size:13px; }
        .lang-bar a { color:#ccc; text-decoration:none; margin-right:10px; }
        .lang-bar a:hover { color:var(--gold); }
        .search-bar { background:#232f3e; padding:10px 5%; display:flex; gap:5px; }
        .search-bar input { flex:1; padding:10px; border:none; border-radius:4px; font-size:14px; }
        .search-bar button { padding:10px 20px; background:var(--gold); border:none; cursor:pointer; border-radius:4px; }
        .grid { display:grid; grid-template-columns:repeat(auto-fit,minmax(220px,1fr)); gap:20px; padding:20px 5%; }
        .card { background:white; padding:15px; border-radius:4px; text-align:center; display:flex; flex-direction:column; justify-content:space-between; }
        .card img { width:100%; height:150px; object-fit:contain; }
        .card h3 { font-size:14px; margin:10px 0; }
        .price { color:#B12704; font-weight:bold; font-size:16px; }
        .btn-add { background:var(--gold); border:1px solid #a88734; padding:8px; cursor:pointer; border-radius:3px; font-weight:bold; margin-top:10px; width:100%; }
        .btn-add:hover { background:#e0a800; }
        .details-link { display:block; margin-top:8px; font-size:12px; color:#007185; text-decoration:none; }
        #sidebar { position:fixed; right:-350px; top:0; width:320px; height:100%; background:white; box-shadow:-5px 0 15px rgba(0,0,0,.2); transition:.3s; padding:20px; z-index:1000; display:flex; flex-direction:column; }
        #sidebar.active { right:0; }
        #cartItems { flex-grow:1; overflow-y:auto; margin-top:15px; }
        .btn-checkout { background:#f0c14b; border:1px solid #a88734; padding:12px; width:100%; margin-top:10px; cursor:pointer; font-weight:bold; border-radius:3px; }
        .cart-btn { background:none; border:none; color:white; font-size:20px; cursor:pointer; position:relative; }
        #cartBadge { position:absolute; top:-8px; right:-10px; background:#f08804; padding:2px 5px; border-radius:50%; font-size:10px; }
    </style>
    <script>
        var cart = [];
        function toggleCart() {
            document.getElementById('sidebar').classList.toggle('active');
        }
        function addToCart(name, price) {
            var item = null;
            for(var i=0; i<cart.length; i++){
                if(cart[i].name === name){ item = cart[i]; break; }
            }
            if(item){ item.qty++; } else { cart.push({name:name, price:parseFloat(price), qty:1}); }
            updateUI();
            if(!document.getElementById('sidebar').classList.contains('active')) toggleCart();
        }
        function removeFromCart(name) {
            for(var i=0; i<cart.length; i++){
                if(cart[i].name === name){
                    if(cart[i].qty > 1) cart[i].qty--;
                    else cart.splice(i,1);
                    break;
                }
            }
            updateUI();
        }
        function updateUI() {
            var total=0, count=0, html='';
            for(var i=0; i<cart.length; i++){
                total += cart[i].price * cart[i].qty;
                count += cart[i].qty;
                html += '<div style="display:flex;justify-content:space-between;margin-bottom:8px;border-bottom:1px solid #eee;padding-bottom:5px;">'
                    + '<span style="font-size:12px;color:black;">' + cart[i].name + ' (x' + cart[i].qty + ')</span>'
                    + '<div style="display:flex;gap:8px;align-items:center;">'
                    + '<strong style="color:black;">' + (cart[i].price*cart[i].qty).toFixed(2) + '</strong>'
                    + '<button onclick="removeFromCart(\'' + cart[i].name + '\')" style="background:#cc0000;color:white;border:none;padding:2px 6px;cursor:pointer;border-radius:3px;">X</button>'
                    + '</div></div>';
            }
            document.getElementById('cartItems').innerHTML = html;
            document.getElementById('cartBadge').innerText = count;
            document.getElementById('cartTotal').innerText = total.toFixed(2);
        }
        function proceedToCheckout() {
            if(cart.length === 0){ alert('Cart is empty!'); return; }
            alert('Total: ' + document.getElementById('cartTotal').innerText + ' GEL');
        }
    </script>
</head>
<body>

<header>
    <a href="/" class="logo" th:text="#{nav.brand}">SmartShop</a>
    <div class="header-right">
        <span sec:authorize="isAuthenticated()">
            <i class="fas fa-user"></i>
            <span sec:authentication="name"></span>
        </span>
        <a th:href="@{/profile}" sec:authorize="isAuthenticated()" th:text="#{nav.profile}">Profile</a>
        <a th:href="@{/admin}" sec:authorize="hasRole('ADMIN')" th:text="#{nav.admin}">Admin</a>
        <a th:href="@{/login}" sec:authorize="!isAuthenticated()" th:text="#{nav.login}">Login</a>
        <form th:action="@{/logout}" method="post" style="display:inline;" sec:authorize="isAuthenticated()">
            <input type="hidden" th:name="${_csrf.parameterName}" th:value="${_csrf.token}"/>
            <button type="submit" th:text="#{nav.logout}">Logout</button>
        </form>
        <button class="cart-btn" onclick="toggleCart()">
            <i class="fas fa-shopping-cart"></i>
            <span id="cartBadge">0</span>
        </button>
    </div>
</header>

<div class="lang-bar">
    <a th:href="@{/(lang=ka)}" th:text="#{lang.ka}">ქართული</a>
    <a th:href="@{/(lang=en)}" th:text="#{lang.en}">English</a>
</div>

<form action="/" method="get" class="search-bar">
    <input type="text" name="search"
           th:placeholder="#{search.placeholder}"
           th:value="${searchQuery != null ? searchQuery : ''}">
    <button type="submit"><i class="fas fa-search"></i></button>
</form>

<div id="sidebar">
    <h3 style="color:black;" th:text="#{cart.title}">Cart</h3>
    <hr>
    <div id="cartItems"></div>
    <div style="border-top:2px solid #eee;padding-top:10px;color:black;">
        <strong th:text="#{cart.total}">Total</strong>: <span id="cartTotal">0.00</span> GEL
        <button class="btn-checkout" onclick="proceedToCheckout()" th:text="#{cart.checkout}">Checkout</button>
        <button onclick="toggleCart()" style="width:100%;margin-top:10px;cursor:pointer;border:none;background:none;" th:text="#{cart.close}">Close</button>
    </div>
</div>

<div class="grid">
    <div class="card" th:each="product : ${productList}">
        <img th:src="${product.imageUrl}" th:alt="${product.name}">
        <h3 th:text="${product.name}">Name</h3>
        <div class="price" th:text="${product.price} + ' GEL'">0 GEL</div>
        <button class="btn-add"
                th:onclick="'addToCart(\'' + ${product.name} + '\', \'' + ${product.price} + '\')'"
                th:text="#{product.add_to_cart}">Add to Cart</button>
        <a class="details-link"
           th:href="@{/product/{id}(id=${product.id})}"
           th:text="#{product.details}">Details</a>
    </div>
</div>

</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <link rel="stylesheet" href="css/Navbar_procate.css">
    <link rel="stylesheet" href="css/Hero_procate.css">
    <link rel="stylesheet" href="css/SearchBar.css">
    <link rel="stylesheet" href="css/Popular.css">
    <link rel="stylesheet" href="css/Item.css">
    <link rel="stylesheet" href="css/NewCollections.css">
    <link rel="stylesheet" href="css/NewLetter.css">
    <link rel="stylesheet" href="css/Footer.css">
    <link rel="stylesheet" href="css/Cate.css">
    <!-- <link rel="stylesheet" href="css/ProductDisplay.css"> -->


    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="adding/bootstrap/boostrap.min.css">
    <!-- <script src="adding/jquery/jquery-3.4.1.min.js"></script>
    <script src="adding/poper/poper.min.js"></script>
    <script src="adding/bootstrap/boostrap.min.js"></script>  -->

    <script src="adding/bootstrap/bootstrap.bundle.min.js"></script>
    <script src="js/navbar.js"></script>
</head>

<body>
    <div class="hero" style="display: flex;">
        <div class="nav-header">
            <a href="/" style="text-decoration: none; color: inherit; z-index: 3; margin-top: 3.5rem; position: fixed;">
                <p style="color: white;">XUN_DON</p>
            </a>
        </div>
        <div class="shop-navbar">
            <ul class="nav-menu">
                <li class="nav-item">
                    <a href="/product/gender/nam" style="text-decoration: none; color: inherit;">NAM</a>
                    <hr />

                    <div class="subcategories" style="margin: 0; width: 30rem;">
                        <!-- SUBCATEGORY 1 -->
                        <a href="javascript:void(0)" onclick="toggleSubcategory(1)" style="text-decoration: none;">
                            <p style="display: inline;"> SUBCATEGORY 1 +</p>
                        </a>
                        <!-- Container cho các mục con của subcategory 1 -->
                        <div id="subcategory1-extra" class="subcategory-extra" style="display: none; margin-left: 8%;">
                            <a href="#" style="text-decoration: none;">
                                <p>Extra Subcategory 1.1</p>
                            </a>
                            <a href="#" style="text-decoration: none;">
                                <p>Extra Subcategory 1.2</p>
                            </a>
                        </div>

                        <!-- SUBCATEGORY 2 -->
                        <a href="javascript:void(0)" onclick="toggleSubcategory(2)" style="text-decoration: none;">
                            <p>SUBCATEGORY 2 +</p>
                        </a>
                        <!-- Container cho các mục con của subcategory 2 -->
                        <div id="subcategory2-extra" class="subcategory-extra" style="display: none;margin-left: 8%;">
                            <a href="#" style="text-decoration: none;">
                                <p>Extra Subcategory 2.1</p>
                            </a>
                            <a href="#" style="text-decoration: none;">
                                <p>Extra Subcategory 2.2</p>
                            </a>
                        </div>

                        <!-- SUBCATEGORY 3 -->
                        <a href="javascript:void(0)" onclick="toggleSubcategory(3)" style="text-decoration: none;">
                            <p>SUBCATEGORY 3 +</p>
                        </a>
                        <!-- Container cho các mục con của subcategory 3 -->
                        <div id="subcategory3-extra" class="subcategory-extra" style="display: none;margin-left: 8%;">
                            <a href="#" style="text-decoration: none;">
                                <p>Extra Subcategory 3.1</p>
                            </a>
                            <a href="#" style="text-decoration: none;">
                                <p>Extra Subcategory 3.2</p>
                            </a>
                        </div>
                    </div>

                </li>
                <span style="font-size: 2rem; margin-bottom:2%;">|</span>
                <li class="nav-item">
                    <a href="/product/gender/nữ" style="text-decoration: none; color: inherit;">NỮ</a>
                    <hr />
                    <div class="subcategories" style="margin: 0; width: 30rem;">
                        <!-- SUBCATEGORY 4 -->
                        <a href="javascript:void(0)" onclick="toggleSubcategory(4)" style="text-decoration: none;">
                            <p style="display: inline;"> SUBCATEGORY 4 +</p>
                        </a>
                        <!-- Container cho các mục con của subcategory 4 -->
                        <div id="subcategory4-extra" class="subcategory-extra" style="display: none;margin-left: 8%;">
                            <a href="#" style="text-decoration: none;">
                                <p>Extra Subcategory 4.1</p>
                            </a>
                            <a href="#" style="text-decoration: none;">
                                <p>Extra Subcategory 4.2</p>
                            </a>
                        </div>

                        <!-- SUBCATEGORY 5 -->
                        <a href="javascript:void(0)" onclick="toggleSubcategory(5)" style="text-decoration: none;">
                            <p>SUBCATEGORY 5 +</p>
                        </a>
                        <!-- Container cho các mục con của subcategory 5 -->
                        <div id="subcategory5-extra" class="subcategory-extra" style="display: none;margin-left: 8%;">
                            <a href="#" style="text-decoration: none;">
                                <p>Extra Subcategory 5.1</p>
                            </a>
                            <a href="#" style="text-decoration: none;">
                                <p>Extra Subcategory 5.2</p>
                            </a>
                        </div>
                    </div>
                </li>
            </ul>
            <div class="nav-login-cart">
                <!-- Search bar -->
                <div class="search-bar"
                    style="margin: 0.5px; border: none; border-bottom: 2px solid white; outline: none; background-color: transparent; display: flex; align-items: center;">
                    <span style="font-size: 1rem; color: white;"><img src="img/search.png" alt=""
                            style="height: 20px;"></span> <!-- Search icon placeholder -->
                    <input type="text" placeholder="Tìm kiếm"
                        style="background: transparent; outline: none; border: none; color: white;">
                </div>

                <!-- User icon and hidden login/register options -->
                <div class="user-menu">
                    <span class="user-icon" style="color: white; font-size: 2rem; cursor: pointer;">
                        <img src="img/avatar.png" alt="" style="height: 30px; margin-top: 5%;">
                    </span>
                    <div class="user-options" style="display: none;">
                        <button
                            style="color: white; width: 100%; height: 40px; margin-bottom: 0.5rem; font-size: 15px; background-color: black;">
                            Đăng nhập
                        </button>
                        <button
                            style="color: black; width: 100%; height: 40px; font-size: 15px; background-color: white; border: 1px solid black">
                            Đăng ký
                        </button>
                    </div>
                </div>


                <!-- Heart icon -->
                <div class="heart">
                    <span style="color: white; font-size: 2rem; cursor: pointer;"><img src="img/heart.png" alt=""
                            style="height: 25px; opacity: 1;"></span>
                </div>

                <!-- Cart icon -->
                <div class="cart">
                    <a href="#" data-bs-toggle="offcanvas" data-bs-target="#cartOffcanvas">
                        <span style="color: white; font-size: 2rem; cursor: pointer;">
                            <img src="img/shopping-cart.png" alt="" style="height: 30px; padding-left: 15px;">
                        </span>
                    </a>
                </div>

                <!-- Offcanvas (cart frame) nằm bên phải -->
                <div class="offcanvas offcanvas-end" tabindex="-1" id="cartOffcanvas"
                    aria-labelledby="cartOffcanvasLabel">
                    <div class="offcanvas-header">
                        <h5 class="offcanvas-title" id="cartOffcanvasLabel">Giỏ hàng của tôi</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="offcanvas" aria-label="Close"></button>
                    </div>
                    <div class="offcanvas-body">
                        <!-- Cart Item -->
                        <div class="cart-item">
                            <div class="cart-item-image">
                                <img src="https://via.placeholder.com/100x100" alt="Product Image" />
                            </div>
                            <div class="cart-item-details">
                                <p class="cart-item-name">Áo Polo nam phối màu. Fitted</p>
                                <p class="cart-item-description">BRIGHT WHITE, L</p>
                                <div class="cart-item-actions">
                                    <span class="cart-item-quantity">SL: 1</span>
                                    <button class="remove-item-btn">
                                        <img src="https://via.placeholder.com/20x20" alt="Remove Icon">
                                    </button>
                                </div>
                            </div>
                            <div class="cart-item-price">569.000đ</div>
                        </div>
                    </div>
                    <div class="offcanvas-footer">
                        <button class="view-cart-btn">Xem giỏ hàng (1 sản phẩm)</button>
                    </div>
                </div>



                <!-- Cart count -->
                <div class="nav-cart-count">0</div>


            </div>
        </div>
        <!-- Navbar placeholder -->
    </div>



    <div class="cate-container container">
        <div class="cate-left">
            <div class="cate-left-breadcrumb" style="margin-left: 20px; margin-top: 12px; text-decoration: none;">
                <a href="#" style="text-decoration: none;">
                    <span class="breadcrumb">
                        Trang chủ > <span class="current-category" style="cursor: default; margin-left: 10px;">Giỏ hàng
                            của tôi</span>
                    </span>
                </a>
            </div>
        </div>
    </div>

    <!--
    
-->
    <div class="container mt-4">
        <div class="row">
            <!-- Left Section: Image Gallery -->
            <div class="col-md-4">
                <div class="main-image mb-3">
                    <img id="mainImage" src="img/product_1.png" class="img-fluid" alt="Product Image" style="width: 100%;">
                </div>
                <div class="thumbnail-images d-flex justify-content-start">
                    <img src="img/product_25.png" class="img-thumbnail me-2 thumbnail"
                        data-large="img/product_25.png" alt="Thumb 1">
                    <img src="/img/product_26.png" class="img-thumbnail me-2 thumbnail"
                        data-large="img/product_26.png" alt="Thumb 2">
                    <img src="img/product_27.png" class="img-thumbnail me-2 thumbnail"
                        data-large="img/product_27.png" alt="Thumb 3">
                </div>
            </div>

            <!-- Right Section: Product Info -->
            <div class="col-md-8">
                <h2 id="productTitle">Product Title</h2>
                <p>SKU: <span id="productSKU">12345ABC</span></p>
                <p>Price: <span id="productPrice">$99.99</span></p>

                <!-- Color Options -->
                <div class="color-options mb-3">
                    <button class="btn btn-outline-primary color-btn" data-image="img/product_25.png">Red</button>
                    <button class="btn btn-outline-primary color-btn" data-image="large-image2.jpg">Blue</button>
                    <button class="btn btn-outline-primary color-btn" data-image="large-image3.jpg">Green</button>
                    <button class="btn btn-outline-primary color-btn" data-image="large-image3.jpg">Green</button>
                    <button class="btn btn-outline-primary color-btn" data-image="large-image3.jpg">Green</button>
                    <button class="btn btn-outline-primary color-btn" data-image="large-image3.jpg">Green</button>
                    <button class="btn btn-outline-primary color-btn" data-image="large-image3.jpg">Green</button>

                </div>

                <!-- Size Selector -->
                <div class="size-options mb-3">
                    <div class="size-buttons d-flex">
                        <button class="btn btn-outline-primary size-btn" data-size="S">S</button>
                        <button class="btn btn-outline-primary size-btn" data-size="M">M</button>
                        <button class="btn btn-outline-primary size-btn" data-size="L">L</button>
                        <button class="btn btn-outline-primary size-btn" data-size="XL">XL</button>
                    </div>
                </div>

                <!-- Quantity and Buttons -->
                <div class="row align-items-center mb-3">
                    <div class="col-4">
                        <div class="input-group">
                            <button class="btn btn-outline-secondary" id="decreaseQuantity">-</button>
                            <input type="number" id="quantity" class="form-control text-center" value="1" min="1">
                            <button class="btn btn-outline-secondary" id="increaseQuantity">+</button>
                        </div>
                    </div>
                    <div class="col-8">
                        <button class="btn btn-primary w-100">Add to Cart</button>
                    </div>
                </div>

                <button class="btn btn-success w-100">Buy Now</button>
            </div>
        </div>
    </div>

    <style>
        .main-image {
            border: 1px solid #ddd;
            padding: 5px;
        }

        .thumbnail {
            cursor: pointer;
            width: 80px;
            height: auto;
        }
        .color-options button{
            border-color: #999999;
            color: black;
            margin-top: 10px;
        }
        .color-btn {
            margin-right: 5px;
        }
        .size-options button{
            border-color: #999999;
            color: black;
            margin-top: 10px;
            margin-right: 10px;
        }
        .size-btn.active {
            background-color: #007bff;
            /* Bootstrap primary color */
            color: white;
        }

        .size-options .size-btn {
            flex: 1;
            /* Make buttons flexible to take equal space */
            /* margin: 0 5px; */
            /* Add some margin between buttons */
            width: 50px;
        }
    </style>

    <script>
        // Xử lý sự kiện cho hình thu nhỏ
        document.querySelectorAll('.thumbnail').forEach((thumbnail) => {
            thumbnail.addEventListener('click', function () {
                const largeImage = this.src; // Lấy src của hình thu nhỏ
                document.getElementById('mainImage').src = largeImage; // Cập nhật hình lớn
            });
        });

        // Xử lý sự kiện cho nút màu
        document.querySelectorAll('.color-btn').forEach((colorBtn) => {
            colorBtn.addEventListener('click', function () {
                const colorImage = this.getAttribute('data-image'); // Lấy hình ảnh cho màu sắc
                document.getElementById('mainImage').src = colorImage; // Cập nhật hình lớn
            });
        });


        document.getElementById('increaseQuantity').addEventListener('click', function () {
            const quantityInput = document.getElementById('quantity');
            quantityInput.value = parseInt(quantityInput.value) + 1;
        });

        document.getElementById('decreaseQuantity').addEventListener('click', function () {
            const quantityInput = document.getElementById('quantity');
            if (quantityInput.value > 1) {
                quantityInput.value = parseInt(quantityInput.value) - 1;
            }
        });

        document.querySelectorAll('.size-btn').forEach((sizeBtn) => {
            sizeBtn.addEventListener('click', function () {
                // Remove 'active' class from all size buttons
                document.querySelectorAll('.size-btn').forEach((btn) => {
                    btn.classList.remove('active');
                });
                // Add 'active' class to the clicked button
                this.classList.add('active');
            });
        });

    </script>




    <!-- Footer -->
    <div class="footer">
        <div class="footer-logo">
            <img src="footer_logo.png" alt="" />
            <p>SHOPPEE</p>
        </div>
        <ul class="footer-links">
            <li>Company</li>
            <li>Products</li>
            <li>Offices</li>
            <li>About</li>
            <li>Contact</li>
        </ul>
        <div class="footer-social-icon">
            <div class="footer-icons-container">
                <img src="instagram.png" alt="" />
            </div>
            <div class="footer-icons-container">
                <img src="pinterest.png" alt="" />
            </div>
            <div class="footer-icons-container">
                <img src="whatsapp.png" alt="" />
            </div>
        </div>
        <div class="footer-copyright">
            <hr />
            <p>© 2023 by Shoppee. Proudly created with Wix.com</p>
        </div>
    </div>
</body>

</html>

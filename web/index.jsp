<%--
  Created by IntelliJ IDEA.
  User: lolsp
  Date: 20/2/2019
  Time: 10:27 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<jsp:include page="header.html"></jsp:include>
<body>
<jsp:include page="navbar.jsp"></jsp:include>
<section class="hero is-link is-fullheight-with-navbar is-bold">
    <div class="hero-body">
        <div class="container">
            <h1 class="title">
                Welcome to the OnlinePetStore
            </h1>
            <h2 class="subtitle">
                The one stop solution to all your pet needs
            </h2>
        </div>
    </div>
</section>
<section class="hero is-fullheight is-light is-bold">
    <div class="hero-body">
        <div class="container">
            <h1 class="title">Why TheOnlinePetStore?</h1>
            <br>
            <div class="columns">
                <div class="column is-one-thirds">
                    <div class="card">
                        <div class="card-image">
                            <figure class="image is-4by3">
                                <img src="data:image/jpeg;base64,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" alt="Placeholder image">
                            </figure>
                        </div>
                        <div class="card-content">
                            <div class="media">
                                <div class="media-content">
                                    <p class="title is-4 has-text-centered">High Quality Products</p>
                                    <p>We provide the highest of quality of products to our customers! So you be rest easy knowing you're getting the best!</p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="column is-one-thirds">
                    <div class="card">
                        <div class="card-image">
                            <figure class="image is-4by3">
                                <img src="https://news.vanderbilt.edu/files/coupon-585x298.jpg" alt="Placeholder image">
                            </figure>
                        </div>
                        <div class="card-content">
                            <div class="media">
                                <div class="media-content">
                                    <p class="title is-4 has-text-centered">Cheapest Price</p>
                                    <p>With our uber price beat, you can find any store selling cheaper than us, we will be give a 10% discount on what they are offering!</p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="column is-one-thirds">
                    <div class="card">
                        <div class="card-image">
                            <figure class="image is-4by3">
                                <img src="https://www.itourvn.com/images/easyblog_articles/235/how-to-send-a-package-from-vietnam.jpg" alt="Placeholder image">
                            </figure>
                        </div>
                        <div class="card-content">
                            <div class="media">
                                <div class="media-content">
                                    <p class="title is-4 has-text-centered">On time Delivery</p>
                                    <p>Shipment will come on time every time! And if we miss our timing we will even give you a discount on your next purchase.</p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>
<section class="hero is-primary is-fullheight is-bold">
    <div class="hero-body">
        <div class="container">
            <h1 class="title">
                What are you waiting for?
            </h1>
            <a href="../Products/" class="button">Click here to start shopping now!</a>
        </div>
    </div>
</section>
<section class="hero is-dark is-bold">
    <div class="hero-body">
        <p>Disclaimer all of this is fake so..... take it with a grain of salt</p>
    </div>
</section>
</body>
</html>

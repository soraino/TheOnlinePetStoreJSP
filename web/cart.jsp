<%--
  Created by IntelliJ IDEA.
  User: lolsp
  Date: 6/3/2019
  Time: 1:46 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<html>
<jsp:include page="header.html"></jsp:include>
<style>
    .spinner {
        width: 40px;
        height: 40px;

        position: relative;
        margin: 100px auto;
    }

    .double-bounce1, .double-bounce2 {
        width: 100%;
        height: 100%;
        border-radius: 50%;
        background-color: #ffffff;
        opacity: 0.6;
        position: absolute;
        top: 0;
        left: 0;

        -webkit-animation: sk-bounce 2.0s infinite ease-in-out;
        animation: sk-bounce 2.0s infinite ease-in-out;
    }

    .double-bounce2 {
        -webkit-animation-delay: -1.0s;
        animation-delay: -1.0s;
    }

    @-webkit-keyframes sk-bounce {
        0%, 100% { -webkit-transform: scale(0.0) }
        50% { -webkit-transform: scale(1.0) }
    }

    @keyframes sk-bounce {
        0%, 100% {
            transform: scale(0.0);
            -webkit-transform: scale(0.0);
        } 50% {
              transform: scale(1.0);
              -webkit-transform: scale(1.0);
          }
    }
</style>
<body>
<jsp:include page="navbar.jsp"></jsp:include>
<div class="container" id="app">
    <%
        if(session.getAttribute("Username") != null){
    %>
    <table class="table is-bordered is-striped is-narrow is-hoverable is-fullwidth">
        <thead>
        <tr>
            <th>Image</th>
            <th>Item Name</th>
            <th><abbr title="Quantity">qty</abbr></th>
            <th>Price</th>
        </tr>
        </thead>
        <tfoot>
        <tr>
            <th></th>
            <th></th>
            <th></th>
            <th>Total: S$ {{total}}</th>
        </tr>
        </tfoot>
        <tbody>
        <tr v-for="item in cart">
            <th><img :src="item.image" class="image is-128x128"></th>
            <th>{{item.name}}</th>
            <th>{{item.qty}}</th>
            <th>{{item.price}}</th>
        </tr>
        </tbody>
    </table>
    <button id="customButton" type="button" @click="openStripe">Purchase</button>
    <div class="modal" :class="{'is-active':isLoading}">
        <div class="modal-background"></div>
        <div class="modal-content">
            <div class="spinner">
                <div class="double-bounce1"></div>
                <div class="double-bounce2"></div>
            </div>
            <p class="has-text-centered has-text-white">Finalizing payment</p>
        </div>
    </div>
</div>
</body>
<script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>
<script src="https://www.gstatic.com/firebasejs/5.8.5/firebase-app.js"></script>
<script src="https://www.gstatic.com/firebasejs/5.8.5/firebase-database.js"></script>
<script src="https://www.gstatic.com/firebasejs/5.8.5/firebase.js"></script>
<script src="https://checkout.stripe.com/checkout.js"></script>
<script src="https://unpkg.com/axios/dist/axios.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@8"></script>
<script>
    const app = new Vue({
        el: '#app',
        data: {
            cart: [],
            token: '',
            handler: null,
            amount: 0,
            isLoading: false,
        },
        methods: {
            openStripe() {
                this.handler.open({
                    name: 'OnlinePetstore',
                    description: 'Some Stuff',
                    currency: 'sgd',
                    amount: this.amount
                })
            }
        },
        computed:{
            total(){
                let sum = 0
                for(i = 0 ; i < this.cart.length; i++){
                    sum+= this.cart[i].price * this.cart[i].qty
                }
                return sum.toFixed(2)
            },
            totalAmount(){
                let sum = 0
                for(i = 0 ; i < this.cart.length; i++){
                    sum+= this.cart[i].price * this.cart[i].qty
                }
                return sum.toFixed(2)*100
            }
        },
        mounted() {
            const config = {
                apiKey: " AIzaSyC3lPK-3Y5O_OUdUoDW57tBVZeYNmzEx2o ",
                authDomain: "theonlinepetstore-f196f.firebaseapp.com",
                databaseURL: "https://theonlinepetstore-f196f.firebaseio.com/",
                projectId: "theonlinepetstore-f196f",
            }
            firebase.initializeApp(config);

            const database = firebase.database().ref('Cart/<%=session.getAttribute("Username")%>')
            database.on("value", function(snapshot){
                const idIndexs = {}
                app.cart = []
                for(key in snapshot.val()){
                    snapshot.val()[key]
                    if(idIndexs[snapshot.val()[key].id] == null){
                        index = app.cart.push({
                            image:snapshot.val()[key].image,
                            name: snapshot.val()[key].name,
                            price: snapshot.val()[key].price,
                            qty: 1,
                        }) - 1
                        idIndexs[snapshot.val()[key].id] = {'index': index};
                    }else{
                        app.cart[idIndexs[snapshot.val()[key].id].index].qty++
                    }
                }
            })

            this.handler = StripeCheckout.configure({
                key: 'pk_test_Z96vEceUYd9om0Oy8dfXq6xh',
                image: 'https://stripe.com/img/documentation/checkout/marketplace.png',
                locale: 'auto',
                token: async function (token) {
                    const params = new URLSearchParams()
                    params.append('stripeToken', token.id)
                    params.append('amount', app.totalAmount)
                    try {
                        app.isLoading = true
                        const response = await axios.post('../Checkout',
                            params,
                            {headers: {'content-type': 'application/x-www-form-urlencoded'}},
                        )
                        const database = await firebase.database().ref('Cart/<%=session.getAttribute("Username")%>').remove()
                        app.isLoading = false
                        Swal.fire(
                            'Success',
                            'All items has been purchased.Thanks for doing business!',
                            'Success'
                        )
                    } catch {
                        app.isLoading = false
                        Swal.fire(
                            'Error',
                            'Something when wrong in the server, try again later.',
                            'error'
                        )
                    }
                }
            })
            window.addEventListener('popstate', function () {
                this.handler.close();
            });
        }
    })
</script>
<%
    }else{
            response.sendRedirect("./login.jsp");
    }
%>
</html>

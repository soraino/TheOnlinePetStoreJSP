<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Iterator" %><%--
  Created by IntelliJ IDEA.
  User: lolsp
  Date: 11/3/2019
  Time: 4:00 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<jsp:include page="../../header.html"></jsp:include>
<body>
<jsp:include page="../../adminnavbar.jsp"></jsp:include>
<div class="container">
    <form method="post" action="../../Admin/createProduct">
        <div class="field">
            <label class="label">Brand Name</label>
            <div class="control">
                <input class="input" type="text" placeholder="Product Name" name="Name" required>
            </div>
        </div>
        <div class="field">
            <label class="label">Description</label>
            <div class="control">
                <textarea class="textarea" name="Description"></textarea>
            </div>
        </div>
        <div class="field">
            <label class="label">Category</label>
            <div class="select">
                <select name="CategoryId">
                    <%
                        HashMap<Integer, String> categories = (HashMap<Integer, String>) session.getAttribute("categories");
                        for (String category : categories.values()) {
                    %>
                    <option value="<%=getKey(categories,category)%>"><%=category%>
                    </option>
                    <%
                        }
                    %>
                </select>
            </div>
        </div>
        <div class="field">
            <label class="label">Brand</label>
            <div class="select">
                <select name="BrandId">
                    <%
                        HashMap<Integer, String> brands = (HashMap<Integer, String>) session.getAttribute("brands");
                        for (String brand : brands.values()) {
                    %>
                    <option value="<%=getKey(brands,brand)%>"><%=brand%>
                    </option>
                    <%
                        }
                    %>
                </select>
            </div>
        </div>
        <div class="field">
            <label class="label">Price</label>
            <div class="control">
                <input class="input" type="number" placeholder="Price" name="Price" step="0.01" min="0.01" required>
            </div>
        </div>
        <div id="app">

            <label class="label">Images</label>
            <div class="columns is-multiline">
                <div class="column" v-for="(imageUrl,index) in imageUrls">
                    <img :src="imageUrl.url" class="image"/>
                </div>
            </div>
            <div class="field has-addons" v-for="(imageUrl,index) in imageUrls">
                <div class="control is-expanded">
                    <div>
                        <input class="input" type="text" v-model="imageUrl.url" placeholder="Image URL" required>
                    </div>
                </div>
                <div class="control">
                    <button class="button" @click="imageUrls = imageUrls.splice(index,1)" type="button">
                        -
                    </button>
                </div>
            </div>
            <input type="hidden" v-model="imageUrlCombine" name="Images"/>
            <input type="button" value="add more image" class="button is-info" @click="imageUrls.push({url:''})"/>
        </div>
        <button type="submit" class="button is-success" style="float:right; margin-bottom:  50px;">Submit</button>
    </form>
</div>
</body>
<script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>
<script src="https://unpkg.com/axios/dist/axios.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@8"></script>
<script>
    new Vue({
        el: '#app',
        data: {
            imageUrls: [
                {url: ''}
            ]
        },
        computed: {
            imageUrlCombine() {
                return this.imageUrls.reduce((acc, curr) => {
                    return acc += curr.url + ' &%& '
                }, '')
            },
            images() {
                return this.imageUrls.reduce((acc, curr) => {
                    let img = '';
                    if (curr.url.includes('https:\/\/') || curr.url.includes('http:\/\/'))
                        img = curr.url
                    else
                        img = 'https://upload.wikimedia.org/wikipedia/commons/thumb/1/15/No_image_available_600_x_450.svg/600px-No_image_available_600_x_450.svg.png'
                    acc.push('<div><img class="center" src="' + img + '" width=""></div>')
                    return acc
                }, [])
            },
        },
        mounted() {
            const url = new URL(window.location)
            if (url.searchParams.has('productError')) {
                Swal.fire(
                    'Error',
                    'Something when wrong in the server, Product is not created.',
                    'error'
                )
            } else if (url.searchParams.has('brandError')) {
                Swal.fire(
                    'Error',
                    'Something when wrong in the server, brand is added created.',
                    'error'
                )
            } else if (url.searchParams.has('imagesError')) {
                Swal.fire(
                    'Error',
                    'Something when wrong in the server, not all images are added created.',
                    'error'
                )
            }
        },
    })
</script>
</html>
<%!
    // get the key of the hashtable based on the value
    public int getKey(HashMap<Integer, String> table, String value) {
        Iterator<Integer> keys = table.keySet().iterator();
        while (keys.hasNext()) {
            int catId = keys.next();
            if (table.get(catId).equals(value)) {
                return catId;
            }
        }
        return -1;
    }
%>

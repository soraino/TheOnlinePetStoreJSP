<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="Bean.ProductBean" %>
<%@ page import="java.util.List" %>
<%@ page import="Bean.ImageBean" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<jsp:include page="../../header.html"></jsp:include>
<body>
<jsp:include page="../../adminnavbar.jsp"></jsp:include>
<%
    if (session.getAttribute("AdminUser") == null) {
        response.sendRedirect("../../../Admin/");
    } else {
        List<ProductBean> products = (List<ProductBean>) session.getAttribute("products");
        ProductBean product = products.get(Integer.parseInt(request.getParameter("id")));
%>
<div class="container" id="app">
    <form method="post" action="../../Admin/UpdateProductServlet?id=<%=product.getProductId()%>">
        <div class="field">
            <label class="label">Brand Name</label>
            <div class="control">
                <input class="input" type="text" placeholder="Product Name" name="Name" value="<%=product.getName()%>"
                       required>
            </div>
        </div>
        <div class="field">
            <label class="label">Description</label>
            <div class="control">
                <textarea class="textarea" name="Description" v-model="description"></textarea>
            </div>
        </div>
        <div class="field">
            <label class="label">Category</label>
            <div class="select">
                <select name="CategoryId">
                    <%
                        HashMap<Integer, String> categories = (HashMap<Integer, String>) session.getAttribute("categories");
                        for (String category : categories.values()) {
                            if (category.equalsIgnoreCase(categories.get(product.getCategoryId()))) {
                    %>
                    <option value="<%=getKey(categories,category)%>" selected><%=category%>
                    </option>
                    <%
                    } else {
                    %>
                    <option value="<%=getKey(categories,category)%>"><%=category%>
                    </option>
                    <%
                            }
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
                            if (brand.equalsIgnoreCase(brands.get(product.getBrandId()))) {
                    %>
                    <option value="<%=getKey(brands,brand)%>" selected><%=brand%>
                    </option>
                    <%
                    } else {
                    %>
                    <option value="<%=getKey(brands,brand)%>"><%=brand%>
                    </option>
                    <%
                            }
                        }
                    %>
                </select>
            </div>
        </div>
        <div class="field">
            <label class="label">Price</label>
            <div class="control">
                <input class="input" type="number" placeholder="Price" name="Price" step="0.01" min="0.01"
                       value="<%=product.getPrice()%>" required>
            </div>
        </div>
        <div>
            <label class="label">Images</label>
            <div class="columns is-multiline">
                <div class="column" v-for="(imageUrl,index) in imageUrls">
                    <img :src="imageUrl.url" class="image"/>
                </div>
            </div>
            <div class="field has-addons" v-for="(imageUrl,index) in imageUrls">
                <div class="control is-expanded">
                    <div>
                        <input class="input" type="text" v-model="imageUrl.url" placeholder="Image URL"
                               :disabled="imageUrl.id != -1 " required>
                    </div>
                </div>
                <div class="control">
                    <button class="button" @click="removeImage(index,imageUrl.id)" type="button">
                        -
                    </button>
                </div>
            </div>
            <input type="hidden" v-model="imageUrlCombine" name="Images"/>
            <input type="hidden" v-model="removedImages" name="RemovedImages"/>
            <input type="hidden" name="oldCategory" value="<%=product.getCategoryId()%>"/>
            <input type="hidden" name="oldBrand" value="<%=product.getBrandId()%>"/>
            <input type="button" value="add more image" class="button is-info" @click="imageUrls.push({url:'',id:-1})"/>
        </div>
        <button type="submit" class="button is-success" style="float:right; margin-bottom:  50px;">Submit</button>
        <button type="button" class="button is-danger" style="float:right; margin-bottom:  50px;"
                @click="deleteProduct">Delete
        </button>
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
            description: '<%=product.getDescription()%>',
            imageUrls: [
                <%
                    for(ImageBean image : product.getImages()){
                %>
                {id:<%=image.getImageId()%>, url: '<%=image.getImageUrl()%>'},
                <%
                    }
                %>

            ],
            removedImg: [],
        },
        methods: {
            removeImage(index, id) {
                if (id != -1)
                    this.removedImg.push(id)
                this.imageUrls.splice(index, 1)
            },
            async deleteProduct() {
                try {
                    const response = await axios.delete('../../../ProductServlet?id=<%=product.getProductId()%>')
                    window.location.replace('../../../ProductServlet?sendRedirect=../../Admin/Products')
                } catch {
                    Swal.fire(
                        'Error',
                        'Something when wrong in the server, product is not deleted.',
                        'error'
                    )
                }

            }
        },
        computed: {
            imageUrlCombine() {
                return this.imageUrls.reduce((acc, curr) => {
                    if(curr.id == -1){
                        acc += curr.url + ' &%& '
                    }
                    return acc
                }, '')
            },
            removedImages() {
                return this.removedImg.reduce((acc, curr) => {
                    return acc += curr + ' &%& '
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
                    'Something when wrong in the server, product is not updated.',
                    'error'
                )
            } else if (url.searchParams.has('imageError')) {
                Swal.fire(
                    'Error',
                    'Something when wrong in the server, product image is not updated.',
                    'error'
                )
            }
        },
    })
</script>
<%
    }
%>
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
